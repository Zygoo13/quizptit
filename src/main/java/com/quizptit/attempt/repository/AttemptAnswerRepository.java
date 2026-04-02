package com.quizptit.attempt.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.quizptit.attempt.entity.AttemptAnswer;
import com.quizptit.quiz.entity.Quiz;

@Repository
public interface AttemptAnswerRepository extends JpaRepository<AttemptAnswer, Long> {

    Optional<AttemptAnswer> findByAttemptQuestion_AttemptQuestionId(Long attemptQuestionId);

}
