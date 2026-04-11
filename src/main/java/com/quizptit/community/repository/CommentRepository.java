package com.quizptit.community.repository;

import com.quizptit.community.entity.Comment;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {

    // 1. Lấy danh sách bình luận GỐC (Cấp 1) của một bài đăng, sắp xếp mới nhất lên đầu
    // parentCommentIsNull đảm bảo không lấy nhầm các bản ghi là 'phản hồi' vào danh sách chính
    List<Comment> findByQuestionPost_QuestionPostIdAndParentCommentIsNullAndStatusOrderByCreatedAtDesc(
            Long questionPostId, String status);

    // 2. Nếu Quang muốn lấy TOÀN BỘ để đếm số lượng hoặc làm logic khác
    List<Comment> findByQuestionPost_QuestionPostIdAndStatus(Long questionPostId, String status);

    long countByQuestionPost_QuestionPostIdAndStatus(Long questionPostId, String status);

    @Modifying
    @Transactional
    @Query("UPDATE Comment c SET c.status = 'DELETED' WHERE c.parentComment.commentId = :parentId AND c.status = 'VISIBLE'")
    void softDeleteRepliesByParentId(Long parentId);

    @Modifying
    @Query("UPDATE Comment c SET c.status = :status WHERE c.questionPost.questionPostId = :postId")
    void updateStatusByPostId(Long postId, String status);

    List<Comment> findByQuestionPost_QuestionPostIdAndParentCommentIsNullOrderByCreatedAtDesc(Long postId);
}