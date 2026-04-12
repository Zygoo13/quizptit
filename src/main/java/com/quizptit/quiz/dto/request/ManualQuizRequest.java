package com.quizptit.quiz.dto.request;

import java.util.List;

import lombok.Data;

@Data
public class ManualQuizRequest {
    private Long subjectId;
    private Long topicId;
    private String title;
    private int durationMinutes;
    private List<Long> questionIds;
}
