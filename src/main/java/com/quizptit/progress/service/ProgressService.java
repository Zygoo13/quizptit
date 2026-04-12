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
import com.quizptit.review.entity.UserQuestionMemory;

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
                UserQuizProgress progress = userQuizProgressRepository
                                .findByUserUserIdAndQuizQuizId(user.getUserId(), quiz.getQuizId())
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
                                .findAllByUserUserIdAndTopicTopicId(user.getUserId(), topic.getTopicId());

                int totalQuizzesInTopic = quizRepository.countByTopicTopicId(topic.getTopicId());
                int totalAttempts = topicProgresses.stream().mapToInt(UserQuizProgress::getTotalAttempts).sum();

                BigDecimal averageScore = topicProgresses.isEmpty() ? BigDecimal.ZERO
                                : topicProgresses.stream()
                                                .map(UserQuizProgress::getHighestScore)
                                                .reduce(BigDecimal.ZERO, BigDecimal::add)
                                                .divide(BigDecimal.valueOf(topicProgresses.size()), 2,
                                                                RoundingMode.HALF_UP);

                double percentage = totalQuizzesInTopic == 0 ? 0
                                : ((double) topicProgresses.size() / totalQuizzesInTopic) * 100;

                learningProgress.setTotalAttempts(totalAttempts);
                learningProgress.setTotalQuizzes(totalQuizzesInTopic);
                learningProgress.setCompletedQuizzes(topicProgresses.size());
                learningProgress.setMasteryScore(averageScore);
                learningProgress.setProgressPercentage(BigDecimal.valueOf(percentage));
                learningProgress.setLastPracticedAt(LocalDateTime.now());

                learningProgressRepository.save(learningProgress);
        }

        @Transactional(readOnly = true)
        public List<SubjectProgressDTO> getAllSubjectProgress(Long userId) {
                return subjectRepository.findAll().stream().map(subject -> {
                        List<LearningProgress> lpList = learningProgressRepository
                                        .findAllByUserUserIdAndTopicSubjectSubjectId(userId, subject.getSubjectId());

                        int totalQuizzes = lpList.stream().mapToInt(LearningProgress::getTotalQuizzes).sum();
                        int completedQuizzes = lpList.stream().mapToInt(LearningProgress::getCompletedQuizzes).sum();

                        double overallPercent = totalQuizzes == 0 ? 0
                                        : ((double) completedQuizzes / totalQuizzes) * 100;

                        return SubjectProgressDTO.builder()
                                        .subjectId(subject.getSubjectId())
                                        .subjectName(subject.getSubjectName())
                                        .totalTopics(topicRepository.countBySubjectSubjectId(subject.getSubjectId()))
                                        .completedTopics(
                                                        (int) lpList.stream()
                                                                        .filter(lp -> lp.getProgressPercentage()
                                                                                        .doubleValue() >= 80)
                                                                        .count())
                                        .overallPercentage(Math.round(overallPercent * 10) / 10.0)
                                        .build();
                }).collect(Collectors.toList());
        }

        @Transactional(readOnly = true)
        public List<TopicProgressDTO> getTopicsBySubject(Long userId, Long subjectId) {
                List<Topic> topics = topicRepository.findBySubjectSubjectId(subjectId);

                return topics.stream().map(topic -> {
                        Optional<LearningProgress> lp = learningProgressRepository
                                        .findByUserUserIdAndTopicTopicId(userId, topic.getTopicId());

                        return TopicProgressDTO.builder()
                                        .topicId(topic.getTopicId())
                                        .topicName(topic.getTopicName())
                                        .totalQuizzes(lp.map(LearningProgress::getTotalQuizzes)
                                                        .orElse(quizRepository.countByTopicTopicId(topic.getTopicId())))
                                        .completedQuizzes(lp.map(LearningProgress::getCompletedQuizzes).orElse(0))
                                        .averageScore(lp.map(LearningProgress::getMasteryScore).orElse(BigDecimal.ZERO))
                                        .build();
                }).collect(Collectors.toList());
        }

        @Transactional(readOnly = true)
        public List<QuizStatusDTO> getQuizzesByTopic(Long userId, Long topicId) {
                List<Quiz> allQuizzes = quizRepository.findByTopicTopicId(topicId);
                List<UserQuizProgress> userProgresses = userQuizProgressRepository
                                .findAllByUserUserIdAndTopicTopicId(userId, topicId);

                return allQuizzes.stream().map(quiz -> {
                        Optional<UserQuizProgress> up = userProgresses.stream()
                                        .filter(p -> p.getQuiz().getQuizId().equals(quiz.getQuizId())).findFirst();

                        return QuizStatusDTO.builder()
                                        .quizId(quiz.getQuizId())
                                        .title(quiz.getTitle())
                                        .highestScore(up.map(UserQuizProgress::getHighestScore).orElse(BigDecimal.ZERO))
                                        .isCompleted(up.map(p -> p.getHighestScore().doubleValue() >= 5.0)
                                                        .orElse(false))
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
                Page<AdminProgressDTO> page = learningProgressRepository.findAdminProgressSummary(subjectId, keyword,
                                pageable);

                page.forEach(dto -> {
                        int total = topicRepository.countBySubjectSubjectId(dto.getSubjectId());
                        dto.setTotalTopics(total);

                        double score = dto.getAverageScore() != null ? dto.getAverageScore().doubleValue() : 0;
                        if (score >= 8.0)
                                dto.setStatus("Xuất sắc");
                        else if (score >= 5.0)
                                dto.setStatus("Đạt");
                        else
                                dto.setStatus("Cảnh báo");
                });
                return page;
        }

        public List<ReviewSubjectDTO> getSubjectsToReview(Long userId) {
                return userQuestionMemoryRepository.findReviewDashboardData(userId, LocalDateTime.now());
        }

        public List<QuestionReviewDTO> getSpecificQuestionsToReview(Long userId, Long subjectId) {
                return userQuestionMemoryRepository
                                .findQuestionsToReviewBySubject(userId, subjectId, LocalDateTime.now())
                                .stream()
                                .map(this::mapToQuestionReviewDTO)
                                .collect(Collectors.toList());
        }

        private QuestionReviewDTO mapToQuestionReviewDTO(UserQuestionMemory memory) {
                return QuestionReviewDTO.builder()
                                .questionId(memory.getQuestion().getQuestionId())
                                .content(memory.getQuestion().getContent())
                                .subjectName(memory.getQuestion().getTopic().getSubject().getSubjectName())
                                .memoryScore(memory.getMemoryScore() != null ? memory.getMemoryScore().doubleValue()
                                                : null)
                                .nextReviewAt(memory.getNextReviewAt())
                                .correctStreak(memory.getCorrectStreak())
                                .build();
        }
}