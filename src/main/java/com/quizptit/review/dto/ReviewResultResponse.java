package com.quizptit.review.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ReviewResultResponse {
    @JsonProperty("isCorrect")
    private boolean isCorrect;
    private Long correctOptionId;      // ID của đáp án đúng để highlight màu xanh
    private String correctContent;     // Nội dung text của đáp án đúng
    private String feedbackMessage;    // Thông báo: "Đúng rồi" hoặc "Rất tiếc..."
}