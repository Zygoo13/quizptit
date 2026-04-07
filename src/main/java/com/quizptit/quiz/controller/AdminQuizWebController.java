package com.quizptit.quiz.controller;

import com.quizptit.content.repository.SubjectRepository;
import com.quizptit.content.service.QuestionService;
import com.quizptit.content.service.SubjectService;
import com.quizptit.content.service.TopicService;
import com.quizptit.content.repository.QuestionRepository;
import com.quizptit.quiz.repository.QuizRepository;

import lombok.RequiredArgsConstructor;

import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/quizzes")
@RequiredArgsConstructor
public class AdminQuizWebController {

    private final SubjectService subjectService;

    private final QuestionService questionService;

    private final QuizRepository quizRepository;

    private final TopicService topicService;

    @GetMapping
    public String showQuizList(Model model) {
        model.addAttribute("quizzes", quizRepository.findAll(Sort.by(Sort.Direction.DESC, "createdAt")));
        return "quiz/admin/quiz-list";
    }

    @GetMapping("/create")
    public String showCreateQuizPage(Model model) {

        // Dùng hàm findAll() có sẵn của JpaRepository để lấy toàn bộ dữ liệu
        model.addAttribute("subjects", subjectService.getAllSubjects());
        model.addAttribute("topics", topicService.getAllTopics());
        model.addAttribute("questions", questionService.getAllQuestions());

        return "quiz/admin/quiz-create";
    }
}