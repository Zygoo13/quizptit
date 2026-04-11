package com.quizptit.review.dto;

import lombok.*;
import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewSubjectDTO {
    private Long subjectId;
    private String subjectName;
    private Long totalReviewCount;    // Số câu cần ôn
    private BigDecimal averageScore; // Điểm thông thạo trung bình
}