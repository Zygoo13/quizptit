package com.quizptit.quiz.service;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import com.quizptit.quiz.dto.request.ManualQuizRequest;
import com.quizptit.quiz.entity.Quiz;

public interface QuizService {
        @Transactional
        Quiz createManualQuiz(ManualQuizRequest request, Long creatorId);

        @Transactional
        Quiz createRandomQuiz(Long subjectId, Long creatorId, String title, int durationMinutes,
                        int requiredQuestions);

        @Transactional(readOnly = true)
        List<Quiz> getAvailableQuizzes(Long subjectId);

        @Transactional(readOnly = true)
        Quiz getQuizDetail(Long quizId);

        @Transactional
        Quiz createRandomQuizByTopic(Long topicId, Long creatorId, String title,
                        int durationMinutes, int requiredQuestions);

        @Transactional(readOnly = true)
        List<Quiz> getAllAdminQuizzes();

        @Transactional(readOnly = true)
        Quiz getManualQuizById(Long quizId);

        @Transactional(readOnly = true)
        Map<String, Object> getManualQuizEditData(Long quizId);

        @Transactional
        Quiz updateManualQuiz(Long quizId, ManualQuizRequest request);

        @Transactional
        Quiz toggleQuizPublishStatus(Long quizId);
}
