package com.quizptit.community.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.*;

@Getter @Setter
@Builder // Thêm builder để dùng trong Service nếu cần
@NoArgsConstructor @AllArgsConstructor
public class ModerationRecordRequest {

    @NotBlank(message = "Hành động kiểm duyệt không được để trống")
    private String action;

    @NotBlank(message = "Lý do kiểm duyệt không được để trống")
    private String reason;
}