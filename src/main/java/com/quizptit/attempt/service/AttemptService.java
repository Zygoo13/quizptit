package com.quizptit.attempt.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.quizptit.attempt.entity.Attempt;
import com.quizptit.attempt.entity.AttemptAnswer;
import com.quizptit.attempt.entity.AttemptQuestion;
import com.quizptit.attempt.entity.enums.AttemptStatus;
import com.quizptit.attempt.repository.AttemptAnswerRepository;
import com.quizptit.attempt.repository.AttemptQuestionRepository;
import com.quizptit.attempt.repository.AttemptRepository;
import com.quizptit.content.entity.AnswerOption;
import com.quizptit.content.repository.AnswerOptionRepository;
import com.quizptit.progress.service.ProgressService;
import com.quizptit.review.dto.ReviewItemResult;
import com.quizptit.review.service.ReviewService;
import com.quizptit.quiz.entity.Quiz;
import com.quizptit.quiz.entity.QuizQuestion;
import com.quizptit.quiz.repository.QuizQuestionRepository;
import com.quizptit.quiz.repository.QuizRepository;
import com.quizptit.user.entity.User;
import com.quizptit.user.repository.UserRepository;

import lombok.RequiredArgsConstructor;

import java.math.BigDecimal;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

@Service
@RequiredArgsConstructor
public class AttemptService {

        private final AttemptRepository attemptRepository;
        private final QuizRepository quizRepository;
        private final UserRepository userRepository;
        private final QuizQuestionRepository quizQuestionRepository;
        private final AttemptQuestionRepository attemptQuestionRepository;
        private final AttemptAnswerRepository attemptAnswerRepository;
        private final AnswerOptionRepository answerOptionRepository;
        private final ProgressService progressService;
        private final ReviewService reviewService;

        @Transactional
        public Attempt startAttempt(Long quizId, Long userId) {
                Quiz quiz = quizRepository.findById(quizId)
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy bài Quiz"));

                if (!quiz.getIsPublished()) {
                        throw new RuntimeException("Bài Quiz này chưa được mở");
                }

                User user = userRepository.findById(userId)
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy User"));

                Attempt attempt = Attempt.builder()
                                .user(user)
                                .quiz(quiz)
                                .startedAt(LocalDateTime.now())
                                .status(AttemptStatus.IN_PROGRESS)
                                .correctCount(0)
                                .durationSeconds(0)
                                .build();

                Attempt savedAttempt = attemptRepository.save(attempt);

                List<QuizQuestion> originalQuestions = quizQuestionRepository
                                .findByQuiz_QuizIdOrderByOrderNoAsc(quizId);

                if (originalQuestions.isEmpty()) {
                        throw new RuntimeException("Quiz chưa có câu hỏi");
                }

                AtomicInteger orderCounter = new AtomicInteger(1);

                List<AttemptQuestion> attemptQuestions = new ArrayList<>();
                for (QuizQuestion oq : originalQuestions) {
                        attemptQuestions.add(
                                        AttemptQuestion.builder()
                                                        .attempt(savedAttempt)
                                                        .question(oq.getQuestion())
                                                        .orderNo(orderCounter.getAndIncrement())
                                                        .scoreWeight(oq.getScoreWeight())
                                                        .build());
                }

                attemptQuestionRepository.saveAll(attemptQuestions);
                return savedAttempt;
        }

        @Transactional
        public void saveAnswer(Long attemptQuestionId, Long optionId) {
                AttemptQuestion attemptQuestion = attemptQuestionRepository.findById(attemptQuestionId)
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy câu hỏi"));

                if (attemptQuestion.getAttempt().getStatus() != AttemptStatus.IN_PROGRESS) {
                        throw new RuntimeException("Bài thi đã kết thúc");
                }

                AnswerOption selectedOption = null;
                if (optionId != null) {
                        selectedOption = answerOptionRepository.findById(optionId)
                                        .orElseThrow(() -> new RuntimeException("Đáp án không tồn tại"));

                        if (!selectedOption.getQuestion().getQuestionId()
                                        .equals(attemptQuestion.getQuestion().getQuestionId())) {
                                throw new RuntimeException("Đáp án không hợp lệ");
                        }
                }

                AttemptAnswer answer = attemptAnswerRepository
                                .findByAttemptQuestion_AttemptQuestionId(attemptQuestionId)
                                .orElse(AttemptAnswer.builder()
                                                .attemptQuestion(attemptQuestion)
                                                .build());

                answer.setSelectedOption(selectedOption);
                answer.setAnsweredAt(LocalDateTime.now());

                attemptAnswerRepository.save(answer);
        }

        @Transactional
        public Attempt submitAttempt(Long attemptId) {
                List<ReviewItemResult> reviewResults = new ArrayList<>();

                Attempt attempt = attemptRepository.findByIdWithQuiz(attemptId)
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy lượt làm bài"));

                if (attempt.getStatus() != AttemptStatus.IN_PROGRESS) {
                        throw new RuntimeException("Đã nộp rồi");
                }

                LocalDateTime now = LocalDateTime.now();
                attempt.setSubmittedAt(now);
                attempt.setStatus(AttemptStatus.SUBMITTED);
                attempt.setDurationSeconds((int) Duration.between(attempt.getStartedAt(), now).getSeconds());

                List<AttemptQuestion> questions = attemptQuestionRepository.findByAttempt_AttemptId(attemptId);

                int correctCount = 0;
                BigDecimal totalScore = BigDecimal.ZERO;

                for (AttemptQuestion aq : questions) {
                        AttemptAnswer answer = attemptAnswerRepository
                                        .findByAttemptQuestion_AttemptQuestionId(aq.getAttemptQuestionId())
                                        .orElse(null);

                        if (answer != null && answer.getSelectedOption() != null) {
                                boolean isCorrect = answer.getSelectedOption().getIsCorrect();
                                answer.setIsCorrect(isCorrect);

                                if (isCorrect) {
                                        answer.setScoreObtained(aq.getScoreWeight());
                                        correctCount++;
                                        totalScore = totalScore.add(aq.getScoreWeight());
                                } else {
                                        answer.setScoreObtained(BigDecimal.ZERO);
                                }

                                attemptAnswerRepository.save(answer);
                                reviewResults.add(new ReviewItemResult(aq.getQuestion(), isCorrect));
                        }
                }

                attempt.setCorrectCount(correctCount);
                attempt.setTotalScore(totalScore);
                attempt.setStatus(AttemptStatus.GRADED);

                Attempt gradedAttempt = attemptRepository.save(attempt);

                progressService.updateQuizProgress(
                                gradedAttempt.getUser(),
                                gradedAttempt.getQuiz(),
                                gradedAttempt.getTotalScore());

                reviewService.updateMultipleQuestionMemories(
                                gradedAttempt.getUser(),
                                reviewResults);

                return gradedAttempt;
        }

        @Transactional(readOnly = true)
        public List<Attempt> getUserAttemptHistory(Long userId) {
                return attemptRepository.findByUser_UserIdOrderByStartedAtDesc(userId);
        }

        @Transactional(readOnly = true)
        public Attempt getAttemptResultDetail(Long attemptId, Long currentUserId) {
                Attempt attempt = attemptRepository.findByIdWithQuiz(attemptId)
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy"));

                if (!attempt.getUser().getUserId().equals(currentUserId)) {
                        throw new RuntimeException("Không có quyền");
                }

                if (attempt.getStatus() == AttemptStatus.IN_PROGRESS) {
                        throw new RuntimeException("Chưa có kết quả");
                }

                return attempt;
        }
}