package com.quizptit.content.repository;

import com.quizptit.content.entity.Topic;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TopicRepository extends JpaRepository<Topic, Long> {

    List<Topic> findBySubjectSubjectIdAndIsActiveTrueOrderByOrderNoAsc(Long subjectId);

    Page<Topic> findBySubjectSubjectId(Long subjectId, Pageable pageable);

    boolean existsBySubjectSubjectIdAndTopicName(Long subjectId, String topicName);

    boolean existsBySubjectSubjectIdAndTopicNameAndTopicIdNot(Long subjectId, String topicName, Long topicId);

    @EntityGraph(attributePaths = {"subject"})
    @Query("""
        SELECT t
        FROM Topic t
        WHERE (:subjectId IS NULL OR t.subject.subjectId = :subjectId)
          AND (:keyword IS NULL OR :keyword = ''
               OR LOWER(t.topicName) LIKE LOWER(CONCAT('%', :keyword, '%'))
               OR LOWER(t.description) LIKE LOWER(CONCAT('%', :keyword, '%')))
          AND (:isActive IS NULL OR t.isActive = :isActive)
    """)
    Page<Topic> searchTopics(Long subjectId, String keyword, Boolean isActive, Pageable pageable);

    List<Topic> findBySubjectSubjectId(Long subjectId);

    int countBySubjectSubjectId(Long subjectId);

    List<Topic> findBySubject_SubjectId(Long subjectId);
}