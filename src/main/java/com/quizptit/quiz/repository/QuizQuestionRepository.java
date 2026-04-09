package com.quizptit.quiz.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;

import com.quizptit.quiz.entity.QuizQuestion;

import jakarta.transaction.Transactional;

public interface QuizQuestionRepository extends JpaRepository<QuizQuestion, Long> {
    List<QuizQuestion> findByQuiz_QuizIdOrderByOrderNoAsc(Long quizId);

    @Modifying
    @Transactional
    void deleteByQuiz_QuizId(Long quizId);
}
