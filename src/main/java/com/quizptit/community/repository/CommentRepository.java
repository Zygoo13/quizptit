package com.quizptit.community.repository;

import com.quizptit.community.entity.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {
    // Lấy tất cả bình luận của một bài đăng cụ thể
    List<Comment> findByQuestionPost_QuestionPostId(Long postId);
}