package com.quizptit.community.dto;

import lombok.*;
import java.time.LocalDateTime;

@Getter @Setter
@Builder
@NoArgsConstructor @AllArgsConstructor
public class ModerationRecordResponse {
    private Long moderationId;
    private Long postId;
    private Long commentId;
    private String content;
    private String action;
    private String reason;
    private String moderatorName; // Tên Admin thực hiện kiểm duyệt
    private LocalDateTime createdAt;
}