package com.quizptit.review.dto;

import com.quizptit.content.entity.Question;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ReviewItemResult {
    private Question question;
    private boolean isCorrect;
}