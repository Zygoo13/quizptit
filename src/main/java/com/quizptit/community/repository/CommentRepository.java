package com.quizptit.community.repository;

import com.quizptit.community.entity.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {
    // Lấy tất cả bình luận của một bài đăng (Quan trọng nhất)
    List<Comment> findByQuestionPostQuestionPostId(Long questionPostId);

    // Lấy các bình luận đang hiển thị của một bài đăng
    List<Comment> findByQuestionPost_QuestionPostIdAndStatus(Long questionPostId, String status);
}