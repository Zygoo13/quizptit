package com.quizptit.content.service.impl;

import com.quizptit.content.entity.Question;
import com.quizptit.common.constant.QuestionStatus;
import com.quizptit.common.constant.DifficultyLevel;
import com.quizptit.content.repository.QuestionRepository;
import com.quizptit.content.repository.TopicRepository;
import com.quizptit.content.service.QuestionService;
import com.quizptit.user.entity.User;
import com.quizptit.user.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class QuestionServiceImpl implements QuestionService {

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private TopicRepository topicRepository;

    @Override
    public Page<Question> searchQuestions(Long topicId, QuestionStatus status, DifficultyLevel difficulty, String keyword, Pageable pageable) {
        return questionRepository.searchQuestions(topicId, status, difficulty, keyword, pageable);
    }

    @Override
    public Question getQuestionById(Long questionId) {
        return questionRepository.findById(questionId)
                .orElseThrow(() -> new RuntimeException("Question not found"));
    }

    @Override
    public Question createQuestion(Question question, Long userId) {
        User creator = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        question.setCreatedBy(creator);
        return questionRepository.save(question);
    }

    @Override
    public Question updateQuestion(Long questionId, Question questionDetails) {
        Question question = getQuestionById(questionId);
        question.setContent(questionDetails.getContent());
        question.setDifficultyLevel(questionDetails.getDifficultyLevel());
        question.setExplanation(questionDetails.getExplanation());
        question.setStatus(questionDetails.getStatus());
        
        if (questionDetails.getTopic() != null && !question.getTopic().getTopicId().equals(questionDetails.getTopic().getTopicId())) {
            question.setTopic(topicRepository.findById(questionDetails.getTopic().getTopicId()).orElseThrow());
        }
        
        return questionRepository.save(question);
    }

    @Override
    public void changeStatus(Long questionId, QuestionStatus newStatus) {
        Question question = getQuestionById(questionId);
        question.setStatus(newStatus);
        questionRepository.save(question);
    }
}
