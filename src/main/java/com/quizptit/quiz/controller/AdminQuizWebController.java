package com.quizptit.quiz.controller;

import com.quizptit.content.service.SubjectService;
import org.springframework.stereotype.Controller;
import lombok.RequiredArgsConstructor;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/quizzes")
@RequiredArgsConstructor
public class AdminQuizWebController {

    private final SubjectService subjectService;

    private final com.quizptit.quiz.service.QuizService quizService;

    @GetMapping
    public String showQuizList(Model model) {
        model.addAttribute("quizzes", quizService.getAllAdminQuizzes());
        return "quiz/admin/quiz-list";
    }

    @GetMapping("/create")
    public String showCreateQuizPage(Model model) {

        // Chỉ nạp danh sách Môn học. Chủ đề và Câu hỏi sẽ được gọi ẩn qua AJAX (fetch) Javascript
        model.addAttribute("subjects", subjectService.getAllSubjects());

        return "quiz/admin/quiz-create";
    }
}