package com.quizptit.community.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CommentResponse {

    private Long commentId;
    private Long postId;
    private Long parentId;

    private Long userId;
    private String email;
    private String userFullName;

    private String content;
    private String status;

    // VISIBLE | ADMIN_HIDDEN | ADMIN_DELETED | SELF_DELETED
    private String hiddenType;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private List<CommentResponse> replies;
}