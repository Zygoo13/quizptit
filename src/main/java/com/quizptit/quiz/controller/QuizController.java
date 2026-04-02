package com.quizptit.quiz.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.quizptit.common.util.CurrentUserUtils;
import com.quizptit.quiz.dto.request.ManualQuizRequest;
import com.quizptit.quiz.dto.request.RandomQuizRequest;
import com.quizptit.quiz.dto.response.QuizResponse;
import com.quizptit.quiz.entity.Quiz;
import com.quizptit.quiz.service.QuizService;

import lombok.RequiredArgsConstructor;
import java.util.List;

@RestController
@RequestMapping("/api/quizzes")
@RequiredArgsConstructor
public class QuizController {

    private final QuizService quizService;

    // --- API CHO ADMIN / GIẢNG VIÊN ---

    @PostMapping("/manual")
    public ResponseEntity<?> createManualQuiz(@RequestBody ManualQuizRequest request) {
        // Lấy ID người tạo từ Security Context (Giả sử bạn có class CurrentUserUtils)
        Long creatorId = CurrentUserUtils.getCurrentUserId();

        Quiz quiz = quizService.createManualQuiz(
                request.getSubjectId(), creatorId, request.getTitle(),
                request.getDurationMinutes(), request.getQuestionIds());
        return ResponseEntity.ok("Tạo đề thủ công thành công, ID: " + quiz.getQuizId());
    }

    @PostMapping("/random")
    public ResponseEntity<?> createRandomQuiz(@RequestBody RandomQuizRequest request) {
        Long creatorId = CurrentUserUtils.getCurrentUserId();

        Quiz quiz = quizService.createRandomQuiz(
                request.getSubjectId(), creatorId, request.getTitle(),
                request.getDurationMinutes(), request.getRequiredQuestions());
        return ResponseEntity.ok("Tạo đề ngẫu nhiên thành công, ID: " + quiz.getQuizId());
    }

    // --- API CHO SINH VIÊN ---

    @GetMapping
    public ResponseEntity<List<QuizResponse>> getAvailableQuizzes(
            @RequestParam(required = false) Long subjectId) {

        List<Quiz> quizzes = quizService.getAvailableQuizzes(subjectId);

        // Map Entity sang DTO
        List<QuizResponse> responses = quizzes.stream()
                .map(q -> QuizResponse.builder()
                        .quizId(q.getQuizId())
                        .title(q.getTitle())
                        .durationMinutes(q.getDurationMinutes())
                        .totalQuestions(q.getTotalQuestions())
                        .createdAt(q.getCreatedAt())
                        .build())
                .toList();

        return ResponseEntity.ok(responses);
    }
}
