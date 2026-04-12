package com.quizptit.community.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CommentRequest {

    @NotBlank(message = "Nội dung bình luận không được để trống")
    private String content;

    private Long parentId;

    private Long questionPostId;
}