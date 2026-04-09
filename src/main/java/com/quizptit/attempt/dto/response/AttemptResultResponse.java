package com.quizptit.attempt.dto.response;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AttemptResultResponse {
    private Long attemptId;
    private String quizTitle;
    private LocalDateTime startedAt;
    private LocalDateTime submittedAt;
    private BigDecimal totalScore;
    private Integer correctCount;
    private Integer totalQuestions;
    private Integer durationSeconds;
    private String status;
}
