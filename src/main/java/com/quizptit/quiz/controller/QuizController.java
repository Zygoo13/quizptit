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
        Quiz quiz;

        if (request.getTopicId() != null) {
            // Ưu tiên tạo theo Chủ đề nếu topicId được truyền vào
            quiz = quizService.createRandomQuizByTopic(
                    request.getTopicId(), creatorId, request.getTitle(),
                    request.getDurationMinutes(), request.getRequiredQuestions());
            return ResponseEntity.ok("Tạo đề ngẫu nhiên theo chủ đề thành công, ID: " + quiz.getQuizId());
        } else if (request.getSubjectId() != null) {
            // Tạo theo Môn học nếu chỉ có subjectId
            quiz = quizService.createRandomQuiz(
                    request.getSubjectId(), creatorId, request.getTitle(),
                    request.getDurationMinutes(), request.getRequiredQuestions());
            return ResponseEntity.ok("Tạo đề ngẫu nhiên theo môn học thành công, ID: " + quiz.getQuizId());
        } else {
            return ResponseEntity.badRequest().body("Phải truyền vào subjectId hoặc topicId");
        }
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

    // Xem chi tiết 1 bài luyện (sinh viên xem trước khi bấm Bắt đầu)
    @GetMapping("/{quizId}")
    public ResponseEntity<QuizResponse> getQuizDetail(@PathVariable Long quizId) {
        Quiz quiz = quizService.getQuizDetail(quizId);
        QuizResponse response = QuizResponse.builder()
                .quizId(quiz.getQuizId())
                .title(quiz.getTitle())
                .durationMinutes(quiz.getDurationMinutes())
                .totalQuestions(quiz.getTotalQuestions())
                .createdAt(quiz.getCreatedAt())
                .build();
        return ResponseEntity.ok(response);
    }
}
