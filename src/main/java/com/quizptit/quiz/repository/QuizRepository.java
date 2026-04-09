package com.quizptit.quiz.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.quizptit.content.entity.Topic;
import com.quizptit.quiz.entity.Quiz;
import com.quizptit.quiz.entity.enums.QuizType;

public interface QuizRepository extends JpaRepository<Quiz, Long> {
    List<Quiz> findByIsPublishedTrueOrderByCreatedAtDesc();

    List<Quiz> findBySubject_SubjectIdAndIsPublishedTrueOrderByCreatedAtDesc(Long subjectId);

    long countByTopic(Topic topic);

    int countByTopicTopicId(Long topicId);

    List<Quiz> findByTopicTopicId(Long topicId);

    List<Quiz> findByQuizTypeOrderByCreatedAtDesc(QuizType quizType);
}
