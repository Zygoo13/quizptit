package com.quizptit.progress.service;

import com.quizptit.progress.entity.UserQuizProgress;
import com.quizptit.progress.repository.UserQuizProgressRepository;
import com.quizptit.user.entity.User;
import com.quizptit.quiz.entity.Quiz;
import com.quizptit.progress.dto.QuizProgressDTO;
import java.util.List;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class ProgressService {
    private final UserQuizProgressRepository progressRepository;

    @Transactional
    public void updateQuizProgress(User user, Quiz quiz, BigDecimal currentScore) {
        // Lấy tiến độ cũ hoặc tạo mới
        UserQuizProgress progress = progressRepository.findByUserUserIdAndQuizQuizId(user.getUserId(), quiz.getQuizId())
                .orElse(
                    UserQuizProgress.builder()
                        .user(user)
                        .quiz(quiz)
                        .topic(quiz.getTopic())
                        .highestScore(BigDecimal.ZERO)
                        .totalAttempts(0)
                        .lastAttemptAt(LocalDateTime.now())
                        .build()
                );

        // Cập nhật số lần làm bài và thời gian
        progress.setTotalAttempts(progress.getTotalAttempts() + 1);
        progress.setLastAttemptAt(LocalDateTime.now());

        // Cập nhật điểm cao nhất nếu tồn tại
        if (currentScore.compareTo(progress.getHighestScore()) > 0) {
            progress.setHighestScore(currentScore);
        }

        progressRepository.save(progress);
    }

    public List<QuizProgressDTO> getMyProgress(Long userId) {
        return progressRepository.findByUserUserId(userId).stream()
                .map(this::mapToQuizProgressDTO)
                .collect(Collectors.toList());
    }

    private QuizProgressDTO mapToQuizProgressDTO(UserQuizProgress entity) {
        return QuizProgressDTO.builder()
                .quizId(entity.getQuiz().getQuizId())
                .quizTitle(entity.getQuiz().getTitle())
                .topicName(entity.getTopic().getTopicName())
                .highestScore(entity.getHighestScore())
                .totalAttempts(entity.getTotalAttempts())
                .lastAttemptAt(entity.getLastAttemptAt())
                .build();
    }
}