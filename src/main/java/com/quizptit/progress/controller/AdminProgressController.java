package com.quizptit.progress.controller;

import com.quizptit.content.entity.Subject;
import com.quizptit.content.service.SubjectService;
import com.quizptit.progress.dto.AdminProgressDTO;
import com.quizptit.progress.service.ProgressService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/admin/progress")
@RequiredArgsConstructor
public class AdminProgressController {
    private final ProgressService progressService;
    private final SubjectService subjectService;

    @GetMapping
    public String viewAdminProgress(
            @RequestParam(required = false) Long subjectId,
            @RequestParam(required = false) String keyword,
            @RequestParam(defaultValue = "0") int page,
            Model model) {
        
        Pageable pageable = PageRequest.of(page, 10, Sort.by("u.email").ascending());
        Page<AdminProgressDTO> progressPage = progressService.getAdminProgressData(subjectId, keyword, pageable);

        model.addAttribute("progressPage", progressPage);
        model.addAttribute("subjects", subjectService.getActiveSubjects());
        model.addAttribute("selectedSubject", subjectId);
        model.addAttribute("keyword", keyword);

        return "progress/admin/admin-progress";
    }
}