package com.quizptit.attempt.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.quizptit.attempt.entity.Attempt;

public interface AttemptRepository extends JpaRepository<Attempt, Long> {
    List<Attempt> findByUser_UserIdOrderByStartedAtDesc(Long userId);
}
