package com.quizptit.attempt.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.quizptit.attempt.entity.Attempt;
import com.quizptit.attempt.entity.AttemptQuestion;
import com.quizptit.attempt.entity.enums.AttemptStatus;
import com.quizptit.attempt.repository.AttemptQuestionRepository;
import com.quizptit.attempt.repository.AttemptRepository;
import com.quizptit.quiz.entity.Quiz;
import com.quizptit.quiz.entity.QuizQuestion;
import com.quizptit.quiz.repository.QuizQuestionRepository;
import com.quizptit.quiz.repository.QuizRepository;
import com.quizptit.user.entity.User;
import com.quizptit.user.repository.UserRepository;

import lombok.RequiredArgsConstructor;
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

    private final ProgressService progressService;

    @Transactional
    public Attempt startAttempt(Long quizId, Long userId) {
        Quiz quiz = quizRepository.findById(quizId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy bài Quiz"));
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

        // 2. Lấy danh sách câu hỏi gốc từ Quiz (nhớ query order by orderNo để giữ đúng
        // thứ tự đề)
        List<QuizQuestion> originalQuestions = quizQuestionRepository.findByQuiz_QuizIdOrderByOrderNoAsc(quizId);

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

    // Chờ finishAttempt để chèn progressService.updateQuizProgress
}
