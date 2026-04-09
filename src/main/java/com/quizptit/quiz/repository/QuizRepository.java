package com.quizptit.quiz.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.quizptit.content.entity.Topic;
import com.quizptit.quiz.entity.Quiz;

public interface QuizRepository extends JpaRepository<Quiz, Long> {
    // Lấy danh sách bài luyện đã được publish, sắp xếp mới nhất lên đầu
    List<Quiz> findByIsPublishedTrueOrderByCreatedAtDesc();

    // Lấy danh sách bài luyện theo môn học (dùng khi sinh viên lọc theo môn)
    List<Quiz> findBySubject_SubjectIdAndIsPublishedTrueOrderByCreatedAtDesc(Long subjectId);

    long countByTopic(Topic topic);

    int countByTopicTopicId(Long topicId);

    int countByTopicSubjectSubjectId(Long subjectId);

    List<Quiz> findByTopicTopicId(Long topicId);
}
