package com.quizptit.progress.dto;

import lombok.*;
import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class QuestionReviewDTO {
    private Long questionId;
    private String content;
    private String subjectName; // PHẢI CÓ DÒNG NÀY để Builder hoạt động
    private Double memoryScore;
    private LocalDateTime nextReviewAt;
    private Integer correctStreak;
}