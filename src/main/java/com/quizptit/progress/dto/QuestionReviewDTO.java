package com.quizptit.progress.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class QuestionReviewDTO {
    private Long questionId;
    private String content;
    private String topicName;
}