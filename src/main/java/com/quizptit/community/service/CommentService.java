package com.quizptit.community.service;

import com.quizptit.community.entity.Comment;
import java.util.List;

public interface CommentService {
    // BR-33, 36: Thêm bình luận vào bài viết
    Comment addComment(Long postId, Comment comment, Long userId);

    // Lấy danh sách bình luận của một bài viết
    List<Comment> getCommentsByPost(Long postId);

    // BR-37: Xóa bình luận (chính chủ hoặc Admin)
    void deleteComment(Long commentId, Long userId, String userRole);
}