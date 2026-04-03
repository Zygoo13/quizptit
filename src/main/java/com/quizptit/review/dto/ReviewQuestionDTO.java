package com.quizptit.review.dto;

import lombok.*;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ReviewQuestionDTO {
    private Long questionId;
    private String content;
    private List<ReviewOptionDTO> options;
    private Integer correctStreak;
}