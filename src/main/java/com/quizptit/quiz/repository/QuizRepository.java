package com.quizptit.quiz.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.quizptit.content.entity.Topic;
import com.quizptit.quiz.entity.Quiz;
import com.quizptit.quiz.entity.enums.QuizType;

public interface QuizRepository extends JpaRepository<Quiz, Long> {
    List<Quiz> findByIsPublishedTrueAndQuizTypeOrderByCreatedAtDesc(QuizType quizType);
    
    List<Quiz> findBySubject_SubjectIdAndIsPublishedTrueAndQuizTypeOrderByCreatedAtDesc(Long subjectId, QuizType quizType);

    long countByTopic(Topic topic);

    int countByTopicTopicId(Long topicId);

    int countByTopicSubjectSubjectId(Long subjectId);

    List<Quiz> findByTopicTopicId(Long topicId);

    List<Quiz> findByQuizTypeOrderByCreatedAtDesc(QuizType quizType);

    int countByTopicTopicIdAndQuizType(Long topicId, QuizType quizType);

    int countByTopicTopicIdAndQuizTypeAndIsPublishedTrue(Long topicId, QuizType quizType);

    @Query(
        "SELECT COUNT(q) FROM Quiz q WHERE q.topic.subject.subjectId = :subjectId " +
        "AND q.quizType = 'MANUAL' AND q.isPublished = true")
    int countTotalQuizzesBySubjectId(@Param("subjectId") Long subjectId);
}
