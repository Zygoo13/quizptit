package com.quizptit.progress.repository;

import com.quizptit.progress.entity.LearningProgress;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface LearningProgressRepository extends JpaRepository<LearningProgress, Long> {
    List<LearningProgress> findAllByUserUserId(Long userId);
    
    // Truy vấn: Progress -> Topic -> Subject
    List<LearningProgress> findAllByUserUserIdAndTopicSubjectSubjectId(Long userId, Long subjectId);
    
    Optional<LearningProgress> findByUserUserIdAndTopicTopicId(Long userId, Long topicId);
}