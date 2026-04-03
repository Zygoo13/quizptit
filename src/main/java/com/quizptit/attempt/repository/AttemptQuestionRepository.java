package com.quizptit.attempt.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.quizptit.attempt.entity.AttemptQuestion;

public interface AttemptQuestionRepository extends JpaRepository<AttemptQuestion, Long> {
    List<AttemptQuestion> findByAttempt_AttemptIdOrderByOrderNoAsc(Long attemptId);
}
