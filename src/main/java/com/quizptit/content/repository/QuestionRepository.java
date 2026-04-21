package com.quizptit.content.repository;

import com.quizptit.content.entity.Question;
import com.quizptit.common.constant.QuestionStatus;
import com.quizptit.common.constant.DifficultyLevel;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface QuestionRepository extends JpaRepository<Question, Long> {

    @EntityGraph(attributePaths = { "topic" })
    @Query("""
        SELECT q
        FROM Question q
        WHERE (:subjectId IS NULL OR q.topic.subject.subjectId = :subjectId)
            AND (:topicId IS NULL OR q.topic.topicId = :topicId)
            AND (:status IS NULL OR q.status = :status)
            AND (:difficulty IS NULL OR q.difficultyLevel = :difficulty)
            AND (:keyword IS NULL OR :keyword = ''
                OR LOWER(q.content) LIKE LOWER(CONCAT('%', :keyword, '%'))
                OR LOWER(q.explanation) LIKE LOWER(CONCAT('%', :keyword, '%')))
        """)
    Page<Question> searchQuestions(
        @Param("subjectId") Long subjectId,
        @Param("topicId") Long topicId,
        @Param("status") QuestionStatus status,
        @Param("difficulty") DifficultyLevel difficulty,
        @Param("keyword") String keyword,
        Pageable pageable
    );

    // Kéo ngẫu nhiên N câu hỏi theo Môn học (JOIN qua bảng topic)
    @Query(value = "SELECT q.* FROM question q " +
                    "INNER JOIN topic t ON q.topic_id = t.topic_id " +
                    "WHERE t.subject_id = :subjectId " +
                    "ORDER BY RAND() LIMIT :limit", nativeQuery = true)
    List<Question> findRandomQuestionsBySubjectId(@Param("subjectId") Long subjectId, @Param("limit") int limit);

    // Tiện thể làm luôn hàm: Kéo ngẫu nhiên N câu hỏi theo Chủ đề cụ thể
    // (Cái này không cần JOIN vì bảng question có sẵn topic_id)
    @Query(value = "SELECT * FROM question q " +
                    "WHERE q.topic_id = :topicId " +
                    "ORDER BY RAND() LIMIT :limit", nativeQuery = true)
    List<Question> findRandomQuestionsByTopicId(@Param("topicId") Long topicId, @Param("limit") int limit);

    List<Question> findByTopic_TopicId(Long topicId);

    long countByTopicSubjectSubjectId(Long subjectId);
}
