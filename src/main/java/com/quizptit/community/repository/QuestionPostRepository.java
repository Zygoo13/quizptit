package com.quizptit.community.repository;

import com.quizptit.community.entity.QuestionPost;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuestionPostRepository extends JpaRepository<QuestionPost, Long> {

    List<QuestionPost> findByUserUserId(Long userId);

    Page<QuestionPost> findByStatus(String status, Pageable pageable);

    Page<QuestionPost> findByTopicIdAndStatus(Long topicId, String status, Pageable pageable);

    List<QuestionPost> findByTopicId(Long topicId);

    @Query("""
        SELECT q
        FROM QuestionPost q
        WHERE q.status <> 'HIDDEN'
        ORDER BY q.createdAt DESC
    """)
    List<QuestionPost> findAllActivePosts();

    List<QuestionPost> findByStatusOrderByCreatedAtDesc(String status);

    List<QuestionPost> findAllByOrderByCreatedAtDesc();
}