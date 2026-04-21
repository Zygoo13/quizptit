package com.quizptit.review.repository;

import com.quizptit.review.entity.UserQuestionMemory;
import com.quizptit.review.dto.ReviewSubjectDTO;   
import com.quizptit.progress.dto.QuestionReviewDTO;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface UserQuestionMemoryRepository extends JpaRepository<UserQuestionMemory, Long> {

    // Tìm bản ghi của người dùng cho câu hỏi cụ thể để cập nhật memory_score
   Optional<UserQuestionMemory> findByUserUserIdAndQuestionQuestionId(Long userId, Long questionId);

    // Lấy danh sách các câu hỏi đến hạn hoặc quá hạn ôn tập của người dùng
   @Query("SELECT m FROM UserQuestionMemory m WHERE m.user.userId = :userId AND m.nextReviewAt <= :now")
   List<UserQuestionMemory> findQuestionsToReview(@Param("userId") Long userId, @Param("now") LocalDateTime now);

    @Query("SELECT new com.quizptit.review.dto.ReviewSubjectDTO(" +
        "s.subjectId, s.subjectName, " +
        "SUM(CASE WHEN m.nextReviewAt <= :now THEN 1L ELSE 0L END), " + 
        "SUM(m.memoryScore)) " + 
        "FROM UserQuestionMemory m " + // Bắt đầu từ bảng Memory
        "JOIN m.question q " +
        "JOIN q.topic t " +
        "JOIN t.subject s " +
        "WHERE m.user.userId = :userId " + // Chỉ lấy dữ liệu của chính user này
        "AND s.isActive = true " +
        "GROUP BY s.subjectId, s.subjectName")
    List<ReviewSubjectDTO> findReviewDashboardData(
        @Param("userId") Long userId, 
        @Param("now") LocalDateTime now);
    
    @Query("SELECT m FROM UserQuestionMemory m " +
        "JOIN m.question q " +
        "WHERE m.user.userId = :userId AND q.topic.subject.subjectId = :subjectId " +
        "AND m.nextReviewAt <= :now")
    List<UserQuestionMemory> findQuestionsToReviewBySubject( // Trả về List Entity
        @Param("userId") Long userId, 
        @Param("subjectId") Long subjectId, 
        @Param("now") LocalDateTime now
    );
}
