package com.quizptit.attempt.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.quizptit.attempt.entity.AttemptAnswer;

@Repository
public interface AttemptAnswerRepository extends JpaRepository<AttemptAnswer, Long> {

    Optional<AttemptAnswer> findByAttemptQuestion_AttemptQuestionId(Long attemptQuestionId);

    java.util.List<AttemptAnswer> findByAttemptQuestion_Attempt_AttemptId(Long attemptId);

}
