package com.quizptit.content.controller;

import com.quizptit.content.entity.Subject;
import com.quizptit.content.entity.Topic;
import com.quizptit.content.service.SubjectService;
import com.quizptit.content.service.TopicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/topics")
public class AdminTopicController {

    @Autowired
    private TopicService topicService;

    @Autowired
    private SubjectService subjectService;

    @GetMapping
    public String listTopics(@RequestParam(required = false) Long subjectId,
                             @RequestParam(required = false) String keyword,
                             @RequestParam(required = false) Boolean isActive,
                             @RequestParam(defaultValue = "0") int page,
                             Model model) {
        Page<Topic> topics = topicService.searchTopics(subjectId, keyword, isActive, PageRequest.of(page, 50));
        model.addAttribute("topics", topics);
        model.addAttribute("subjects", subjectService.getActiveSubjects());
        model.addAttribute("keyword", keyword);
        model.addAttribute("subjectId", subjectId);
        model.addAttribute("isActive", isActive);
        return "content/admin/topic-list";
    }

    @GetMapping("/create")
    public String showCreateForm(@RequestParam(required = false) Long subjectId, Model model) {
        Topic topic = new Topic();
        if (subjectId != null) {
            Subject subject = new Subject();
            subject.setSubjectId(subjectId);
            topic.setSubject(subject);
        }
        model.addAttribute("topic", topic);
        model.addAttribute("subjects", subjectService.getActiveSubjects());
        return "content/admin/topic-create";
    }

    @PostMapping("/create")
    public String createTopic(@ModelAttribute Topic topic, RedirectAttributes redirectAttributes) {
        try {
            topicService.createTopic(topic);
            redirectAttributes.addFlashAttribute("successMessage", "Tạo topic thành công");
            return "redirect:/admin/topics";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/admin/topics/create";
        }
    }

    @GetMapping("/{topicId}/edit")
    public String showEditForm(@PathVariable Long topicId, Model model) {
        Topic topic = topicService.getTopicById(topicId);
        model.addAttribute("topic", topic);
        model.addAttribute("subjects", subjectService.getActiveSubjects());
        return "content/admin/topic-edit";
    }

    @PostMapping("/{topicId}/edit")
    public String updateTopic(@PathVariable Long topicId, @ModelAttribute Topic topic, RedirectAttributes redirectAttributes) {
        try {
            topicService.updateTopic(topicId, topic);
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật topic thành công");
            return "redirect:/admin/topics";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/admin/topics/" + topicId + "/edit";
        }
    }

    @PostMapping("/{topicId}/toggle-status")
    public String toggleStatus(@PathVariable Long topicId, RedirectAttributes redirectAttributes) {
        try {
            topicService.toggleStatus(topicId);
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật trạng thái thành công");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/admin/topics";
    }
}
