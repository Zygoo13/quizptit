package com.quizptit.community.dto;

import lombok.*;
import java.time.LocalDateTime;

@Getter @Setter
@Builder
@NoArgsConstructor @AllArgsConstructor
public class QuestionPostResponse {
    private Long questionPostId;
    private String title;
    private String content;
    private String status;
    private Long topicId;

    // Thông tin User rút gọn
    private Long userId;
    private String fullName;
    private String email;
    private Integer likeCount;
    private String topicName;
    private String themeColor;
    private long commentCount;

    // Thời gian từ BaseEntity
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}