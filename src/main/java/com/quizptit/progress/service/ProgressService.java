package com.quizptit.progress.service;

import com.quizptit.content.entity.Subject;
import com.quizptit.content.entity.Topic;
import com.quizptit.content.repository.SubjectRepository;
import com.quizptit.content.repository.TopicRepository;
import com.quizptit.quiz.entity.Quiz;
import com.quizptit.quiz.repository.QuizRepository;
import com.quizptit.progress.dto.*;
import com.quizptit.progress.entity.LearningProgress;
import com.quizptit.progress.entity.UserQuizProgress;
import com.quizptit.progress.repository.LearningProgressRepository;
import com.quizptit.progress.repository.UserQuizProgressRepository;
import com.quizptit.user.entity.User;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProgressService {
    private final UserQuizProgressRepository progressRepository;
    private final LearningProgressRepository learningProgressRepository;
    private final SubjectRepository subjectRepository;
    private final TopicRepository topicRepository;
    private final QuizRepository quizRepository;

    // --- LOGIC CẬP NHẬT (KHI NỘP BÀI) ---

    @Transactional
    public void updateQuizProgress(User user, Quiz quiz, BigDecimal currentScore) {
        // 1. Cập nhật tiến độ bài Quiz cụ thể (UserQuizProgress)
        UserQuizProgress progress = progressRepository.findByUserUserIdAndQuizQuizId(user.getUserId(), quiz.getQuizId())
                .orElse(UserQuizProgress.builder()
                        .user(user)
                        .quiz(quiz)
                        .topic(quiz.getTopic())
                        .highestScore(BigDecimal.ZERO)
                        .totalAttempts(0)
                        .build());

        progress.setTotalAttempts(progress.getTotalAttempts() + 1);
        progress.setLastAttemptAt(LocalDateTime.now());

        if (currentScore.compareTo(progress.getHighestScore()) > 0) {
            progress.setHighestScore(currentScore);
        }

        progressRepository.save(progress);

        // 2. Đồng bộ hóa sang tiến độ Chương (LearningProgress)
        this.updateTopicMastery(user, quiz.getTopic());
    }

    private void updateTopicMastery(User user, Topic topic) {
        LearningProgress learningProgress = learningProgressRepository
                .findByUserUserIdAndTopicTopicId(user.getUserId(), topic.getTopicId())
                .orElse(LearningProgress.builder()
                        .user(user)
                        .topic(topic)
                        .totalAttempts(0)
                        .totalQuizzes(0)
                        .completedQuizzes(0)
                        .progressPercentage(BigDecimal.ZERO)
                        .correctRate(BigDecimal.ZERO)
                        .masteryScore(BigDecimal.ZERO)
                        .lastPracticedAt(null)
                        .build());

        List<UserQuizProgress> topicProgresses = progressRepository
                .findAllByUserUserIdAndTopicTopicId(user.getUserId(), topic.getTopicId());

        int totalQuizzesInTopic = quizRepository.countByTopicTopicId(topic.getTopicId());
        int totalAttempts = topicProgresses.stream().mapToInt(UserQuizProgress::getTotalAttempts).sum();
        
        // Tính điểm trung bình (averageScore) của các quiz đã làm trong topic
        BigDecimal averageScore = topicProgresses.isEmpty() ? BigDecimal.ZERO :
                topicProgresses.stream()
                        .map(UserQuizProgress::getHighestScore)
                        .reduce(BigDecimal.ZERO, BigDecimal::add)
                        .divide(BigDecimal.valueOf(topicProgresses.size()), 2, RoundingMode.HALF_UP);

        // Tính % hoàn thành dựa trên số lượng quiz đã làm / tổng quiz trong hệ thống của topic đó
        double percentage = totalQuizzesInTopic == 0 ? 0 : 
                ((double) topicProgresses.size() / totalQuizzesInTopic) * 100;

        learningProgress.setTotalAttempts(totalAttempts);
        learningProgress.setTotalQuizzes(totalQuizzesInTopic);
        learningProgress.setCompletedQuizzes(topicProgresses.size());
        learningProgress.setMasteryScore(averageScore); 
        learningProgress.setProgressPercentage(BigDecimal.valueOf(percentage));
        learningProgress.setLastPracticedAt(LocalDateTime.now());

        learningProgressRepository.save(learningProgress);
    }

    // --- LOGIC HIỂN THỊ (VIEW DATA) ---

    // Cấp 1: Lấy tất cả Môn học (Subjects)
    @Transactional(readOnly = true)
    public List<SubjectProgressDTO> getAllSubjectProgress(Long userId) {
        return subjectRepository.findAll().stream().map(subject -> {
            List<LearningProgress> lpList = learningProgressRepository
                    .findAllByUserUserIdAndTopicSubjectSubjectId(userId, subject.getSubjectId());

            int totalQuizzes = lpList.stream().mapToInt(LearningProgress::getTotalQuizzes).sum();
            int completedQuizzes = lpList.stream().mapToInt(LearningProgress::getCompletedQuizzes).sum();
            
            double overallPercent = totalQuizzes == 0 ? 0 : ((double) completedQuizzes / totalQuizzes) * 100;

            return SubjectProgressDTO.builder()
                    .subjectId(subject.getSubjectId())
                    .subjectName(subject.getSubjectName())
                    .totalTopics(topicRepository.countBySubjectSubjectId(subject.getSubjectId()))
                    .completedTopics((int) lpList.stream().filter(lp -> lp.getProgressPercentage().doubleValue() >= 80).count())
                    .overallPercentage(Math.round(overallPercent * 10) / 10.0)
                    .build();
        }).collect(Collectors.toList());
    }

    // Cấp 2: Lấy tất cả Chương (Topics) theo Môn học
    @Transactional(readOnly = true)
    public List<TopicProgressDTO> getTopicsBySubject(Long userId, Long subjectId) {
        List<Topic> topics = topicRepository.findBySubjectSubjectId(subjectId);

        return topics.stream().map(topic -> {
            Optional<LearningProgress> lp = learningProgressRepository
                    .findByUserUserIdAndTopicTopicId(userId, topic.getTopicId());

            return TopicProgressDTO.builder()
                    .topicId(topic.getTopicId())
                    .topicName(topic.getTopicName())
                    .totalQuizzes(lp.map(LearningProgress::getTotalQuizzes).orElse(quizRepository.countByTopicTopicId(topic.getTopicId())))
                    .completedQuizzes(lp.map(LearningProgress::getCompletedQuizzes).orElse(0))
                    .averageScore(lp.map(LearningProgress::getMasteryScore).orElse(BigDecimal.ZERO))
                    .build();
        }).collect(Collectors.toList());
    }

    // Cấp 3: Lấy tất cả Quiz theo Chương
    @Transactional(readOnly = true)
    public List<QuizStatusDTO> getQuizzesByTopic(Long userId, Long topicId) {
        List<Quiz> allQuizzes = quizRepository.findByTopicTopicId(topicId);
        List<UserQuizProgress> userProgresses = progressRepository.findAllByUserUserIdAndTopicTopicId(userId, topicId);

        return allQuizzes.stream().map(quiz -> {
            Optional<UserQuizProgress> up = userProgresses.stream()
                    .filter(p -> p.getQuiz().getQuizId().equals(quiz.getQuizId())).findFirst();

            return QuizStatusDTO.builder()
                    .quizId(quiz.getQuizId())
                    .title(quiz.getTitle())
                    .highestScore(up.map(UserQuizProgress::getHighestScore).orElse(BigDecimal.ZERO))
                    .isCompleted(up.map(p -> p.getHighestScore().doubleValue() >= 5.0).orElse(false))
                    .build();
        }).collect(Collectors.toList());
    }

    // Lịch sử làm bài tổng quát
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

    public Page<AdminProgressDTO> getAdminProgressData(Long subjectId, String keyword, Pageable pageable) {
        Page<AdminProgressDTO> page = learningProgressRepository.findAdminProgressSummary(subjectId, keyword, pageable);

        page.forEach(dto -> {
            // Lấy tổng số chương thực tế của môn học
            int total = topicRepository.countBySubjectSubjectId(dto.getSubjectId());
            dto.setTotalTopics(total);

            // Phân loại trạng thái dựa trên điểm
            double score = dto.getAverageScore() != null ? dto.getAverageScore().doubleValue() : 0;
            if (score >= 8.0) dto.setStatus("Xuất sắc");
            else if (score >= 5.0) dto.setStatus("Đạt");
            else dto.setStatus("Cảnh báo");
        });
        return page;
    }
}