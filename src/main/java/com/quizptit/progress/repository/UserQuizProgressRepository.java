package com.quizptit.progress.repository;

import com.quizptit.content.entity.Topic;
import com.quizptit.progress.entity.UserQuizProgress;
import com.quizptit.user.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Repository
public interface UserQuizProgressRepository extends JpaRepository<UserQuizProgress, Long> {

    // Lấy tiến độ của người dùng cho một Quiz cụ thể
    Optional<UserQuizProgress> findByUserUserIdAndQuizQuizId(Long userId, Long quizId);

    // Lấy toàn bộ danh sách tiến độ các Quiz mà người dùng đã từng làm
    List<UserQuizProgress> findAllByUserUserId(Long userId);

    List<UserQuizProgress> findByUserUserId(Long userId);

    // Đếm số bài quiz đã đạt yêu cầu trong một topic của một user
    long countByUserAndQuizTopicAndHighestScoreGreaterThanEqual(User user, Topic topic, BigDecimal threshold);

    List<UserQuizProgress> findAllByUserUserIdAndTopicTopicId(Long userId, Long topicId);
}