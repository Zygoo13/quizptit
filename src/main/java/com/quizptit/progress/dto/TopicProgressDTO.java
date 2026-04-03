package com.quizptit.progress.dto;

import lombok.*;
import java.math.BigDecimal;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TopicProgressDTO {
    private Long topicId;
    private String topicName;
    private Integer totalQuizzes;
    private Integer completedQuizzes; // Số quiz đã làm ít nhất 1 lần
    private BigDecimal averageScore;   // Điểm trung bình của các quiz trong topic
}