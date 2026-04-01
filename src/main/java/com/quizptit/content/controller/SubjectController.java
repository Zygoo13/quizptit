package com.quizptit.content.controller;

import com.quizptit.content.entity.Subject;
import com.quizptit.content.service.SubjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/subjects")
public class SubjectController {

    @Autowired
    private SubjectService subjectService;

    @GetMapping
    public String listSubjects(@RequestParam(required = false) String keyword,
                               @RequestParam(defaultValue = "0") int page,
                               Model model) {
        Page<Subject> subjects = subjectService.searchSubjects(keyword, true, PageRequest.of(page, 10));
        model.addAttribute("subjects", subjects);
        model.addAttribute("keyword", keyword);
        return "content/subject-list";
    }

    @GetMapping("/{subjectId}")
    public String subjectDetail(@PathVariable Long subjectId, Model model) {
        Subject subject = subjectService.getSubjectById(subjectId);
        if (!subject.getIsActive()) {
            return "redirect:/subjects";
        }
        model.addAttribute("subject", subject);
        return "content/subject-detail";
    }
}
