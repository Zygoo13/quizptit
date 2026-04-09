package com.quizptit.quiz.controller;

import com.quizptit.content.service.SubjectService;
import com.quizptit.quiz.service.QuizService;

import org.springframework.stereotype.Controller;
import lombok.RequiredArgsConstructor;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/quizzes")
@RequiredArgsConstructor
public class AdminQuizWebController {

    private final SubjectService subjectService;
    private final QuizService quizService;

    @GetMapping
    public String showQuizList(Model model) {
        model.addAttribute("quizzes", quizService.getAllAdminQuizzes());
        return "quiz/admin/quiz-list";
    }

    @GetMapping("/create")
    public String showCreateQuizPage(Model model) {
        model.addAttribute("subjects", subjectService.getAllSubjects());
        return "quiz/admin/quiz-create";
    }

    @GetMapping("/{id}/edit")
    public String showEditQuizPage(@PathVariable Long id, Model model) {
        model.addAttribute("subjects", subjectService.getAllSubjects());
        model.addAttribute("quizId", id);
        return "quiz/admin/quiz-edit";
    }
}