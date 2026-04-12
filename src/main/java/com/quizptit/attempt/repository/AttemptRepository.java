package com.quizptit.attempt.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.quizptit.attempt.entity.Attempt;
import com.quizptit.attempt.entity.enums.AttemptStatus;

public interface AttemptRepository extends JpaRepository<Attempt, Long> {

    @Query("SELECT a FROM Attempt a JOIN FETCH a.quiz WHERE a.user.userId = :userId ORDER BY a.startedAt DESC")
    List<Attempt> findByUser_UserIdOrderByStartedAtDesc(@Param("userId") Long userId);

    @Query("SELECT a FROM Attempt a JOIN FETCH a.quiz WHERE a.attemptId = :attemptId")
    Optional<Attempt> findByIdWithQuiz(@Param("attemptId") Long attemptId);

    Optional<Attempt> findFirstByUser_UserIdAndQuiz_QuizIdAndStatusOrderByStartedAtDesc(
            Long userId, Long quizId, AttemptStatus status);

    List<Attempt> findByStatus(AttemptStatus status);
}
