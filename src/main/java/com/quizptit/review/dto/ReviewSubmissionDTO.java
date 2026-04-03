package com.quizptit.review.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewSubmissionDTO {
    private Long questionId;      // ID câu hỏi đang trả lời
    private Long selectedOptionId; // ID phương án người dùng chọn
}