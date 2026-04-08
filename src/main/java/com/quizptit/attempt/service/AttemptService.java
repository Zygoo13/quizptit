package com.quizptit.attempt.service;

import java.util.List;
import java.util.Map;

import com.quizptit.attempt.entity.Attempt;
import com.quizptit.attempt.entity.AttemptAnswer;

public interface AttemptService {
    Attempt getAttemptById(Long attemptId);

    Attempt getAttemptResultDetail(Long attemptId, Long userId);

    Map<Long, AttemptAnswer> getAnswersMapForAttempt(Long attemptId);

    Attempt startAttempt(Long quizId, Long userId);

    void saveAnswer(Long attemptQuestionId, Long optionId);

    Attempt submitAttempt(Long attemptId);

    List<Attempt> getUserAttemptHistory(Long userId);

    Long getRemainingSeconds(Attempt attempt);
}
