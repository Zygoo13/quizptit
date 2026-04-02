package com.quizptit.quiz.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.quizptit.quiz.entity.Quiz;

public interface QuizRepository extends JpaRepository<Quiz, Long> {

}
