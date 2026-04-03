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

        @Transactional
        public Attempt startAttempt(Long quizId, Long userId) {
                Quiz quiz = quizRepository.findById(quizId)
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy bài Quiz"));

                // Kiểm tra quiz đã được publish chưa
                if (!quiz.getIsPublished()) {
                        throw new RuntimeException("Bài Quiz này chưa được mở, không thể bắt đầu làm bài");
                }

                User user = userRepository.findById(userId)
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy User"));

                // 1. Tạo bản ghi Attempt mới
                Attempt attempt = Attempt.builder()
                                .user(user)
                                .quiz(quiz)
                                .startedAt(LocalDateTime.now())
                                .status(AttemptStatus.IN_PROGRESS)
                                .correctCount(0)
                                .durationSeconds(0)
                                .build();

                Attempt savedAttempt = attemptRepository.save(attempt);

                // 2. Lấy danh sách câu hỏi gốc từ Quiz
                List<QuizQuestion> originalQuestions = quizQuestionRepository
                                .findByQuiz_QuizIdOrderByOrderNoAsc(quizId);

                // Kiểm tra quiz có câu hỏi chưa
                if (originalQuestions.isEmpty()) {
                        throw new RuntimeException("Bài Quiz này chưa có câu hỏi nào, không thể bắt đầu làm bài");
                }

                // 3. Snapshot câu hỏi sang AttemptQuestion kèm order_no
                AtomicInteger orderCounter = new AtomicInteger(1);

                List<AttemptQuestion> attemptQuestions = new ArrayList<>();
                for (QuizQuestion oq : originalQuestions) {
                        AttemptQuestion attemptQuestion = AttemptQuestion.builder()
                                        .attempt(savedAttempt)
                                        .question(oq.getQuestion())
                                        .orderNo(orderCounter.getAndIncrement())
                                        .scoreWeight(oq.getScoreWeight())
                                        .build();
                        attemptQuestions.add(attemptQuestion);
                }

                attemptQuestionRepository.saveAll(attemptQuestions);

                return savedAttempt;
        }

        // 1. Lưu từng câu trả lời trong lúc làm bài
        @Transactional
        public void saveAnswer(Long attemptQuestionId, Long optionId) {
                AttemptQuestion attemptQuestion = attemptQuestionRepository.findById(attemptQuestionId)
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy câu hỏi trong đề"));

                // Kiểm tra xem Attempt còn hạn hay không (thêm logic check status IN_PROGRESS)
                if (attemptQuestion.getAttempt().getStatus() != AttemptStatus.IN_PROGRESS) {
                        throw new RuntimeException("Bài thi đã kết thúc, không thể lưu thêm đáp án");
                }

                AnswerOption selectedOption = null;
                if (optionId != null) {
                        selectedOption = answerOptionRepository.findById(optionId)
                                        .orElseThrow(() -> new RuntimeException(
                                                        "Đáp án không tồn tại (option_id = " + optionId + ")"));

                        // Kiểm tra đáp án có thuộc đúng câu hỏi này không
                        Long expectedQuestionId = attemptQuestion.getQuestion().getQuestionId();
                        Long actualQuestionId = selectedOption.getQuestion().getQuestionId();
                        if (!actualQuestionId.equals(expectedQuestionId)) {
                                throw new RuntimeException("Đáp án không hợp lệ");
                        }
                }

                // Tìm xem đã trả lời câu này chưa (Cập nhật hoặc Tạo mới)
                AttemptAnswer answer = attemptAnswerRepository
                                .findByAttemptQuestion_AttemptQuestionId(attemptQuestionId)
                                .orElse(AttemptAnswer.builder()
                                                .attemptQuestion(attemptQuestion)
                                                .build());

                answer.setSelectedOption(selectedOption);
                answer.setAnsweredAt(LocalDateTime.now());

                attemptAnswerRepository.save(answer);
        }

        // 2. Nộp bài và chấm điểm tự động
        @Transactional
        public Attempt submitAttempt(Long attemptId) {
                // Dùng findByIdWithQuiz để load Quiz trong cùng 1 query, tránh
                // LazyInitializationException
                Attempt attempt = attemptRepository.findByIdWithQuiz(attemptId)
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy lượt làm bài"));

                if (attempt.getStatus() != AttemptStatus.IN_PROGRESS) {
                        throw new RuntimeException("Bài làm này đã được nộp trước đó");
                }

                LocalDateTime now = LocalDateTime.now();
                attempt.setSubmittedAt(now);
                attempt.setStatus(AttemptStatus.SUBMITTED);
                attempt.setDurationSeconds((int) Duration.between(attempt.getStartedAt(), now).getSeconds());

                // Chấm điểm
                List<AttemptQuestion> questions = attemptQuestionRepository.findByAttempt_AttemptId(attemptId);
                int correctCount = 0;
                BigDecimal totalScore = BigDecimal.ZERO;

                for (AttemptQuestion aq : questions) {
                        // Lấy câu trả lời của sinh viên cho câu hỏi này
                        AttemptAnswer answer = attemptAnswerRepository
                                        .findByAttemptQuestion_AttemptQuestionId(aq.getAttemptQuestionId())
                                        .orElse(null);

                        if (answer != null && answer.getSelectedOption() != null) {
                                // Giả sử bảng AnswerOption có trường isCorrect() kiểu boolean
                                boolean isCorrect = answer.getSelectedOption().getIsCorrect();
                                answer.setIsCorrect(isCorrect);

                                if (isCorrect) {
                                        answer.setScoreObtained(aq.getScoreWeight()); // Lấy trọng số điểm từ
                                                                                      // AttemptQuestion
                                        correctCount++;
                                        totalScore = totalScore.add(aq.getScoreWeight());
                                } else {
                                        answer.setScoreObtained(BigDecimal.ZERO);
                                }
                                attemptAnswerRepository.save(answer);
                        }
                }

                // Cập nhật tổng điểm vào bảng Attempt
                attempt.setCorrectCount(correctCount);
                attempt.setTotalScore(totalScore);
                attempt.setStatus(AttemptStatus.GRADED); // Chuyển sang trạng thái đã chấm điểm

                // Lưu kết quả bài làm
                Attempt gradedAttempt = attemptRepository.save(attempt);

                // TODO: Tại đây, bạn sẽ gọi Interface/Event để thông báo cho Người 4 (Progress
                // + Review)
                // progressService.updateLearningProgress(gradedAttempt);

                return gradedAttempt;
        }

        // 1. Xem lịch sử làm bài của bản thân
        @Transactional(readOnly = true)
        public List<Attempt> getUserAttemptHistory(Long userId) {
                return attemptRepository.findByUser_UserIdOrderByStartedAtDesc(userId);
        }

        // 2. Xem chi tiết kết quả một lần làm bài cụ thể
        @Transactional(readOnly = true)
        public Attempt getAttemptResultDetail(Long attemptId, Long currentUserId) {
                // Dùng findByIdWithQuiz để load Quiz trong cùng 1 query
                Attempt attempt = attemptRepository.findByIdWithQuiz(attemptId)
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy lượt làm bài"));

                // Validate bảo mật: Chặn không cho sinh viên A xem điểm của sinh viên B
                if (!attempt.getUser().getUserId().equals(currentUserId)) {
                        throw new RuntimeException("Bạn không có quyền xem kết quả bài làm này");
                }

                // Chỉ cho phép xem chi tiết khi bài đã nộp hoặc đã chấm điểm
                if (attempt.getStatus() == AttemptStatus.IN_PROGRESS) {
                        throw new RuntimeException("Bài thi đang diễn ra, chưa có kết quả");
                }

                return attempt;
        }
}
