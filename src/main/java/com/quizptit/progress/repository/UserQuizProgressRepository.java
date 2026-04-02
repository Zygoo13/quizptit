package com.quizptit.progress.repository;

import com.quizptit.progress.entity.UserQuizProgress;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserQuizProgressRepository extends JpaRepository<UserQuizProgress, Long> {

    // Lấy tiến độ của người dùng cho một Quiz cụ thể
    Optional<UserQuizProgress> findByUserUserIdAndQuizQuizId(Long userId, Long quizId);

    // Lấy toàn bộ danh sách tiến độ các Quiz mà người dùng đã từng làm
    List<UserQuizProgress> findAllByUserUserId(Long userId);
}