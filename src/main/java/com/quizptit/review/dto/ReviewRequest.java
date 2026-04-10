package com.quizptit.review.dto;

import lombok.Data;

@Data
public class ReviewRequest {
    private Long questionId;
    private Long optionId;
}