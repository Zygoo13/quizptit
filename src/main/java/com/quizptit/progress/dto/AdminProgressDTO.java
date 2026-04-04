package com.quizptit.progress.dto;

import lombok.*;
import java.math.BigDecimal;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AdminProgressDTO {
    private Long userId;
    private String email;          // Dùng làm định danh hiển thị (thay cho MSSV)
    private String fullName;
    private Long subjectId;
    private String subjectName;
    private int completedTopics;   // Số chương đã học
    private int totalTopics;       // Tổng số chương của môn
    private BigDecimal progressPercentage;
    private BigDecimal averageScore;
    private String status;

    // Constructor bắt buộc phải đúng thứ tự để Query trong Repository hoạt động
    public AdminProgressDTO(Long userId, String email, String fullName, Long subjectId, 
                            String subjectName, Long completedTopics, 
                            BigDecimal progressPercentage, BigDecimal averageScore) {
        this.userId = userId;
        this.email = email;
        this.fullName = fullName;
        this.subjectId = subjectId;
        this.subjectName = subjectName;
        this.completedTopics = completedTopics.intValue();
        this.progressPercentage = progressPercentage;
        this.averageScore = averageScore;
    }
}