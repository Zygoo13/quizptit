package com.quizptit.review.service;

import com.quizptit.content.entity.Question;
import com.quizptit.content.repository.QuestionRepository;
import com.quizptit.common.exception.ResourceNotFoundException;
import com.quizptit.review.dto.*;
import com.quizptit.review.entity.UserQuestionMemory;
import com.quizptit.review.repository.UserQuestionMemoryRepository;
import com.quizptit.progress.dto.QuestionReviewDTO;
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
        // 1. Tìm bản ghi cũ hoặc khởi tạo đối tượng mới (dùng Builder)
        UserQuestionMemory memory = memoryRepository.findByUserUserIdAndQuestionQuestionId(user.getUserId(), question.getQuestionId())
                .orElse(UserQuestionMemory.builder()
                        .user(user)
                        .question(question)
                        .correctStreak(0)
                        .wrongStreak(0)
                        .reviewCount(0) // Khởi tạo để tránh NPE
                        .memoryScore(BigDecimal.valueOf(0.1))
                        .nextReviewAt(LocalDateTime.now().plusDays(1))
                        .build());

        // 2. Cập nhật các chỉ số cơ bản
        memory.setLastResult(isCorrect);
        memory.setReviewCount(memory.getReviewCount() + 1);
        memory.setLastReviewedAt(LocalDateTime.now());

        if (isCorrect) {
            // Logic khi trả lời ĐÚNG
            memory.setCorrectStreak(memory.getCorrectStreak() + 1);
            memory.setWrongStreak(0);
            
            // Tính toán memory_score: Tăng dần dựa trên chuỗi đúng
            BigDecimal increment = BigDecimal.valueOf(0.1)
                    .add(BigDecimal.valueOf(0.05).multiply(BigDecimal.valueOf(memory.getCorrectStreak())));
            BigDecimal newScore = memory.getMemoryScore().add(increment);
            
            // Giới hạn tối đa của memory_score là 1.0 (Hoàn toàn ghi nhớ)
            if (newScore.compareTo(BigDecimal.ONE) > 0) newScore = BigDecimal.ONE;
            memory.setMemoryScore(newScore);

            // Tính ngày ôn tập tiếp theo (Sử dụng hàm mũ để giãn cách ngày ôn)
            long daysToAdd = Math.round(Math.pow(2, memory.getCorrectStreak() - 1) * (1 + memory.getMemoryScore().doubleValue()));
            memory.setNextReviewAt(LocalDateTime.now().plusDays(daysToAdd));
        } else {
            // Logic khi trả lời SAI
            memory.setCorrectStreak(0);
            memory.setWrongStreak(memory.getWrongStreak() + 1);
            
            // Phạt memory_score: Giảm đi một nửa
            memory.setMemoryScore(memory.getMemoryScore().multiply(BigDecimal.valueOf(0.5)));

            // Buộc ôn lại ngay vào ngày mai
            memory.setNextReviewAt(LocalDateTime.now().plusDays(1));
        }

        memoryRepository.save(memory);
    }

    @Transactional
    public void updateMultipleQuestionMemories(User user, List<ReviewItemResult> results) {
        if (results != null) {
            for (ReviewItemResult res : results) {
                this.updateQuestionMemory(user, res.getQuestion(), res.isCorrect());
            }
        }
    }
    
    @Transactional(readOnly = true)
    public List<ReviewSuggestionDTO> getReviewSuggestions(Long userId) {
        return memoryRepository.findQuestionsToReview(userId, LocalDateTime.now()).stream()
                .map(this::mapToSuggestionDTO)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<ReviewSubjectDTO> getSubjectsReviewStatus(Long userId) {
        return memoryRepository.findReviewDashboardData(userId, LocalDateTime.now());
    }

    @Transactional(readOnly = true)
    public List<QuestionReviewDTO> getQuestionsBySubject(Long userId, Long subjectId) {
        return memoryRepository.findQuestionsToReviewBySubject(userId, subjectId, LocalDateTime.now());
    }

    private ReviewSuggestionDTO mapToSuggestionDTO(UserQuestionMemory entity) {
        return ReviewSuggestionDTO.builder()
                .questionId(entity.getQuestion().getQuestionId())
                .contentSnippet(truncateContent(entity.getQuestion().getContent()))
                .subjectName(entity.getQuestion().getTopic().getSubject().getSubjectName())
                .memoryScore(entity.getMemoryScore() != null ? entity.getMemoryScore().doubleValue() : 0.0)
                .nextReviewAt(entity.getNextReviewAt())
                .isOverdue(entity.getNextReviewAt().isBefore(LocalDateTime.now()))
                .build();
    }

    private String truncateContent(String content) {
        if (content == null) return "";
        return content.length() > 100 ? content.substring(0, 100) + "..." : content;
    }

    @Transactional(readOnly = true)
    public ReviewQuestionDTO getQuestionForReview(Long questionId) {
        Question question = questionRepository.findById(questionId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy câu hỏi với ID: " + questionId));

        return ReviewQuestionDTO.builder()
                .questionId(question.getQuestionId())
                .content(question.getContent())
                .options(question.getOptions().stream()
                        .map(opt -> ReviewOptionDTO.builder()
                                .optionId(opt.getOptionId())
                                .content(opt.getContent())
                                .build())
                        .collect(Collectors.toList()))
                .build();
    }

    @Transactional
    public void processReviewResponse(Long userId, Long questionId, Long chosenOptionId) {
        Question question = questionRepository.findById(questionId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy câu hỏi"));

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy người dùng"));

        // Kiểm tra đúng/sai: Sử dụng phương thức getter chuẩn của Lombok cho kiểu boolean (isCorrect())
        boolean isCorrect = question.getOptions().stream()
                .anyMatch(opt -> opt.getOptionId().equals(chosenOptionId) && opt.getIsCorrect());

        this.updateQuestionMemory(user, question, isCorrect);
    }
}