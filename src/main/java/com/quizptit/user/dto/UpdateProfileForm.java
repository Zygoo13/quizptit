package com.quizptit.user.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UpdateProfileForm {

    @NotBlank(message = "Full name is required.")
    @Size(max = 100, message = "Full name must be at most 100 characters.")
    private String fullName;

}