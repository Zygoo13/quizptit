package com.quizptit.review.dto;

import lombok.*;
import java.math.BigDecimal;

@Data
@NoArgsConstructor
public class ReviewSubjectDTO {
    private Long subjectId;
    private String subjectName;
    private Long totalReviewCount;    // Số câu cần ôn
    private BigDecimal averageScore; // Điểm thông thạo trung bình

    public ReviewSubjectDTO(Long subjectId, String subjectName, Long totalReviewCount, BigDecimal averageScore) {
        this.subjectId = subjectId;
        this.subjectName = subjectName;
        this.totalReviewCount = totalReviewCount != null ? totalReviewCount : 0L;
        this.averageScore = (averageScore != null) 
            ? averageScore.setScale(2, java.math.RoundingMode.HALF_UP) 
            : BigDecimal.ZERO;
    }
}