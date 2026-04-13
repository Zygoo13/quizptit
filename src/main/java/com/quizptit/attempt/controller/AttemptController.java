package com.quizptit.attempt.controller;

import com.quizptit.attempt.dto.request.SaveAnswerRequest;
import com.quizptit.attempt.dto.response.AttemptResultResponse;
import com.quizptit.attempt.entity.Attempt;
import com.quizptit.attempt.service.impl.AttemptServiceImpl;
import com.quizptit.common.util.CurrentUserUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/attempts")
@RequiredArgsConstructor
public class AttemptController {

    private final AttemptServiceImpl attemptService;

    @PostMapping("/start/{quizId}")
    public ResponseEntity<?> startAttempt(@PathVariable Long quizId) {
        Long userId = CurrentUserUtils.getCurrentUserId();

        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(Map.of("message", "Vui lòng đăng nhập để bắt đầu làm bài."));
        }

        Attempt attempt = attemptService.startAttempt(quizId, userId);
        return ResponseEntity.ok(Map.of("attemptId", attempt.getAttemptId()));
    }

    @PostMapping("/save-answer")
    public ResponseEntity<?> saveAnswer(@RequestBody SaveAnswerRequest request) {
        Long userId = CurrentUserUtils.getCurrentUserId();

        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(Map.of("message", "Phiên đăng nhập không hợp lệ."));
        }

        attemptService.saveAnswer(request.getAttemptQuestionId(), request.getOptionId());
        return ResponseEntity.ok().build();
    }

    @PostMapping("/submit/{attemptId}")
    public ResponseEntity<?> submitAttempt(@PathVariable Long attemptId) {
        Long userId = CurrentUserUtils.getCurrentUserId();

        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(Map.of("message", "Vui lòng đăng nhập để nộp bài."));
        }

        Attempt gradedAttempt = attemptService.submitAttempt(attemptId);

        AttemptResultResponse response = AttemptResultResponse.builder()
                .attemptId(gradedAttempt.getAttemptId())
                .quizTitle(gradedAttempt.getQuiz().getTitle())
                .startedAt(gradedAttempt.getStartedAt())
                .submittedAt(gradedAttempt.getSubmittedAt())
                .totalScore(gradedAttempt.getTotalScore())
                .correctCount(gradedAttempt.getCorrectCount())
                .totalQuestions(gradedAttempt.getTotalQuestions())
                .durationSeconds(gradedAttempt.getDurationSeconds())
                .status(gradedAttempt.getStatus().name())
                .build();

        return ResponseEntity.ok(response);
    }

    @GetMapping("/history")
    public ResponseEntity<?> getMyHistory() {
        Long userId = CurrentUserUtils.getCurrentUserId();

        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(Map.of("message", "Vui lòng đăng nhập để xem lịch sử làm bài."));
        }

        List<Attempt> history = attemptService.getUserAttemptHistory(userId);

        List<AttemptResultResponse> responses = history.stream()
                .map(a -> AttemptResultResponse.builder()
                        .attemptId(a.getAttemptId())
                        .quizTitle(a.getQuiz().getTitle())
                        .startedAt(a.getStartedAt())
                        .submittedAt(a.getSubmittedAt())
                        .totalScore(a.getTotalScore())
                        .correctCount(a.getCorrectCount())
                        .totalQuestions(a.getTotalQuestions())
                        .status(a.getStatus().name())
                        .build())
                .toList();

        return ResponseEntity.ok(responses);
    }

    @GetMapping("/{attemptId}")
    public ResponseEntity<?> getAttemptDetail(@PathVariable Long attemptId) {
        Long userId = CurrentUserUtils.getCurrentUserId();

        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(Map.of("message", "Vui lòng đăng nhập để xem chi tiết bài làm."));
        }

        Attempt attempt = attemptService.getAttemptResultDetail(attemptId, userId);

        AttemptResultResponse response = AttemptResultResponse.builder()
                .attemptId(attempt.getAttemptId())
                .quizTitle(attempt.getQuiz().getTitle())
                .startedAt(attempt.getStartedAt())
                .submittedAt(attempt.getSubmittedAt())
                .totalScore(attempt.getTotalScore())
                .correctCount(attempt.getCorrectCount())
                .totalQuestions(attempt.getTotalQuestions())
                .durationSeconds(attempt.getDurationSeconds())
                .status(attempt.getStatus().name())
                .build();

        return ResponseEntity.ok(response);
    }
}