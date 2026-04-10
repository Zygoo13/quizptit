package com.quizptit.community.dto;

import lombok.*;
import java.time.LocalDateTime;
import java.util.List;

@Getter @Setter
@Builder
@NoArgsConstructor @AllArgsConstructor
public class CommentResponse {
    private Long commentId;
    private String content;
    private Long postId;
    private Long userId;
    private String email;
    private String userFullName;
    private LocalDateTime createdAt;
    private String status;

    private Long parentId; // Để biết đây là phản hồi của cmt nào (nếu cần xử lý logic ở JS)
    private List<CommentResponse> replies; // Chứa các phản hồi con (cấp 2)
}