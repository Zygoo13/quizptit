package com.quizptit.content.repository;

import com.quizptit.content.entity.Question;
import com.quizptit.common.constant.QuestionStatus;
import com.quizptit.common.constant.DifficultyLevel;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface QuestionRepository extends JpaRepository<Question, Long> {

    @Query("SELECT q FROM Question q WHERE (:topicId IS NULL OR q.topic.topicId = :topicId) AND (:status IS NULL OR q.status = :status) AND (:difficulty IS NULL OR q.difficultyLevel = :difficulty) AND (:keyword IS NULL OR :keyword = '' OR LOWER(q.content) LIKE LOWER(CONCAT('%', :keyword, '%')) OR LOWER(q.explanation) LIKE LOWER(CONCAT('%', :keyword, '%')))")
    Page<Question> searchQuestions(Long topicId, QuestionStatus status, DifficultyLevel difficulty, String keyword, Pageable pageable);
}
