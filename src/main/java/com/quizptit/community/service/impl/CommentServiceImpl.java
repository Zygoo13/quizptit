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
        // Không dùng filter ở đây để tránh làm đứt mạch cây bình luận
        return commentRepository.findByQuestionPost_QuestionPostIdAndParentCommentIsNullOrderByCreatedAtDesc(postId)
                .stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    // --- HÀM 2: DÙNG CHO ADMIN (HOẶC HỆ THỐNG - HÀM ĐANG BÁO LỖI THIẾU) ---
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


    // ------------------ CHỈ SỬA DELETE THEO FACEBOOK ------------------
    @Override
    @Transactional
    public void deleteComment(Long commentId, Long userId, String userRole) {
        // 1. Lấy comment
        Comment comment = commentRepository.findById(commentId)
                .orElseThrow(() -> new ResourceNotFoundException("Bình luận không tồn tại"));

        boolean isOwner = comment.getUser().getUserId().equals(userId);
        boolean isAdmin = "ADMIN".equals(userRole);

        if (!isOwner && !isAdmin) {
            throw new SecurityException("Bạn không có quyền xóa bình luận này");
        }

        // 2. Xóa mềm comment chính
        comment.setStatus("DELETED");
        commentRepository.saveAndFlush(comment);

        // 3. Nếu là comment gốc, xóa mềm tất cả reply con bằng query trực tiếp
        if (comment.getParentComment() == null) {
            commentRepository.softDeleteRepliesByParentId(comment.getCommentId());
        }

        // 4. Cập nhật lại số lượng comment VISIBLE
        Long postId = comment.getQuestionPost().getQuestionPostId();
        long visibleCount = commentRepository.countByQuestionPost_QuestionPostIdAndStatus(postId, "VISIBLE");

        QuestionPost post = questionPostRepository.findById(postId)
                .orElseThrow(() -> new ResourceNotFoundException("Post không tồn tại"));
        post.setCommentCount((int) visibleCount);
        questionPostRepository.saveAndFlush(post);

        // 5. Đồng bộ thêm nếu có hàm sync
        syncCommentCount(postId);
    }

    @Override
    @Transactional
    public CommentResponse addCommentByEmail(Long postId, String email, CommentRequest request) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy người dùng"));

        // Sửa lại để nhận về CommentResponse từ hàm addComment
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
    public void updateCommentStatus(Long commentId, String action, String reason, Long adminId) {
        Comment comment = commentRepository.findById(commentId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy bình luận"));

        // Cập nhật status dựa trên action truyền từ Controller (HIDDEN, VISIBLE, hoặc DELETED)
        comment.setStatus(action);

        // Nếu là xóa (DELETED) và là comment gốc, thì xóa luôn đám con
        if ("DELETED".equals(action) && comment.getParentComment() == null) {
            commentRepository.softDeleteRepliesByParentId(comment.getCommentId());
        }

        commentRepository.save(comment);

        // Lưu log (nhớ bọc try-catch nếu bảng log chưa ổn định để tránh lỗi 500)
        try {
            moderationRecordService.logCommentModeration(commentId, adminId, action, reason);
        } catch (Exception e) {
            System.err.println("Lỗi lưu log: " + e.getMessage());
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
        // Lấy tất cả, không phân biệt cha con hay trạng thái để Admin quản lý tổng thể
        return commentRepository.findAll().stream()
                .map(this::mapToResponse) // Dùng hàm mapToResponse bạn đã viết rất chuẩn rồi
                .collect(Collectors.toList());
    }

    @Transactional
    public void syncCommentCount(Long postId) {
        // Đếm những comment thực sự là gốc (parentId is null) và VISIBLE
        // Hoặc nếu bạn muốn đếm cả reply thì giữ nguyên nhưng phải đảm bảo xóa cả con (như mình đã chỉ)
        long visibleCount = commentRepository.countByQuestionPost_QuestionPostIdAndStatus(postId, "VISIBLE");

        QuestionPost post = questionPostRepository.findById(postId).get();
        post.setCommentCount((int) visibleCount);
        questionPostRepository.saveAndFlush(post);

        // In ra để nhìn tận mắt trong console
        System.out.println("FIX_COUNT_LOG: PostID " + postId + " -> Số thực trong DB là: " + visibleCount);
    }

    // Chuyển Entity -> DTO
    private CommentResponse mapToResponse(Comment comment) {
        if (comment == null) return null;

        var responseBuilder = CommentResponse.builder()
                .commentId(comment.getCommentId())
                .status(comment.getStatus())
                .postId(comment.getQuestionPost() != null ? comment.getQuestionPost().getQuestionPostId() : null)
                .createdAt(comment.getCreatedAt())
                .parentId(comment.getParentComment() != null ? comment.getParentComment().getCommentId() : null);

        // LOGIC HIỂN THỊ NỘI DUNG
        if ("VISIBLE".equals(comment.getStatus())) {
            responseBuilder.content(comment.getContent())
                    .userId(comment.getUser().getUserId())
                    .email(comment.getUser().getEmail())
                    .userFullName(comment.getUser().getFullName());
        }
        else if ("HIDDEN".equals(comment.getStatus())) {
            String type = (comment.getParentComment() == null) ? "Bình luận" : "Phản hồi";
            responseBuilder.content(type + " này đã bị ẩn bởi quản trị viên")
                    .userFullName("Thông báo hệ thống").userId(0L).email("system@quizptit.com");
        }
        // THÊM ĐOẠN NÀY: Để giữ chỗ cho các reply con hiện ra
        else if ("DELETED".equals(comment.getStatus())) {
            responseBuilder.content("Bình luận này đã bị xóa")
                    .userFullName("Thông báo hệ thống").userId(0L).email("system@quizptit.com");
        }

        CommentResponse response = responseBuilder.build();

        // XỬ LÝ ĐỆ QUY CHO REPLY
        if (comment.getReplies() != null && !comment.getReplies().isEmpty()) {
            List<CommentResponse> replyDtos = comment.getReplies().stream()
                    // CŨNG BỎ FILTER DELETED Ở ĐÂY để hiện đủ cây phản hồi
                    .map(this::mapToResponse)
                    .collect(Collectors.toList());
            response.setReplies(replyDtos);
        } else {
            response.setReplies(new ArrayList<>());
        }

        return response;
    }
}