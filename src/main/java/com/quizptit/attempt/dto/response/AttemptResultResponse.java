package com.quizptit.attempt.dto.response;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class AttemptResultResponse {
    private Long attemptId;
    private String quizTitle;
    private LocalDateTime startedAt;
    private LocalDateTime submittedAt;
    private BigDecimal totalScore;
    private Integer correctCount;
    private Integer durationSeconds;
    private String status;
}
