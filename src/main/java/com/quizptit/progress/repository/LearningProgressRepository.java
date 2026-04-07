package com.quizptit.progress.repository;

import com.quizptit.progress.entity.LearningProgress;
import com.quizptit.progress.dto.AdminProgressDTO;
import com.quizptit.review.dto.ReviewSubjectDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;
import java.util.Optional;
import java.time.LocalDateTime;

public interface LearningProgressRepository extends JpaRepository<LearningProgress, Long> {
    List<LearningProgress> findAllByUserUserId(Long userId);
    
    // Truy vấn: Progress -> Topic -> Subject
    List<LearningProgress> findAllByUserUserIdAndTopicSubjectSubjectId(Long userId, Long subjectId);
    
    Optional<LearningProgress> findByUserUserIdAndTopicTopicId(Long userId, Long topicId);

    @Query("SELECT new com.quizptit.progress.dto.AdminProgressDTO(" +
       "u.userId, u.email, u.fullName, s.subjectId, s.subjectName, " +
       "COUNT(lp.topic.topicId), " + 
       "CAST(AVG(lp.progressPercentage) AS java.math.BigDecimal), " +
       "CAST(AVG(lp.masteryScore) AS java.math.BigDecimal)) " +
       "FROM LearningProgress lp " + 
       "JOIN lp.user u " +
       "JOIN lp.topic t " +
       "JOIN t.subject s " +
       "WHERE (:subjectId IS NULL OR s.subjectId = :subjectId) " +
       "AND (:keyword IS NULL OR :keyword = '' OR u.email LIKE %:keyword% OR u.fullName LIKE %:keyword%) " +
       "GROUP BY u.userId, u.email, u.fullName, s.subjectId, s.subjectName")
    Page<AdminProgressDTO> findAdminProgressSummary(
       @Param("subjectId") Long subjectId, 
       @Param("keyword") String keyword, 
       Pageable pageable
    );

    @Query("SELECT new com.quizptit.review.dto.ReviewSubjectDTO(" +
        "s.subjectId, " +
        "s.subjectName, " +
        "SUM(CASE WHEN lp.masteryScore < 80 THEN 1L ELSE 0L END), " +
        "CAST(AVG(lp.masteryScore) AS java.math.BigDecimal)) " +
        "FROM LearningProgress lp " +
        "JOIN lp.topic t " +
        "JOIN t.subject s " +
        "WHERE lp.user.userId = :userId " +
        "GROUP BY s.subjectId, s.subjectName")
    List<ReviewSubjectDTO> findAllSubjectsWithReviewCount(@Param("userId") Long userId);
}