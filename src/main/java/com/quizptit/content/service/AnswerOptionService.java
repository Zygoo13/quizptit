package com.quizptit.content.service;

import com.quizptit.content.entity.AnswerOption;

import java.util.List;

public interface AnswerOptionService {
    List<AnswerOption> getOptionsByQuestionId(Long questionId);

    AnswerOption getOptionById(Long optionId);

    AnswerOption createOption(AnswerOption option);

    AnswerOption updateOption(Long optionId, AnswerOption optionDetails);

    void deleteOption(Long optionId);
}
