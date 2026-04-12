package com.quizptit.quiz.dto.request;

import lombok.Data;

@Data
public class RandomQuizRequest {
    private Long subjectId;
    private Long topicId;
    private String title;
    private Integer durationMinutes;
    private Integer requiredQuestions;
}
