package com.quizptit.progress.dto;

import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class SubjectProgressDTO {
    private Long subjectId;
    private String subjectName;
    private int totalTopics;
    private int completedTopics;
    private double overallPercentage;
}