package com.quizptit.quiz.dto.request;

import lombok.Data;

@Data
public class RandomQuizRequest {
    private Long subjectId; // Tạo random theo Môn học (dùng khi topicId = null)
    private Long topicId; // Tạo random theo Chủ đề (ưu tiên hơn nếu được truyền vào)
    private String title;
    private Integer durationMinutes;
    private Integer requiredQuestions;
}
