package com.quizptit.review.service;

import com.quizptit.content.entity.AnswerOption;
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

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.math.BigDecimal;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ReviewService {
    private final UserQuestionMemoryRepository memoryRepository;
    private final QuestionRepository questionRepository;
    private final UserRepository userRepository;

    @Transactional
    public void updateQuestionMemory(Long userId, Question question, boolean isCorrect) {
        UserQuestionMemory memory = memoryRepository.findByUserUserIdAndQuestionQuestionId(userId, question.getQuestionId())
                .orElseGet(() -> UserQuestionMemory.builder()
                        .user(userRepository.getReferenceById(userId))
                        .question(question)
                        .correctStreak(0)
                        .memoryScore(BigDecimal.valueOf(0.1))
                        .build());

        memory.setLastResult(isCorrect);
        memory.setLastReviewedAt(LocalDateTime.now());

        if (isCorrect) {
            memory.setCorrectStreak(memory.getCorrectStreak() + 1);
            
            // Công thức Spaced Repetition
            BigDecimal increment = BigDecimal.valueOf(0.1).add(BigDecimal.valueOf(0.05).multiply(BigDecimal.valueOf(memory.getCorrectStreak())));
            BigDecimal newScore = memory.getMemoryScore().add(increment);
            if (newScore.compareTo(BigDecimal.ONE) > 0) newScore = BigDecimal.ONE;
            memory.setMemoryScore(newScore);

            // Tính ngày: $$daysToAdd = \text{round}(2^{\text{streak}-1} \times (1 + \text{score}))$$
            long daysToAdd = Math.round(Math.pow(2, memory.getCorrectStreak() - 1) * (1 + memory.getMemoryScore().doubleValue()));
            memory.setNextReviewAt(LocalDateTime.now().plusDays(daysToAdd).truncatedTo(ChronoUnit.DAYS));
        } else {
            memory.setCorrectStreak(0);
            memory.setMemoryScore(memory.getMemoryScore().multiply(BigDecimal.valueOf(0.5)));
            memory.setNextReviewAt(LocalDateTime.now().plusDays(1).truncatedTo(ChronoUnit.DAYS));
        }
        memoryRepository.save(memory);
    }

    @Transactional
    public void updateMultipleQuestionMemories(User user, List<ReviewItemResult> results) {
        if (results != null) {
            for (ReviewItemResult res : results) {
                // Truyền user.getUserId() để khớp với kiểu Long của hàm trên
                this.updateQuestionMemory(user.getUserId(), res.getQuestion(), res.isCorrect());
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
    public ReviewResultResponse processReviewResponse(Long userId, Long questionId, Long chosenOptionId) {
        Question question = questionRepository.findById(questionId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy câu hỏi"));

        AnswerOption correctOpt = question.getOptions().stream()
                .filter(opt -> Boolean.TRUE.equals(opt.getIsCorrect()))
                .findFirst()
                .orElseThrow(() -> new RuntimeException("Câu hỏi thiếu đáp án đúng"));

        // Đảm bảo so sánh chính xác ID (ép kiểu về Long nếu cần)
        boolean isCorrect = Objects.equals(correctOpt.getOptionId(), chosenOptionId);

        // Cập nhật trí nhớ
        this.updateQuestionMemory(userId, question, isCorrect);

        // QUAN TRỌNG: Kiểm tra kỹ thứ tự gán isCorrect ở đây
        return ReviewResultResponse.builder()
                .isCorrect(isCorrect) // Biến này phải đúng là true/false
                .correctOptionId(correctOpt.getOptionId())
                .correctContent(correctOpt.getContent())
                .feedbackMessage(isCorrect ? "Chính xác! Bạn ghi nhớ rất tốt." : "Rất tiếc! Đáp án đúng phải là: " + correctOpt.getContent())
                .build();
    }
}