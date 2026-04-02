package com.quizptit.quiz.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.quizptit.content.entity.Question;
import com.quizptit.content.entity.Subject;
import com.quizptit.content.repository.QuestionRepository;
import com.quizptit.content.repository.SubjectRepository;
import com.quizptit.quiz.entity.Quiz;
import com.quizptit.quiz.entity.QuizQuestion;
import com.quizptit.quiz.entity.enums.QuizType;
import com.quizptit.quiz.repository.QuizQuestionRepository;
import com.quizptit.quiz.repository.QuizRepository;
import com.quizptit.user.entity.User;
import com.quizptit.user.repository.UserRepository;

import org.springframework.transaction.annotation.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class QuizService {
    private final QuizRepository quizRepository;
    private final UserRepository userRepository;
    private final QuizQuestionRepository quizQuestionRepository;
    private final SubjectRepository subjectRepository;
    private final QuestionRepository questionRepository;

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

    @Transactional
    public Quiz createRandomQuiz(Long subjectId, Long creatorId, String title, int durationMinutes,
            int requiredQuestions) {

        Subject subject = subjectRepository.findById(subjectId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy môn học"));
        User creator = userRepository.findById(creatorId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng"));

        // 1. Kéo ngẫu nhiên danh sách câu hỏi từ DB
        List<Question> randomQuestions = questionRepository.findRandomQuestionsBySubjectId(subjectId,
                requiredQuestions);

        // 2. Validate cực kỳ quan trọng: Kiểm tra kho có đủ số lượng không
        if (randomQuestions.size() < requiredQuestions) {
            throw new RuntimeException("Ngân hàng câu hỏi không đủ! Yêu cầu: "
                    + requiredQuestions + ", Hiện có: " + randomQuestions.size());
        }

        // 3. Khởi tạo và lưu Quiz (Lưu ý: quizType lúc này là RANDOM)
        Quiz quiz = Quiz.builder()
                .subject(subject)
                .title(title)
                .quizType(QuizType.RANDOM) // Enum đánh dấu đây là đề random
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

    // 1. Sinh viên xem danh sách bài luyện
    @Transactional(readOnly = true) // readOnly = true giúp tối ưu performance cho truy vấn đọc
    public List<Quiz> getAvailableQuizzes(Long subjectId) {
        if (subjectId != null) {
            return quizRepository.findBySubject_SubjectIdAndIsPublishedTrueOrderByCreatedAtDesc(subjectId);
        }
        return quizRepository.findByIsPublishedTrueOrderByCreatedAtDesc();
    }

    // 2. Sinh viên xem chi tiết một bài luyện (trước khi bấm Bắt đầu)
    @Transactional(readOnly = true)
    public Quiz getQuizDetail(Long quizId) {
        Quiz quiz = quizRepository.findById(quizId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy bài Quiz"));

        if (!quiz.getIsPublished()) {
            throw new RuntimeException("Bài Quiz này chưa được mở");
        }

        return quiz;
    }
}
