package com.quizptit.progress.dto;

import lombok.*;
import java.math.BigDecimal;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class QuizStatusDTO {
    private Long quizId;
    private String title;
    private BigDecimal highestScore;
    private boolean isCompleted;
}