package com.quizptit.community.service;

import com.quizptit.community.dto.CommentRequest;
import com.quizptit.community.dto.CommentResponse;
import java.util.List;

public interface CommentService {

    // BR-33, 36: Thêm bình luận (Dùng RequestDTO đầu vào, ResponseDTO đầu ra)
    CommentResponse addComment(Long postId, Long userId, CommentRequest request);

    // BR-40: Lấy danh sách bình luận công khai của một bài viết
    List<CommentResponse> getPublicCommentsByPost(Long postId);

    // BR-37: Xóa bình luận (Chính chủ hoặc Admin)
    void deleteComment(Long commentId, Long userId, String userRole);

    // BR-37: Cập nhật bình luận (Hàm mới nè!)
    CommentResponse updateComment(Long commentId, CommentRequest request, Long userId);

    // BR-38, 39: Cập nhật trạng thái bình luận (Admin ẩn/hiện bình luận vi phạm)
    void updateCommentStatus(Long commentId, String newStatus, String reason, Long adminId);
}