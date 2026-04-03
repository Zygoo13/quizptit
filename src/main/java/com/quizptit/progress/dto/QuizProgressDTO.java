package com.quizptit.progress.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class QuizProgressDTO {
    private Long quizId;
    private String quizTitle;       
    private String topicName;
    private BigDecimal highestScore;
    private Integer totalAttempts;
    private LocalDateTime lastAttemptAt;
}