package com.quizptit.content.service;

import com.quizptit.content.entity.Question;
import com.quizptit.common.constant.QuestionStatus;
import com.quizptit.common.constant.DifficultyLevel;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface QuestionService {
    Page<Question> searchQuestions(Long topicId, QuestionStatus status, DifficultyLevel difficulty, String keyword,
            Pageable pageable);

    Question getQuestionById(Long questionId);

    Question createQuestion(Question question, Long userId);

    Question updateQuestion(Long questionId, Question questionDetails);

    void changeStatus(Long questionId, QuestionStatus newStatus);
}
