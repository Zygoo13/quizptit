package com.quizptit.review.dto;

import lombok.*;
import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ReviewSuggestionDTO {
    private Long questionId;
    private String contentSnippet;
    private String subjectName;
    private Double memoryScore;
    private LocalDateTime nextReviewAt;
    private boolean isOverdue;
}