package com.quizptit.progress.service;

import com.quizptit.content.entity.Subject;
import com.quizptit.content.entity.Topic;
import com.quizptit.content.repository.SubjectRepository;
import com.quizptit.content.repository.TopicRepository;
import com.quizptit.quiz.entity.Quiz;
import com.quizptit.quiz.entity.enums.QuizType;
import com.quizptit.quiz.repository.QuizRepository;
import com.quizptit.progress.dto.*;
import com.quizptit.progress.entity.LearningProgress;
import com.quizptit.progress.entity.UserQuizProgress;
import com.quizptit.progress.repository.LearningProgressRepository;
import com.quizptit.progress.repository.UserQuizProgressRepository;
import com.quizptit.review.repository.UserQuestionMemoryRepository; // 1. Thêm import này
import com.quizptit.review.dto.ReviewSubjectDTO; // Đảm bảo import đúng gói review.dto
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
    private final UserQuizProgressRepository userQuizProgressRepository;
    private final LearningProgressRepository learningProgressRepository;
    private final SubjectRepository subjectRepository;
    private final TopicRepository topicRepository;
    private final QuizRepository quizRepository;
    private final UserQuestionMemoryRepository userQuestionMemoryRepository; // 2. Khai báo thêm repository này

    @Transactional
    public void updateQuizProgress(User user, Quiz quiz, BigDecimal currentScore) {
        if (quiz.getQuizType() == QuizType.RANDOM) {
            return; 
        }
        
        UserQuizProgress progress = userQuizProgressRepository.findByUserUserIdAndQuizQuizId(user.getUserId(), quiz.getQuizId())
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

        userQuizProgressRepository.save(progress);
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

        List<UserQuizProgress> topicProgresses = userQuizProgressRepository
            .findAllByUserUserIdAndTopicTopicId(user.getUserId(), topic.getTopicId())
            .stream()
            .filter(p -> p.getQuiz().getQuizType() == QuizType.MANUAL && p.getQuiz().getIsPublished())
            .collect(Collectors.toList());

        int totalPublishedInTopic = quizRepository.countByTopicTopicIdAndQuizTypeAndIsPublishedTrue(topic.getTopicId(), QuizType.MANUAL);
        int totalAttempts = topicProgresses.stream().mapToInt(UserQuizProgress::getTotalAttempts).sum();
        long completedCount = topicProgresses.stream()
                                .filter(p -> p.getHighestScore() != null && p.getHighestScore().doubleValue() >= 0.4) 
                                .count();

        // Tính điểm trung bình (averageScore) giữa điểm cao nhất của các quiz
        BigDecimal totalHighestScores = topicProgresses.stream()
            .map(UserQuizProgress::getHighestScore)
            .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        BigDecimal masteryScore = totalPublishedInTopic == 0 ? BigDecimal.ZERO 
            : totalHighestScores.divide(BigDecimal.valueOf(totalPublishedInTopic), 2, RoundingMode.HALF_UP);

        double percentage = totalPublishedInTopic == 0 ? 0 : ((double) completedCount / totalPublishedInTopic) * 100;

        learningProgress.setTotalAttempts(totalAttempts);
        learningProgress.setTotalQuizzes(totalPublishedInTopic);
        learningProgress.setCompletedQuizzes((int) completedCount);
        learningProgress.setMasteryScore(masteryScore);
        learningProgress.setProgressPercentage(BigDecimal.valueOf(percentage));
        learningProgress.setLastPracticedAt(LocalDateTime.now());

        learningProgressRepository.save(learningProgress);
    }

    @Transactional(readOnly = true)
    public List<SubjectProgressDTO> getAllSubjectProgress(Long userId) {
        return subjectRepository.findByIsActiveTrue().stream().map(subject -> {
            List<Topic> topics = topicRepository.findBySubjectSubjectId(subject.getSubjectId());
            
            int totalTopics = topics.size();
            int completedTopicsCount = 0;
            int totalQuizzesInSubject = 0;
            int totalPassedQuizzesInSubject = 0;

            for (Topic topic : topics) {
                int quizzesInTopic = quizRepository.countByTopicTopicIdAndQuizTypeAndIsPublishedTrue(topic.getTopicId(), QuizType.MANUAL);
                totalQuizzesInSubject += quizzesInTopic;

                // Đếm số bài trong chương đạt điểm >= 0.4
                long passedInTopic = userQuizProgressRepository
                    .findAllByUserUserIdAndTopicTopicId(userId, topic.getTopicId())
                    .stream()
                    .filter(p -> p.getQuiz().getQuizType() == QuizType.MANUAL 
                            && p.getQuiz().getIsPublished() 
                            && p.getHighestScore().doubleValue() >= 0.4)
                    .count();
                
                totalPassedQuizzesInSubject += passedInTopic;

                // Chương hoàn thành khi số bài đạt mốc >= số bài hiện có
                if (quizzesInTopic > 0 && passedInTopic >= quizzesInTopic) {
                    completedTopicsCount++;
                }
            }

            double overallPercent = totalQuizzesInSubject == 0 ? 0 : ((double) totalPassedQuizzesInSubject / totalQuizzesInSubject) * 100;

            return SubjectProgressDTO.builder()
                .subjectId(subject.getSubjectId())
                .subjectName(subject.getSubjectName())
                .totalTopics(totalTopics)
                .completedTopics(completedTopicsCount)
                .overallPercentage(Math.round(overallPercent * 10) / 10.0)
                .totalQuizzes(totalQuizzesInSubject)
                .completedQuizzes(totalPassedQuizzesInSubject)
                .build();
        }).collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<TopicProgressDTO> getTopicsBySubject(Long userId, Long subjectId) {
        List<Topic> topics = topicRepository.findBySubjectSubjectId(subjectId);

        return topics.stream().map(topic -> {
            int actualTotalQuizzes = quizRepository.countByTopicTopicIdAndQuizTypeAndIsPublishedTrue(topic.getTopicId(), QuizType.MANUAL);

            List<UserQuizProgress> userProgresses = userQuizProgressRepository
                .findAllByUserUserIdAndTopicTopicId(userId, topic.getTopicId())
                .stream()
                .filter(p -> p.getQuiz().getQuizType() == QuizType.MANUAL)
                .collect(Collectors.toList());
            
            long passedQuizzes = userProgresses.stream()
                .filter(p -> p.getQuiz().getQuizType() == QuizType.MANUAL && p.getQuiz().getIsPublished() && p.getHighestScore().doubleValue() >= 0.4)
                .count();

            double percent = actualTotalQuizzes == 0 ? 0 : ((double) passedQuizzes / actualTotalQuizzes) * 100;

            // Builder phải kết thúc bằng .build()
            return TopicProgressDTO.builder()
                .topicId(topic.getTopicId())
                .topicName(topic.getTopicName())
                .totalQuizzes(actualTotalQuizzes)
                .completedQuizzes((int) passedQuizzes)
                .averageScore(calculateAverage(userProgresses)) // Gọi hàm phụ ở đây
                .progressPercentage(BigDecimal.valueOf(Math.round(percent * 10) / 10.0))
                .build();
        }).collect(Collectors.toList()); // Dòng 175 sẽ hết lỗi khi Builder bên trên chuẩn xác
    }

    @Transactional(readOnly = true)
    public List<QuizStatusDTO> getQuizzesByTopic(Long userId, Long topicId) {
        List<Quiz> allQuizzes = quizRepository.findByTopicTopicId(topicId);
        List<UserQuizProgress> userProgresses = userQuizProgressRepository.findAllByUserUserIdAndTopicTopicId(userId, topicId);

        return allQuizzes.stream().map(quiz -> {
            Optional<UserQuizProgress> up = userProgresses.stream()
                .filter(p -> p.getQuiz().getQuizId().equals(quiz.getQuizId())).findFirst();

            return QuizStatusDTO.builder()
                .quizId(quiz.getQuizId())
                .title(quiz.getTitle())
                .highestScore(up.map(UserQuizProgress::getHighestScore).orElse(BigDecimal.ZERO))
                .isCompleted(up.map(p -> p.getHighestScore().doubleValue() >= 0.4).orElse(false))
                .build();
        }).collect(Collectors.toList());
    }

    public List<QuizProgressDTO> getMyProgress(Long userId) {
        return userQuizProgressRepository.findByUserUserId(userId).stream()
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
            int total = topicRepository.countBySubjectSubjectId(dto.getSubjectId());
            dto.setTotalTopics(total);

            double score = dto.getAverageScore() != null ? dto.getAverageScore().doubleValue() : 0;
            if (score >= 0.8)
                dto.setStatus("Xuất sắc");
            else if (score >= 0.5)
                dto.setStatus("Đạt");
            else
                dto.setStatus("Cảnh báo");
        });
        return page;
    }

    public List<ReviewSubjectDTO> getSubjectsToReview(Long userId) {
        return userQuestionMemoryRepository.findReviewDashboardData(userId, LocalDateTime.now());
    }

    // Dòng 230
    public List<QuestionReviewDTO> getSpecificQuestionsToReview(Long userId, Long subjectId) {
        // 1. Lấy "nguyên liệu thô" (Entity) từ DB
        List<com.quizptit.review.entity.UserQuestionMemory> entities = 
                userQuestionMemoryRepository.findQuestionsToReviewBySubject(userId, subjectId, LocalDateTime.now());

        // 2. "Chế biến" sang DTO để trả về đúng kiểu dữ liệu đã khai báo ở đầu hàm
        return entities.stream()
                .map(entity -> QuestionReviewDTO.builder()
                        .questionId(entity.getQuestion().getQuestionId())
                        .content(entity.getQuestion().getContent())
                        .subjectName(entity.getQuestion().getTopic().getSubject().getSubjectName())
                        .memoryScore(entity.getMemoryScore() != null ? entity.getMemoryScore().doubleValue() : 0.0)
                        .nextReviewAt(entity.getNextReviewAt())
                        .correctStreak(entity.getCorrectStreak())
                        .build())
                .collect(Collectors.toList()); 
    }

    private BigDecimal calculateAverage(List<UserQuizProgress> progresses) {
        if (progresses == null || progresses.isEmpty()) {
            return BigDecimal.ZERO;
        }
        return progresses.stream()
            .map(UserQuizProgress::getHighestScore)
            .filter(score -> score != null)
            .reduce(BigDecimal.ZERO, BigDecimal::add)
            .divide(BigDecimal.valueOf(progresses.size()), 2, java.math.RoundingMode.HALF_UP);
    }
}