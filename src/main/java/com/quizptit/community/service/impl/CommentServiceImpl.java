package com.quizptit.community.service.impl;

import com.quizptit.community.dto.CommentRequest;
import com.quizptit.community.dto.CommentResponse;
import com.quizptit.community.entity.Comment;
import com.quizptit.community.entity.QuestionPost;
import com.quizptit.community.exception.ResourceNotFoundException;
import com.quizptit.community.repository.CommentRepository;
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
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CommentServiceImpl implements CommentService {

    private final CommentRepository commentRepository;
    private final QuestionPostRepository questionPostRepository;
    private final UserRepository userRepository;
    private final ModerationRecordService moderationRecordService;

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

        commentRepository.saveAndFlush(comment); // Lưu comment mới trước

        // CẬP NHẬT SỐ LƯỢNG SAU KHI THÊM
        long visibleCount = commentRepository.countByQuestionPost_QuestionPostIdAndStatus(postId, "VISIBLE");
        post.setCommentCount((int) visibleCount);
        questionPostRepository.saveAndFlush(post);

        // Trong hàm addComment, trước khi return mapToResponse...
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
        boolean isAdmin = "ADMIN".equals(userRole);

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

        String normalizedStatus = normalizeCommentStatus(status);
        String moderationAction = mapModerationAction(normalizedStatus);

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
    public java.util.Optional<Comment> findById(Long id) {
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

        if ("DELETED".equals(value)) {
            return "HIDDEN";
        }

        if ("VISIBLE".equals(value) || "HIDDEN".equals(value)) {
            return value;
        }

        return "HIDDEN";
    }

    private String mapModerationAction(String status) {
        if ("VISIBLE".equalsIgnoreCase(status)) {
            return "RESTORE";
        }
        if ("HIDDEN".equalsIgnoreCase(status)) {
            return "HIDE";
        }
        return "HIDE";
    }

    private CommentResponse mapToResponse(Comment comment) {
        if (comment == null) return null;

        var responseBuilder = CommentResponse.builder()
                .commentId(comment.getCommentId())
                .status(comment.getStatus())
                .postId(comment.getQuestionPost() != null ? comment.getQuestionPost().getQuestionPostId() : null)
                .createdAt(comment.getCreatedAt())
                .parentId(comment.getParentComment() != null ? comment.getParentComment().getCommentId() : null)
                .userId(comment.getUser().getUserId())
                .email(comment.getUser().getEmail())
                .userFullName(comment.getUser().getFullName());

        if ("VISIBLE".equals(comment.getStatus())) {
            responseBuilder.content(comment.getContent());
        } else if ("HIDDEN".equals(comment.getStatus())) {
            String type = (comment.getParentComment() == null) ? "Bình luận" : "Phản hồi";
            responseBuilder.content(type + " này đã bị ẩn bởi quản trị viên");
        } else {
            responseBuilder.content("Bình luận này đã bị ẩn");
        }

        CommentResponse response = responseBuilder.build();

        if (comment.getReplies() != null && !comment.getReplies().isEmpty()) {
            List<CommentResponse> replyDtos = comment.getReplies().stream()
                    .map(this::mapToResponse)
                    .collect(Collectors.toList());
            response.setReplies(replyDtos);
        } else {
            response.setReplies(new ArrayList<>());
        }

        return response;
    }
}