package com.quizptit.community.repository;

import com.quizptit.community.dto.QuestionPostResponse;
import com.quizptit.community.entity.QuestionPost;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable; // ĐÃ SỬA: Dùng của Spring domain
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuestionPostRepository extends JpaRepository<QuestionPost, Long> {

    List<QuestionPost> findByUserUserId(Long userId);

    // Tìm các bài đăng theo trạng thái và PHÂN TRANG
    Page<QuestionPost> findByStatus(String status, Pageable pageable);

    // Tìm bài đăng theo Topic, Status và PHÂN TRANG
    Page<QuestionPost> findByTopicIdAndStatus(Long topicId, String status, Pageable pageable);

    List<QuestionPost> findByTopicId(Long topicId);

    @Query("SELECT q FROM QuestionPost q WHERE q.status != 'DELETED' ORDER BY q.createdAt DESC")
    List<QuestionPost> findAllActivePosts();

    List<QuestionPost> findByStatusOrderByCreatedAtDesc(String status);

}