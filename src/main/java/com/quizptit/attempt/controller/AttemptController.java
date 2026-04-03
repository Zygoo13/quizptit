package com.quizptit.attempt.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.quizptit.attempt.dto.request.SaveAnswerRequest;
import com.quizptit.attempt.dto.response.AttemptResultResponse;
import com.quizptit.attempt.entity.Attempt;
import com.quizptit.attempt.service.AttemptService;
import com.quizptit.common.util.CurrentUserUtils;

import lombok.RequiredArgsConstructor;
import java.util.List;

@RestController
@RequestMapping("/api/attempts")
@RequiredArgsConstructor
public class AttemptController {

    private final AttemptService attemptService;

    // 1. Sinh viên bấm "Bắt đầu làm bài"
    @PostMapping("/start/{quizId}")
    public ResponseEntity<?> startAttempt(@PathVariable Long quizId) {
        Long userId = CurrentUserUtils.getCurrentUserId();
        Attempt attempt = attemptService.startAttempt(quizId, userId);

        // Thực tế ở đây bạn nên trả về một DTO chứa chi tiết các câu hỏi
        // (đã bị ẩn đáp án đúng) để Frontend render giao diện làm bài.
        return ResponseEntity.ok("Đã bắt đầu làm bài. Attempt ID: " + attempt.getAttemptId());
    }

    // 2. Lưu nháp đáp án khi sinh viên click chọn
    @PostMapping("/save-answer")
    public ResponseEntity<?> saveAnswer(@RequestBody SaveAnswerRequest request) {
        attemptService.saveAnswer(request.getAttemptQuestionId(), request.getOptionId());
        return ResponseEntity.ok().build(); // Trả về 200 OK, không cần body
    }

    // 3. Nộp bài và chấm điểm
    @PostMapping("/submit/{attemptId}")
    public ResponseEntity<AttemptResultResponse> submitAttempt(@PathVariable Long attemptId) {
        Attempt gradedAttempt = attemptService.submitAttempt(attemptId);

        AttemptResultResponse response = AttemptResultResponse.builder()
                .attemptId(gradedAttempt.getAttemptId())
                .quizTitle(gradedAttempt.getQuiz().getTitle())
                .startedAt(gradedAttempt.getStartedAt())
                .submittedAt(gradedAttempt.getSubmittedAt())
                .totalScore(gradedAttempt.getTotalScore())
                .correctCount(gradedAttempt.getCorrectCount())
                .durationSeconds(gradedAttempt.getDurationSeconds())
                .status(gradedAttempt.getStatus().name())
                .build();

        return ResponseEntity.ok(response);
    }

    // 4. Xem lịch sử làm bài của bản thân
    @GetMapping("/history")
    public ResponseEntity<List<AttemptResultResponse>> getMyHistory() {
        Long userId = CurrentUserUtils.getCurrentUserId();
        List<Attempt> history = attemptService.getUserAttemptHistory(userId);

        List<AttemptResultResponse> responses = history.stream()
                .map(a -> AttemptResultResponse.builder()
                        .attemptId(a.getAttemptId())
                        .quizTitle(a.getQuiz().getTitle())
                        .startedAt(a.getStartedAt())
                        .submittedAt(a.getSubmittedAt())
                        .totalScore(a.getTotalScore())
                        .correctCount(a.getCorrectCount())
                        .status(a.getStatus().name())
                        .build())
                .toList();

        return ResponseEntity.ok(responses);
    }

    // 5. Xem chi tiết kết quả 1 lần làm bài cụ thể
    @GetMapping("/{attemptId}")
    public ResponseEntity<AttemptResultResponse> getAttemptDetail(@PathVariable Long attemptId) {
        Long userId = CurrentUserUtils.getCurrentUserId();
        Attempt attempt = attemptService.getAttemptResultDetail(attemptId, userId);

        AttemptResultResponse response = AttemptResultResponse.builder()
                .attemptId(attempt.getAttemptId())
                .quizTitle(attempt.getQuiz().getTitle())
                .startedAt(attempt.getStartedAt())
                .submittedAt(attempt.getSubmittedAt())
                .totalScore(attempt.getTotalScore())
                .correctCount(attempt.getCorrectCount())
                .durationSeconds(attempt.getDurationSeconds())
                .status(attempt.getStatus().name())
                .build();

        return ResponseEntity.ok(response);
    }
}
