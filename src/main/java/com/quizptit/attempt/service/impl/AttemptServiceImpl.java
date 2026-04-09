package com.quizptit.attempt.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.quizptit.attempt.entity.Attempt;
import com.quizptit.attempt.entity.AttemptAnswer;
import com.quizptit.attempt.entity.AttemptQuestion;
import com.quizptit.attempt.entity.enums.AttemptStatus;
import com.quizptit.attempt.repository.AttemptAnswerRepository;
import com.quizptit.attempt.repository.AttemptQuestionRepository;
import com.quizptit.attempt.repository.AttemptRepository;
import com.quizptit.attempt.service.AttemptService;
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
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicInteger;

@Service
@RequiredArgsConstructor
public class AttemptServiceImpl implements AttemptService {

        private final AttemptRepository attemptRepository;
        private final QuizRepository quizRepository;
        private final UserRepository userRepository;
        private final QuizQuestionRepository quizQuestionRepository;
        private final AttemptQuestionRepository attemptQuestionRepository;
        private final AttemptAnswerRepository attemptAnswerRepository;
        private final AnswerOptionRepository answerOptionRepository;
        private final ProgressService progressService;
        private final ReviewService reviewService;

        @Override
        @Transactional
        public Attempt startAttempt(Long quizId, Long userId) {
                Quiz quiz = quizRepository.findById(quizId)
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy bài Quiz"));

                if (!quiz.getIsPublished()) {
                        throw new RuntimeException("Bài Quiz này chưa được mở");
                }

                User user = userRepository.findById(userId)
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy User"));

                Optional<Attempt> existingAttempt = attemptRepository
                                .findFirstByUser_UserIdAndQuiz_QuizIdAndStatusOrderByStartedAtDesc(
                                                userId, quizId, AttemptStatus.IN_PROGRESS);

                if (existingAttempt.isPresent()) {
                        // Nếu CÓ làm dở -> Trả về luôn bài cũ để họ làm tiếp (không tạo thêm câu hỏi
                        // rác)
                        return existingAttempt.get();
                }
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

        @Override
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

        @Override
        @Transactional
        public Attempt submitAttempt(Long attemptId) {
                List<ReviewItemResult> reviewResults = new ArrayList<>();

                Attempt attempt = attemptRepository.findByIdWithQuiz(attemptId)
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy lượt làm bài"));

                if (attempt.getStatus() != AttemptStatus.IN_PROGRESS) {
                        throw new RuntimeException("Bài làm này đã được nộp trước đó");
                }

                LocalDateTime now = LocalDateTime.now();
                attempt.setSubmittedAt(now);
                attempt.setStatus(AttemptStatus.SUBMITTED);
                attempt.setDurationSeconds((int) Duration.between(attempt.getStartedAt(), now).getSeconds());

                // Bắt đầu quá trình chấm điểm
                List<AttemptQuestion> questions = attemptQuestionRepository.findByAttempt_AttemptId(attemptId);
                int correctCount = 0;
                int totalQuestions = questions.size();

                BigDecimal scorePerQuestion = BigDecimal.ZERO;
                if (totalQuestions > 0) {
                        scorePerQuestion = BigDecimal.valueOf(10.0 / totalQuestions)
                                        .setScale(2, java.math.RoundingMode.HALF_UP);
                }

                for (AttemptQuestion aq : questions) {
                        AttemptAnswer answer = attemptAnswerRepository
                                        .findByAttemptQuestion_AttemptQuestionId(aq.getAttemptQuestionId())
                                        .orElse(null);

                        boolean isCorrect = false;

                        if (answer != null && answer.getSelectedOption() != null) {
                                // Fix lỗi NullPointerException: Đề phòng Database bị null ở cột is_correct
                                Boolean isCorrectObj = answer.getSelectedOption().getIsCorrect();
                                isCorrect = (isCorrectObj != null) ? isCorrectObj : false;

                                answer.setIsCorrect(isCorrect);

                                if (isCorrect) {
                                        answer.setScoreObtained(scorePerQuestion);
                                        correctCount++;
                                } else {
                                        answer.setScoreObtained(BigDecimal.ZERO);
                                }
                                attemptAnswerRepository.save(answer);
                        }

                        reviewResults.add(new ReviewItemResult(aq.getQuestion(), isCorrect));
                }

                // --- TÍNH 2 LOẠI ĐIỂM: HỆ 10 CHO BẠN, HỆ 1 CHO DB ---
                BigDecimal totalScore = BigDecimal.ZERO; // Hệ 10 (Để lưu vào Attempt)
                BigDecimal ratioScore = BigDecimal.ZERO; // Hệ 1 (Để lừa cái Check Constraint)

                if (totalQuestions > 0) {
                        double ratio = (double) correctCount / totalQuestions; // Tỉ lệ 0.0 -> 1.0
                        double score10 = ratio * 10.0; // Thang điểm 10

                        totalScore = BigDecimal.valueOf(score10).setScale(2, java.math.RoundingMode.HALF_UP);
                        ratioScore = BigDecimal.valueOf(ratio).setScale(4, java.math.RoundingMode.HALF_UP);
                }

                // Cập nhật tổng điểm hệ 10 vào bảng Attempt (Bài thi của bạn vẫn y nguyên thang
                // 10)
                attempt.setCorrectCount(correctCount);
                attempt.setTotalScore(totalScore);
                attempt.setStatus(AttemptStatus.GRADED); // Chuyển sang trạng thái đã chấm điểm

                Attempt gradedAttempt = attemptRepository.save(attempt);

                // --- BÍ QUYẾT Ở ĐÂY ---
                // Gọi các service bạn bè nhưng truyền cái ratioScore (<= 1.0)
                progressService.updateQuizProgress(gradedAttempt.getUser(), gradedAttempt.getQuiz(), ratioScore);
                reviewService.updateMultipleQuestionMemories(attempt.getUser(), reviewResults);

                return gradedAttempt;
        }

        @Override
        @Transactional(readOnly = true)
        public List<Attempt> getUserAttemptHistory(Long userId) {
                return attemptRepository.findByUser_UserIdOrderByStartedAtDesc(userId);
        }

        @Override
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

        @Override
        public Attempt getAttemptById(Long attemptId) {
                return attemptRepository.findById(attemptId).orElse(null);
        }

        @Override
        @Transactional(readOnly = true)
        public Map<Long, AttemptAnswer> getAnswersMapForAttempt(Long attemptId) {
                List<AttemptAnswer> answers = attemptAnswerRepository
                                .findByAttemptQuestion_Attempt_AttemptId(attemptId);
                return answers.stream().collect(java.util.stream.Collectors.toMap(
                                a -> a.getAttemptQuestion().getAttemptQuestionId(),
                                a -> a));
        }
        // Trong AttemptService.java

        @Override
        public Long getRemainingSeconds(Attempt attempt) {
                // 1. Lấy thời gian bắt đầu và tổng thời gian cho phép (phút)
                LocalDateTime startTime = attempt.getStartedAt();
                int durationMinutes = attempt.getQuiz().getDurationMinutes();

                // 2. Tính thời gian kết thúc dự kiến
                LocalDateTime endTime = startTime.plusMinutes(durationMinutes);

                // 3. Tính số giây còn lại từ bây giờ đến lúc kết thúc
                long remaining = java.time.Duration.between(LocalDateTime.now(), endTime).getSeconds();

                // Nếu thời gian còn lại < 0 thì trả về 0 (đã hết giờ)
                return Math.max(remaining, 0);
        }
}