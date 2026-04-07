package com.quizptit.review.dto;

import lombok.*;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ReviewOptionDTO {
    private Long optionId;
    private String content;
}