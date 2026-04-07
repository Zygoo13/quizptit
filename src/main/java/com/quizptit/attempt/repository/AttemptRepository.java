package com.quizptit.attempt.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.quizptit.attempt.entity.Attempt;

public interface AttemptRepository extends JpaRepository<Attempt, Long> {

    // Dùng JOIN FETCH để load Quiz trong cùng 1 query, tránh LazyInitializationException
    @Query("SELECT a FROM Attempt a JOIN FETCH a.quiz WHERE a.user.userId = :userId ORDER BY a.startedAt DESC")
    List<Attempt> findByUser_UserIdOrderByStartedAtDesc(@Param("userId") Long userId);

    // Load quiz eagerly khi lấy 1 attempt cụ thể
    @Query("SELECT a FROM Attempt a JOIN FETCH a.quiz WHERE a.attemptId = :attemptId")
    Optional<Attempt> findByIdWithQuiz(@Param("attemptId") Long attemptId);
}
