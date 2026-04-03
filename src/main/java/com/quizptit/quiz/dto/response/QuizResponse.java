package com.quizptit.quiz.dto.response;

import java.time.LocalDateTime;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class QuizResponse {
    private Long quizId;
    private String title;
    private Integer durationMinutes;
    private Integer totalQuestions;
    private LocalDateTime createdAt;
}
