package com.quizptit.user.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ChangeUserRoleForm {

    @NotBlank(message = "Role is required.")
    private String roleName;
}