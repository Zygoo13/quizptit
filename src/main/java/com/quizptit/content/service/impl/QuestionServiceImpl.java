package com.quizptit.content.service.impl;

import com.quizptit.content.entity.AnswerOption;
import com.quizptit.content.entity.Question;
import com.quizptit.common.constant.QuestionStatus;
import com.quizptit.common.constant.DifficultyLevel;
import com.quizptit.content.repository.QuestionRepository;
import com.quizptit.content.repository.TopicRepository;
import com.quizptit.content.service.QuestionService;
import com.quizptit.user.entity.User;
import com.quizptit.user.repository.UserRepository;

import java.util.List;

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
    public Page<Question> searchQuestions(Long subjectId, Long topicId, QuestionStatus status, DifficultyLevel difficulty,
            String keyword, Pageable pageable) {
        return questionRepository.searchQuestions(subjectId, topicId, status, difficulty, keyword, pageable);
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
        
        if (question.getOptions() != null) {
            for (AnswerOption option : question.getOptions()) {
                option.setQuestion(question);
            }
        }
        
        return questionRepository.save(question);
    }

    @Override
    public Question updateQuestion(Long questionId, Question questionDetails) {
        Question question = getQuestionById(questionId);
        question.setContent(questionDetails.getContent());
        question.setDifficultyLevel(questionDetails.getDifficultyLevel());
        question.setExplanation(questionDetails.getExplanation());
        question.setStatus(questionDetails.getStatus());

        if (questionDetails.getTopic() != null
                && !question.getTopic().getTopicId().equals(questionDetails.getTopic().getTopicId())) {
            question.setTopic(topicRepository.findById(questionDetails.getTopic().getTopicId()).orElseThrow());
        }

        if (questionDetails.getOptions() != null && question.getOptions() != null) {
            for (int i = 0; i < Math.min(question.getOptions().size(), questionDetails.getOptions().size()); i++) {
                AnswerOption existing = question.getOptions().get(i);
                AnswerOption incoming = questionDetails.getOptions().get(i);
                existing.setContent(incoming.getContent());
                existing.setIsCorrect(incoming.getIsCorrect());
                // optionLabel A,B,C,D typically unchanged but update just in case
                existing.setOptionLabel(incoming.getOptionLabel());
            }
            // If there are new options added during edit (e.g. from 0 to 4 options)
            if (questionDetails.getOptions().size() > question.getOptions().size()) {
                for (int i = question.getOptions().size(); i < questionDetails.getOptions().size(); i++) {
                    AnswerOption incoming = questionDetails.getOptions().get(i);
                    incoming.setQuestion(question);
                    question.getOptions().add(incoming);
                }
            }
        }

        return questionRepository.save(question);
    }

    @Override
    public void changeStatus(Long questionId, QuestionStatus newStatus) {
        Question question = getQuestionById(questionId);
        question.setStatus(newStatus);
        questionRepository.save(question);
    }

    @Override
    public List<Question> getAllQuestions() {
        return questionRepository.findAll();
    }

}
