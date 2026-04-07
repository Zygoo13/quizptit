package com.quizptit.quiz.controller;

import com.quizptit.content.repository.SubjectRepository;
import com.quizptit.content.repository.QuestionRepository;
import com.quizptit.quiz.repository.QuizRepository;
import org.springframework.data.domain.Sort;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/quizzes")
public class AdminQuizWebController {

    // Gọi trực tiếp xuống kho (Repository) thay vì qua Service
    @Autowired
    private SubjectRepository subjectRepository;

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private QuizRepository quizRepository;

    @GetMapping
    public String showQuizList(Model model) {
        model.addAttribute("quizzes", quizRepository.findAll(Sort.by(Sort.Direction.DESC, "createdAt")));
        return "quiz/admin/quiz-list";
    }

    @GetMapping("/create")
    public String showCreateQuizPage(Model model) {

        // Dùng hàm findAll() có sẵn của JpaRepository để lấy toàn bộ dữ liệu
        model.addAttribute("subjects", subjectRepository.findAll());
        model.addAttribute("questions", questionRepository.findAll());

        return "quiz/admin/quiz-create";
    }
}