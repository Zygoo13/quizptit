package com.quizptit.quiz.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.quizptit.content.entity.Question;
import com.quizptit.content.entity.Subject;
import com.quizptit.content.entity.Topic;
import com.quizptit.content.repository.QuestionRepository;
import com.quizptit.content.repository.SubjectRepository;
import com.quizptit.content.repository.TopicRepository;
import com.quizptit.quiz.dto.request.ManualQuizRequest;
import com.quizptit.quiz.entity.Quiz;
import com.quizptit.quiz.entity.QuizQuestion;
import com.quizptit.quiz.entity.enums.QuizType;
import com.quizptit.quiz.repository.QuizQuestionRepository;
import com.quizptit.quiz.repository.QuizRepository;
import com.quizptit.quiz.service.QuizService;
import com.quizptit.user.entity.User;
import com.quizptit.user.repository.UserRepository;

import org.springframework.transaction.annotation.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class QuizServiceImpl implements QuizService {
        private final QuizRepository quizRepository;
        private final UserRepository userRepository;
        private final QuizQuestionRepository quizQuestionRepository;
        private final SubjectRepository subjectRepository;
        private final QuestionRepository questionRepository;
        private final TopicRepository topicRepository;

        @Override
        @Transactional
        public Quiz createManualQuiz(ManualQuizRequest request, Long creatorId) {
                Subject subject = subjectRepository.findById(request.getSubjectId())
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy Môn học"));

                Topic topic = null;
                if (request.getTopicId() != null) {
                        topic = topicRepository.findById(request.getTopicId())
                                        .orElseThrow(() -> new RuntimeException("Không tìm thấy Chủ đề"));
                }

                User creator = userRepository.findById(creatorId)
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy Người tạo"));

                Quiz quiz = Quiz.builder()
                                .title(request.getTitle())
                                .subject(subject)
                                .topic(topic)
                                .quizType(QuizType.MANUAL)
                                .durationMinutes(request.getDurationMinutes())
                                .totalQuestions(request.getQuestionIds().size())
                                .isPublished(true)
                                .createdBy(creator)
                                .build();

                Quiz savedQuiz = quizRepository.save(quiz);
                List<QuizQuestion> quizQuestions = new ArrayList<>();
                for (int i = 0; i < request.getQuestionIds().size(); i++) {
                        Question question = new Question();
                        question.setQuestionId(request.getQuestionIds().get(i));
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

        @Override
        @Transactional
        public Quiz createRandomQuiz(Long subjectId, Long creatorId, String title, int durationMinutes,
                        int requiredQuestions) {

                Subject subject = subjectRepository.findById(subjectId)
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy môn học"));
                User creator = userRepository.findById(creatorId)
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng"));

                List<Question> randomQuestions = questionRepository.findRandomQuestionsBySubjectId(subjectId,
                                requiredQuestions);

                if (randomQuestions.size() < requiredQuestions) {
                        throw new RuntimeException("Ngân hàng câu hỏi không đủ! Yêu cầu: "
                                        + requiredQuestions + ", Hiện có: " + randomQuestions.size());
                }

                Quiz quiz = Quiz.builder()
                                .subject(subject)
                                .title(title)
                                .quizType(QuizType.RANDOM)
                                .durationMinutes(durationMinutes)
                                .totalQuestions(requiredQuestions)
                                .createdBy(creator)
                                .isPublished(true)
                                .build();

                Quiz savedQuiz = quizRepository.save(quiz);

                List<QuizQuestion> quizQuestions = new ArrayList<>();
                for (int i = 0; i < randomQuestions.size(); i++) {
                        Question question = new Question();
                        question.setQuestionId(randomQuestions.get(i).getQuestionId());
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

        @Override
        @Transactional(readOnly = true)
        public List<Quiz> getAvailableQuizzes(Long subjectId) {
                if (subjectId != null) {
                        return quizRepository.findBySubject_SubjectIdAndIsPublishedTrueOrderByCreatedAtDesc(subjectId);
                }
                return quizRepository.findByIsPublishedTrueOrderByCreatedAtDesc();
        }

        @Override
        @Transactional(readOnly = true)
        public Quiz getQuizDetail(Long quizId) {
                Quiz quiz = quizRepository.findById(quizId)
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy bài Quiz"));

                if (!quiz.getIsPublished()) {
                        throw new RuntimeException("Bài Quiz này chưa được mở");
                }

                return quiz;
        }

        @Override
        @Transactional(readOnly = true)
        public java.util.List<Quiz> getAllAdminQuizzes() {
                return quizRepository.findByQuizTypeOrderByCreatedAtDesc(QuizType.MANUAL);
        }

        @Override
        @Transactional
        public Quiz createRandomQuizByTopic(Long topicId, Long creatorId, String title,
                        int durationMinutes, int requiredQuestions) {

                Topic topic = topicRepository.findById(topicId)
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy chủ đề"));
                User creator = userRepository.findById(creatorId)
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng"));

                List<Question> randomQuestions = questionRepository.findRandomQuestionsByTopicId(topicId,
                                requiredQuestions);

                if (randomQuestions.size() < requiredQuestions) {
                        throw new RuntimeException(
                                        "Ngân hàng câu hỏi không đủ! Yêu cầu: " + requiredQuestions
                                                        + ", Hiện có: " + randomQuestions.size()
                                                        + " (Chủ đề: " + topic.getTopicName() + ")");
                }

                Quiz quiz = Quiz.builder()
                                .subject(topic.getSubject())
                                .topic(topic)
                                .title(title)
                                .quizType(QuizType.RANDOM)
                                .durationMinutes(durationMinutes)
                                .totalQuestions(requiredQuestions)
                                .createdBy(creator)
                                .isPublished(true)
                                .build();

                Quiz savedQuiz = quizRepository.save(quiz);

                List<QuizQuestion> quizQuestions = new ArrayList<>();
                for (int i = 0; i < randomQuestions.size(); i++) {
                        Question question = new Question();
                        question.setQuestionId(randomQuestions.get(i).getQuestionId());
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
