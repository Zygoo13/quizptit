package com.quizptit.content.controller;

import com.quizptit.content.entity.Subject;
import com.quizptit.content.service.SubjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/subjects")
public class AdminSubjectController {

    @Autowired
    private SubjectService subjectService;

    @GetMapping
    public String listSubjects(@RequestParam(required = false) String keyword,
                               @RequestParam(required = false) Boolean isActive,
                               @RequestParam(defaultValue = "0") int page,
                               Model model) {
        Page<Subject> subjects = subjectService.searchSubjects(keyword, isActive, PageRequest.of(page, 10));
        model.addAttribute("subjects", subjects);
        model.addAttribute("keyword", keyword);
        model.addAttribute("isActive", isActive);
        return "content/admin/subject-list";
    }

    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("subject", new Subject());
        return "content/admin/subject-create";
    }

    @PostMapping("/create")
    public String createSubject(@ModelAttribute Subject subject, RedirectAttributes redirectAttributes) {
        try {
            subjectService.createSubject(subject);
            redirectAttributes.addFlashAttribute("successMessage", "Tạo môn học thành công");
            return "redirect:/admin/subjects";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/admin/subjects/create";
        }
    }

    @GetMapping("/{subjectId}/edit")
    public String showEditForm(@PathVariable Long subjectId, Model model) {
        Subject subject = subjectService.getSubjectById(subjectId);
        model.addAttribute("subject", subject);
        return "content/admin/subject-edit";
    }

    @PostMapping("/{subjectId}/edit")
    public String updateSubject(@PathVariable Long subjectId, @ModelAttribute Subject subject, RedirectAttributes redirectAttributes) {
        try {
            subjectService.updateSubject(subjectId, subject);
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật môn học thành công");
            return "redirect:/admin/subjects";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/admin/subjects/" + subjectId + "/edit";
        }
    }

    @PostMapping("/{subjectId}/toggle-status")
    public String toggleStatus(@PathVariable Long subjectId, RedirectAttributes redirectAttributes) {
        subjectService.toggleStatus(subjectId);
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật trạng thái thành công");
        return "redirect:/admin/subjects";
    }
}
