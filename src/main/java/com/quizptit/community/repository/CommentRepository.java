package com.quizptit.community.repository;

import com.quizptit.community.entity.Comment;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {

    List<Comment> findByQuestionPost_QuestionPostIdAndParentCommentIsNullAndStatusOrderByCreatedAtDesc(
            Long questionPostId, String status
    );

    List<Comment> findByQuestionPost_QuestionPostIdAndStatus(Long questionPostId, String status);

    List<Comment> findByQuestionPost_QuestionPostIdAndParentCommentIsNullOrderByCreatedAtDesc(Long postId);

    long countByQuestionPost_QuestionPostIdAndStatus(Long questionPostId, String status);

    Optional<Comment> findByCommentIdAndStatus(Long commentId, String status);

    @Modifying
    @Transactional
    @Query("""
        UPDATE Comment c
        SET c.status = 'HIDDEN'
        WHERE c.parentComment.commentId = :parentId
          AND c.status = 'VISIBLE'
    """)
    void softDeleteRepliesByParentId(Long parentId);

    @Modifying
    @Transactional
    @Query("""
        UPDATE Comment c
        SET c.status = :status
        WHERE c.questionPost.questionPostId = :postId
    """)
    void updateStatusByPostId(Long postId, String status);
}