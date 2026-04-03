package com.quizptit.progress.repository;

import com.quizptit.progress.entity.LearningProgress;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface LearningProgressRepository extends JpaRepository<LearningProgress, Long> {

    // Tìm tiến độ học tập theo Topic của người dùng
    Optional<LearningProgress> findByUserUserIdAndTopicTopicId(Long userId, Long topicId);
}