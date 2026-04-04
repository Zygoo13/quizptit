package com.quizptit.community.service;

import com.quizptit.community.dto.QuestionPostRequest;
import com.quizptit.community.dto.QuestionPostResponse;
import java.util.List;

public interface QuestionPostService {

    // BR-33, 34, 35: Tạo bài viết mới (Dùng RequestDTO đầu vào, ResponseDTO đầu ra)
    QuestionPostResponse createPost(QuestionPostRequest request, Long userId, Long topicId);

    // BR-37: Cập nhật bài viết (Chỉ chính chủ)
    QuestionPostResponse updatePost(Long postId, QuestionPostRequest request, Long userId);

    // BR-37, 38: Xóa bài viết (Chính chủ hoặc Admin/Moderator)
    void deletePost(Long postId, Long userId, String userRole);

    // BR-40: Lấy danh sách bài viết công khai
    List<QuestionPostResponse> getPublicPosts();

    // BR-41: Lấy tất cả bài viết cho Admin
    List<QuestionPostResponse> getAllPostsForAdmin();

    // BR-38, 39: Thay đổi trạng thái bài viết & Lưu lý do kiểm duyệt
    void updatePostStatus(Long postId, String newStatus, String reason, Long adminId);

    // Lấy chi tiết bài viết
    // Trong file QuestionPostService.java
    QuestionPostResponse getPostById(Long postId, Long currentUserId, String role);
}