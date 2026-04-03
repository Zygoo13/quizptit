package com.quizptit.progress.dto;

import lombok.*;
import java.math.BigDecimal;

@Data
@Builder
public class AdminProgressDTO {
    private Long userId;
    private String fullName;
    private String studentCode;    // Mã sinh viên
    private int quizzesCompleted;  // Số lượng bài trắc nghiệm đã hoàn thành
    private BigDecimal avgScore;   // Điểm trung bình cộng của sinh viên đó
}