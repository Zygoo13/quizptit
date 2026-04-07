package com.quizptit.review.repository;

import com.quizptit.review.entity.UserQuestionMemory;
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

}