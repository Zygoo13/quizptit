package com.quizptit.content.service.impl;

import com.quizptit.content.entity.AnswerOption;
import com.quizptit.content.repository.AnswerOptionRepository;
import com.quizptit.content.service.AnswerOptionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AnswerOptionServiceImpl implements AnswerOptionService {

    @Autowired
    private AnswerOptionRepository answerOptionRepository;

    @Override
    public List<AnswerOption> getOptionsByQuestionId(Long questionId) {
        return answerOptionRepository.findByQuestionQuestionId(questionId);
    }

    @Override
    public AnswerOption getOptionById(Long optionId) {
        return answerOptionRepository.findById(optionId)
                .orElseThrow(() -> new RuntimeException("Answer option not found"));
    }

    @Override
    public AnswerOption createOption(AnswerOption option) {
        if (answerOptionRepository.existsByQuestionQuestionIdAndOptionLabel(
                option.getQuestion().getQuestionId(), option.getOptionLabel())) {
            throw new RuntimeException("Option label already exists for this question");
        }
        return answerOptionRepository.save(option);
    }

    @Override
    public AnswerOption updateOption(Long optionId, AnswerOption optionDetails) {
        if (answerOptionRepository.existsByQuestionQuestionIdAndOptionLabelAndOptionIdNot(
                optionDetails.getQuestion().getQuestionId(), optionDetails.getOptionLabel(), optionId)) {
            throw new RuntimeException("Option label already exists for this question");
        }
        AnswerOption option = getOptionById(optionId);
        option.setOptionLabel(optionDetails.getOptionLabel());
        option.setContent(optionDetails.getContent());
        option.setIsCorrect(optionDetails.getIsCorrect());
        return answerOptionRepository.save(option);
    }

    @Override
    public void deleteOption(Long optionId) {
        AnswerOption option = getOptionById(optionId);
        answerOptionRepository.delete(option);
    }
}
