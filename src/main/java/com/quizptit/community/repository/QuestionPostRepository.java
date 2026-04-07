package com.quizptit.community.repository;

import com.quizptit.community.entity.QuestionPost;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface QuestionPostRepository extends JpaRepository<QuestionPost, Long> {
    // Lấy danh sách bài đăng của một User cụ thể
    List<QuestionPost> findByUserUserId(Long userId);

    // Tìm các bài đăng theo trạng thái (VISIBLE/HIDDEN)
    List<QuestionPost> findByStatus(String status);

    // Tìm bài đăng theo Topic VÀ phải là VISIBLE (Dùng cho BR-40)
    List<QuestionPost> findByTopicIdAndStatus(Long topicId, String status);


    // Tìm bài đăng theo Topic
    List<QuestionPost> findByTopicId(Long topicId);

    @Query("SELECT q FROM QuestionPost q WHERE q.status != 'DELETED' ORDER BY q.createdAt DESC")
    List<QuestionPost> findAllActivePosts();
}