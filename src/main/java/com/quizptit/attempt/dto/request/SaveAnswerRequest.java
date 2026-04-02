package com.quizptit.attempt.dto.request;

import lombok.Data;

@Data
public class SaveAnswerRequest {
    private Long attemptQuestionId;
    private Long optionId;
}
