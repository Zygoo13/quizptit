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
@RequiredArgsConstructor // Tự động tạo Constructor cho các final field (thay cho constructor tay)
public class CommentServiceImpl implements CommentService {

    private final CommentRepository commentRepository;
    private final QuestionPostRepository questionPostRepository;
    private final UserRepository userRepository;
    private final ModerationRecordService moderationRecordService;

    @Override
    @Transactional
    public CommentResponse addComment(Long postId, Long userId, CommentRequest request) {
        // 1. Kiểm tra User tồn tại
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Người dùng không tồn tại ID: " + userId));

        // 2. Kiểm tra bài viết tồn tại
        QuestionPost post = questionPostRepository.findById(postId)
                .orElseThrow(() -> new ResourceNotFoundException("Bài viết không tồn tại ID: " + postId));

        // 3. Sử dụng Builder để tạo Entity (Nhớ thêm @Builder ở file Comment.java)
        Comment comment = Comment.builder()
                .content(request.getContent())
                .user(user)
                .questionPost(post)
                .status("VISIBLE")
                .build();

        Comment savedComment = commentRepository.save(comment);

        // 4. Trả về Response DTO thông qua hàm map phụ
        return mapToResponse(savedComment);
    }

    @Override
    @Transactional
    public CommentResponse updateComment(Long commentId, CommentRequest request, Long userId) {
        // 1. Tìm comment
        Comment comment = commentRepository.findById(commentId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy bình luận"));

        // 2. Kiểm tra chính chủ (Không cho phép Admin sửa nội dung của user, chỉ cho phép Xóa/Ẩn)
        if (!comment.getUser().getUserId().equals(userId)) {
            throw new SecurityException("Bạn không có quyền chỉnh sửa bình luận này!");
        }

        // 3. Cập nhật nội dung
        comment.setContent(request.getContent());
        // Có thể thêm field updatedAt nếu bạn có dùng

        return mapToResponse(commentRepository.save(comment));
    }

    @Override
    @Transactional(readOnly = true)
    public List<CommentResponse> getPublicCommentsByPost(Long postId) {
        // 1. Kiểm tra trạng thái của bài viết trước
        QuestionPost post = questionPostRepository.findById(postId)
                .orElseThrow(() -> new ResourceNotFoundException("Bài viết không tồn tại"));

        // 2. Nếu bài viết đã bị Xóa hoặc đang bị Ẩn -> Trả về danh sách trống (BR-40)
        if (!"VISIBLE".equals(post.getStatus())) {
            return new ArrayList<>();
        }

        // 3. Nếu bài viết OK, lấy tất cả comment của bài đó
        return commentRepository.findByQuestionPost_QuestionPostIdAndStatus(postId, "VISIBLE")
                .stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void deleteComment(Long commentId, Long userId, String userRole) {
        Comment comment = commentRepository.findById(commentId)
                .orElseThrow(() -> new ResourceNotFoundException("Bình luận không tồn tại ID: " + commentId));

        // Kiểm tra quyền: Chỉ chính chủ hoặc Admin mới được xóa
        boolean isOwner = comment.getUser().getUserId().equals(userId);
        boolean isAdmin = "ADMIN".equals(userRole);

        if (!isOwner && !isAdmin) {
            throw new RuntimeException("Bạn không có quyền xóa bình luận này");
        }

        commentRepository.delete(comment);
    }

    @Override
    @Transactional
    public void updateCommentStatus(Long commentId, String action, String reason, Long adminId) {
        Comment comment = commentRepository.findById(commentId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy bình luận ID: " + commentId));

        // Update status của comment (ví dụ action là HIDDEN)
        comment.setStatus(action);
        commentRepository.save(comment);

        // Lưu vết vào lịch sử kiểm duyệt
        moderationRecordService.logCommentModeration(commentId, adminId, action, reason);
    }

    /**
     * Hàm phụ để chuyển đổi từ Entity sang DTO.
     * Giúp tránh lỗi Lazy Loading và lỗi vòng lặp JSON (Infinite Recursion).
     */
    private CommentResponse mapToResponse(Comment comment) {
        return CommentResponse.builder()
                .commentId(comment.getCommentId())
                .content(comment.getContent())
                .postId(comment.getQuestionPost().getQuestionPostId())
                .userId(comment.getUser().getUserId())
                .userFullName(comment.getUser().getFullName())
                .createdAt(comment.getCreatedAt())
                .build();
    }
}