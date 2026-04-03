package com.quizptit.review.service;

import com.quizptit.content.entity.Question;
import com.quizptit.content.repository.QuestionRepository;
import com.quizptit.common.exception.ResourceNotFoundException;
import com.quizptit.review.dto.*;
import com.quizptit.review.entity.UserQuestionMemory;
import com.quizptit.review.repository.UserQuestionMemoryRepository;
import com.quizptit.user.entity.User;
import com.quizptit.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ReviewService {
    private final UserQuestionMemoryRepository memoryRepository;
    private final QuestionRepository questionRepository;
    private final UserRepository userRepository;

    @Transactional
    public void updateQuestionMemory(User user, Question question, boolean isCorrect) {
        // 1. Tìm bản ghi cũ hoặc tạo mới nếu chưa từng làm câu này
        UserQuestionMemory memory = memoryRepository.findByUserUserIdAndQuestionQuestionId(user.getUserId(), question.getQuestionId())
                .orElse(
                    UserQuestionMemory.builder()
                        .user(user)
                        .question(question)
                        .correctStreak(0)
                        .wrongStreak(0)
                        .memoryScore(BigDecimal.valueOf(0.1))
                        .nextReviewAt(LocalDateTime.now().plusDays(1))
                        .build()
                );

        // 2. Cập nhật các chỉ số cơ bản
        memory.setLastResult(isCorrect);
        memory.setReviewCount(memory.getReviewCount() + 1);
        memory.setLastReviewedAt(LocalDateTime.now());

        if (isCorrect) {
            // Logic khi trả lời ĐÚNG
            memory.setCorrectStreak(memory.getCorrectStreak() + 1);
            memory.setWrongStreak(0);
            
            // Tính toán memory_score
            BigDecimal increment = BigDecimal.valueOf(0.1)
                    .add(BigDecimal.valueOf(0.05).multiply(BigDecimal.valueOf(memory.getCorrectStreak())));
            BigDecimal newScore = memory.getMemoryScore().add(increment);
            
            // Giới hạn tối đa của memory_score là 1.0
            if (newScore.compareTo(BigDecimal.ONE) > 0) newScore = BigDecimal.ONE;
            memory.setMemoryScore(newScore);

            // Tính ngày ôn tập tiếp theo
            long daysToAdd = Math.round(Math.pow(2, memory.getCorrectStreak() - 1) * (1 + memory.getMemoryScore().doubleValue()));
            memory.setNextReviewAt(LocalDateTime.now().plusDays(daysToAdd));
        } else {
            // Logic khi trả lời SAI
            memory.setCorrectStreak(0);
            memory.setWrongStreak(memory.getWrongStreak() + 1);
            
            // Cập nhật memory_score
            memory.setMemoryScore(memory.getMemoryScore().multiply(BigDecimal.valueOf(0.5)));

            // Ôn lại ngay vào ngày mai
            memory.setNextReviewAt(LocalDateTime.now().plusDays(1));
        }

        memoryRepository.save(memory);
    }

    @Transactional
    public void updateMultipleQuestionMemories(User user, List<ReviewItemResult> results) {
        for (ReviewItemResult res : results) {
                // Tận dụng lại hàm updateQuestionMemory đơn lẻ mà bạn đã viết rất tốt trước đó
                this.updateQuestionMemory(user, res.getQuestion(), res.isCorrect());
        }
    }

    public List<ReviewSuggestionDTO> getReviewSuggestions(Long userId) {
        return memoryRepository.findQuestionsToReview(userId, LocalDateTime.now()).stream()
                .map(this::mapToSuggestionDTO)
                .collect(Collectors.toList());
    }

    private ReviewSuggestionDTO mapToSuggestionDTO(UserQuestionMemory entity) {
        return ReviewSuggestionDTO.builder()
                .questionId(entity.getQuestion().getQuestionId())
                .contentSnippet(truncateContent(entity.getQuestion().getContent()))
                .subjectName(entity.getQuestion().getTopic().getSubject().getSubjectName())
                .memoryScore(entity.getMemoryScore().doubleValue()) // Chuyển sang double để DTO hiển thị
                .nextReviewAt(entity.getNextReviewAt())
                .isOverdue(entity.getNextReviewAt().isBefore(LocalDateTime.now()))
                .build();
    }

    private String truncateContent(String content) {
        if (content == null) return "";
        return content.length() > 100 ? content.substring(0, 100) + "..." : content;
    }

    public ReviewQuestionDTO getQuestionForReview(Long questionId) {
        Question question = questionRepository.findById(questionId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy câu hỏi"));

        return ReviewQuestionDTO.builder()
                .questionId(question.getQuestionId())
                .content(question.getContent())
                .options(question.getOptions().stream()
                        .map(opt -> ReviewOptionDTO.builder()
                                .optionId(opt.getOptionId())
                                .content(opt.getContent())
                                .build())
                        .toList())
                .build();
    }

    @Transactional
    public void processReviewResponse(Long userId, Long questionId, Long chosenOptionId) {
        // 1. Tìm Question
        Question question = questionRepository.findById(questionId) // Dùng questionId từ tham số
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy câu hỏi"));

        // 2. Tìm User (Cần tiêm UserRepository vào Service này nếu chưa có)
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy người dùng"));

        // 3. Kiểm tra đúng/sai
        boolean isCorrect = question.getOptions().stream()
                .anyMatch(opt -> opt.getOptionId().equals(chosenOptionId) && opt.getIsCorrect());

        // 4. Cập nhật trí nhớ
        this.updateQuestionMemory(user, question, isCorrect);
    }
}