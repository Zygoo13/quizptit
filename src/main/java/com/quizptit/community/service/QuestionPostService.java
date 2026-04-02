package com.quizptit.community.service;

import com.quizptit.community.entity.QuestionPost;
import java.util.List;

public interface QuestionPostService {
    // BR-33, 34, 35: Đăng bài
    QuestionPost createPost(QuestionPost post, Long userId, Long topicId);

    // BR-40: Lấy danh sách bài viết công khai cho sinh viên
    List<QuestionPost> getPublicPosts();

    // BR-37: Xóa bài (chính chủ hoặc Admin)
    void deletePost(Long postId, Long userId, String userRole);
}