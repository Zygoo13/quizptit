package com.quizptit.review.dto;

import lombok.*;

@Data
@Builder
public class ReviewResultDTO {
    private int totalQuestions;    // Tổng số câu đã ôn tập trong lượt này
    private int correctAnswers;    // Số câu trả lời đúng
    private int memoryScoreGained; // Điểm ghi nhớ trung bình tăng thêm (nếu có tính toán)
}