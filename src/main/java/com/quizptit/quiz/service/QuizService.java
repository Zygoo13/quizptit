package com.quizptit.quiz.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.quizptit.content.entity.Question;
import com.quizptit.content.entity.Subject;
import com.quizptit.content.repository.SubjectRepository;
import com.quizptit.quiz.entity.Quiz;
import com.quizptit.quiz.entity.QuizQuestion;
import com.quizptit.quiz.entity.enums.QuizType;
import com.quizptit.quiz.repository.QuizQuestionRepository;
import com.quizptit.quiz.repository.QuizRepository;
import com.quizptit.user.entity.User;
import com.quizptit.user.repository.UserRepository;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class QuizService {
    private final QuizRepository quizRepository;
    private final UserRepository userRepository;
    private final QuizQuestionRepository quizQuestionRepository;
    private final SubjectRepository subjectRepository;

    @Transactional
    public Quiz createManualQuiz(Long subjectId, Long creatorId, String title, int duration, List<Long> questionIds) {
        Subject subject = subjectRepository.findById(subjectId)
                .orElseThrow(() -> new RuntimeException("Subject not found"));
        User creator = userRepository.findById(creatorId).orElseThrow(() -> new RuntimeException("Creator not found"));
        Quiz savedQuiz = Quiz.builder()
                .subject(subject)
                .createdBy(creator)
                .title(title)
                .quizType(QuizType.MANUAL)
                .durationMinutes(duration)
                .totalQuestions(questionIds.size())
                .isPublished(false)
                .build();
        quizRepository.save(savedQuiz);
        List<QuizQuestion> quizQuestions = new ArrayList<>();
        for (int i = 0; i < questionIds.size(); i++) {
            Question question = new Question();
            question.setQuestionId(questionIds.get(i));
            QuizQuestion quizQuestion = QuizQuestion.builder()
                    .quiz(savedQuiz)
                    .question(question)
                    .orderNo(i + 1)
                    .scoreWeight(BigDecimal.ONE)
                    .build();
            quizQuestions.add(quizQuestion);
        }
        quizQuestionRepository.saveAll(quizQuestions);
        return savedQuiz;
    }
}
