package com.quizptit.community.dto;

import lombok.*;
import java.time.LocalDateTime;

@Getter @Setter
@Builder
@NoArgsConstructor @AllArgsConstructor
public class CommentResponse {
    private Long commentId;
    private String content;
    private Long postId;
    private Long userId;
    private String userFullName; // Trả về tên để hiển thị luôn
    private LocalDateTime createdAt;
}