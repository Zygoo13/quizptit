package com.quizptit.community.service.impl;

import com.quizptit.community.dto.CommentRequest;
import com.quizptit.community.dto.CommentResponse;
import com.quizptit.community.entity.Comment;
import com.quizptit.community.entity.ModerationRecord;
import com.quizptit.community.entity.QuestionPost;
import com.quizptit.community.exception.ResourceNotFoundException;
import com.quizptit.community.repository.CommentRepository;
import com.quizptit.community.repository.ModerationRecordRepository;
import com.quizptit.community.repository.QuestionPostRepository;
import com.quizptit.community.service.CommentService;
import com.quizptit.community.service.ModerationRecordService;
import com.quizptit.user.entity.User;
import com.quizptit.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CommentServiceImpl implements CommentService {

    private final CommentRepository commentRepository;
    private final QuestionPostRepository questionPostRepository;
    private final UserRepository userRepository;
    private final ModerationRecordService moderationRecordService;
    private final ModerationRecordRepository moderationRecordRepository;

    @Override
    @Transactional
    public CommentResponse addComment(Long postId, Long userId, CommentRequest request) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Người dùng không tồn tại"));

        QuestionPost post = questionPostRepository.findById(postId)
                .orElseThrow(() -> new ResourceNotFoundException("Bài viết không tồn tại"));

        Comment parentComment = null;
        if (request.getParentId() != null) {
            parentComment = commentRepository.findById(request.getParentId())
                    .orElseThrow(() -> new ResourceNotFoundException("Bình luận cha không tồn tại"));
        }

        Comment comment = Comment.builder()
                .content(request.getContent())
                .user(user)
                .questionPost(post)
                .parentComment(parentComment)
                .status("VISIBLE")
                .build();

        commentRepository.saveAndFlush(comment);
        syncCommentCount(postId);

        return mapToResponse(comment);
    }

    @Override
    @Transactional(readOnly = true)
    public List<CommentResponse> getPublicCommentsByPost(Long postId) {
        if (!questionPostRepository.existsById(postId)) {
            throw new ResourceNotFoundException("Bài viết không tồn tại");
        }

        return commentRepository.findByQuestionPost_QuestionPostIdAndParentCommentIsNullOrderByCreatedAtDesc(postId)
                .stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    public List<CommentResponse> getAllCommentsByPost(Long postId) {
        if (!questionPostRepository.existsById(postId)) {
            throw new ResourceNotFoundException("Bài viết không tồn tại");
        }

        return commentRepository.findByQuestionPost_QuestionPostIdAndParentCommentIsNullOrderByCreatedAtDesc(postId)
                .stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public CommentResponse updateComment(Long commentId, CommentRequest request, String email) {
        Comment comment = commentRepository.findById(commentId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy bình luận"));

        if (!comment.getUser().getEmail().equals(email)) {
            throw new SecurityException("Bạn không có quyền sửa bình luận này!");
        }

        if (!"VISIBLE".equals(comment.getStatus())) {
            throw new IllegalStateException("Không thể sửa bình luận đã bị ẩn hoặc xóa");
        }

        if (request.getContent() != null && !request.getContent().isBlank()) {
            comment.setContent(request.getContent());
            comment = commentRepository.save(comment);
        }

        return mapToResponse(comment);
    }

    @Override
    @Transactional
    public void deleteComment(Long commentId, Long userId, String userRole) {
        Comment comment = commentRepository.findById(commentId)
                .orElseThrow(() -> new ResourceNotFoundException("Bình luận không tồn tại"));

        boolean isOwner = comment.getUser().getUserId().equals(userId);
        boolean isAdmin = "ADMIN".equalsIgnoreCase(userRole) || "ROLE_ADMIN".equalsIgnoreCase(userRole);

        if (!isOwner && !isAdmin) {
            throw new SecurityException("Bạn không có quyền xóa bình luận này");
        }

        comment.setStatus("HIDDEN");
        commentRepository.saveAndFlush(comment);

        if (comment.getParentComment() == null) {
            commentRepository.softDeleteRepliesByParentId(comment.getCommentId());
        }

        syncCommentCount(comment.getQuestionPost().getQuestionPostId());
    }

    @Override
    @Transactional
    public CommentResponse addCommentByEmail(Long postId, String email, CommentRequest request) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy người dùng"));

        return addComment(postId, user.getUserId(), request);
    }

    @Override
    @Transactional
    public void deleteCommentByEmail(Long commentId, String email) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy người dùng"));

        deleteComment(commentId, user.getUserId(), "USER");
    }

    @Override
    @Transactional
    public void updateCommentStatus(Long commentId, String status, String reason, Long adminId) {
        Comment comment = commentRepository.findById(commentId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy bình luận"));

        String requestedStatus = status == null ? "" : status.trim().toUpperCase();
        String normalizedStatus = normalizeCommentStatus(status);

        String moderationAction;
        if ("DELETED".equals(requestedStatus) || "DELETE".equals(requestedStatus)) {
            moderationAction = "DELETE";
        } else if ("VISIBLE".equals(requestedStatus)) {
            moderationAction = "RESTORE";
        } else {
            moderationAction = "HIDE";
        }

        comment.setStatus(normalizedStatus);

        if ("HIDDEN".equals(normalizedStatus) && comment.getParentComment() == null) {
            commentRepository.softDeleteRepliesByParentId(comment.getCommentId());
        }

        commentRepository.saveAndFlush(comment);

        try {
            moderationRecordService.logCommentModeration(commentId, adminId, moderationAction, reason);
        } catch (Exception e) {
            System.err.println("Lỗi lưu nhật ký kiểm duyệt bình luận: " + e.getMessage());
        }

        syncCommentCount(comment.getQuestionPost().getQuestionPostId());
    }

    @Override
    @Transactional
    public void update(Long id, Comment comment) {
        Comment existing = commentRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Bình luận không tồn tại"));

        existing.setContent(comment.getContent());
        commentRepository.save(existing);
    }

    @Override
    public Optional<Comment> findById(Long id) {
        return commentRepository.findById(id);
    }

    @Override
    public List<CommentResponse> getAllCommentsForAdmin() {
        return commentRepository.findAll().stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    @Transactional
    public void syncCommentCount(Long postId) {
        long visibleCount = commentRepository.countByQuestionPost_QuestionPostIdAndStatus(postId, "VISIBLE");

        QuestionPost post = questionPostRepository.findById(postId)
                .orElseThrow(() -> new ResourceNotFoundException("Bài viết không tồn tại"));

        post.setCommentCount((int) visibleCount);
        questionPostRepository.saveAndFlush(post);
    }

    private String normalizeCommentStatus(String status) {
        if (status == null || status.isBlank()) {
            return "HIDDEN";
        }

        String value = status.trim().toUpperCase();

        if ("VISIBLE".equals(value)) {
            return "VISIBLE";
        }

        if ("HIDDEN".equals(value) || "DELETED".equals(value) || "DELETE".equals(value)) {
            return "HIDDEN";
        }

        return "HIDDEN";
    }

    private CommentResponse mapToResponse(Comment comment) {
        if (comment == null) {
            return null;
        }

        String hiddenType = resolveHiddenType(comment);
        String displayContent = resolveDisplayContent(comment, hiddenType);

        CommentResponse response = CommentResponse.builder()
                .commentId(comment.getCommentId())
                .status(comment.getStatus())
                .hiddenType(hiddenType)
                .postId(comment.getQuestionPost() != null ? comment.getQuestionPost().getQuestionPostId() : null)
                .createdAt(comment.getCreatedAt())
                .updatedAt(comment.getUpdatedAt())
                .parentId(comment.getParentComment() != null ? comment.getParentComment().getCommentId() : null)
                .userId(comment.getUser() != null ? comment.getUser().getUserId() : null)
                .email(comment.getUser() != null ? comment.getUser().getEmail() : null)
                .userFullName(comment.getUser() != null ? comment.getUser().getFullName() : null)
                .content(displayContent)
                .replies(new ArrayList<>())
                .build();

        if (comment.getReplies() != null && !comment.getReplies().isEmpty()) {
            List<CommentResponse> replyDtos = comment.getReplies().stream()
                    .map(this::mapToResponse)
                    .collect(Collectors.toList());
            response.setReplies(replyDtos);
        }

        return response;
    }

    private String resolveHiddenType(Comment comment) {
        if (comment == null || "VISIBLE".equalsIgnoreCase(comment.getStatus())) {
            return "VISIBLE";
        }

        Optional<ModerationRecord> latestRecord = moderationRecordRepository
                .findTopByTargetTypeAndTargetIdOrderByCreatedAtDesc("COMMENT", comment.getCommentId());

        if (latestRecord.isPresent()) {
            String action = latestRecord.get().getAction();
            if ("DELETE".equalsIgnoreCase(action)) {
                return "ADMIN_DELETED";
            }
            if ("HIDE".equalsIgnoreCase(action)) {
                return "ADMIN_HIDDEN";
            }
        }

        return "SELF_DELETED";
    }

    private String resolveDisplayContent(Comment comment, String hiddenType) {
        if (comment == null) {
            return "";
        }

        if ("VISIBLE".equalsIgnoreCase(comment.getStatus())) {
            return comment.getContent();
        }

        return switch (hiddenType) {
            case "ADMIN_HIDDEN" -> "Bình luận đã bị ẩn bởi quản trị viên";
            case "ADMIN_DELETED" -> "Bình luận đã bị xóa bởi quản trị viên";
            case "SELF_DELETED" -> "Người dùng đã xóa bình luận này";
            default -> "Bình luận này không còn khả dụng";
        };
    }
}