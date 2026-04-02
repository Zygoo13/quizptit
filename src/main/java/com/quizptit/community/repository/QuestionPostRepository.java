package com.quizptit.community.repository;

import com.quizptit.community.entity.QuestionPost;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface QuestionPostRepository extends JpaRepository<QuestionPost, Long> {
    // BR-40: Tìm các bài viết có trạng thái hiển thị là VISIBLE
    List<QuestionPost> findByStatus(String status);
}