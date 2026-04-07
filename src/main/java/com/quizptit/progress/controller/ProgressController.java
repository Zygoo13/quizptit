package com.quizptit.progress.controller;

import com.quizptit.common.util.CurrentUserUtils;
import com.quizptit.progress.dto.SubjectProgressDTO;
import com.quizptit.progress.dto.TopicProgressDTO;
import com.quizptit.progress.dto.QuizStatusDTO;
import com.quizptit.progress.service.ProgressService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/progress")
@RequiredArgsConstructor
public class ProgressController {

    private final ProgressService progressService;

    /**
     * CẤP 1: Danh sách các Môn học (Subjects)
     * Đây là trang Dashboard chính thay thế cho /my-progress cũ.
     */
    @GetMapping
    public String listSubjects(Model model) {
        Long userId = CurrentUserUtils.getCurrentUserId();
        
        if (userId == null) {
            return "redirect:/auth/login";
        }

        // Lấy danh sách Môn học kèm % tiến độ tổng quát
        List<SubjectProgressDTO> subjects = progressService.getAllSubjectProgress(userId);
        model.addAttribute("subjects", subjects);
        
        return "progress/subjects"; 
    }

    /**
     * CẤP 2: Danh sách các Chương (Topics) trong một Môn học
     * Truy cập qua: /progress/subject/{id}
     */
    @GetMapping("/subject/{subjectId}")
    public String listTopics(@PathVariable Long subjectId, Model model) {
        Long userId = CurrentUserUtils.getCurrentUserId();
        
        if (userId == null) {
            return "redirect:/auth/login";
        }

        // Lấy danh sách Chương kèm điểm trung bình BigDecimal
        List<TopicProgressDTO> topics = progressService.getTopicsBySubject(userId, subjectId);
        model.addAttribute("topics", topics);
        
        return "progress/topics";
    }

    /**
     * CẤP 3: Danh sách các bài Quiz trong một Chương
     * Truy cập qua: /progress/topic/{id}
     */
    @GetMapping("/topic/{topicId}")
    public String listQuizzes(@PathVariable Long topicId, Model model) {
        Long userId = CurrentUserUtils.getCurrentUserId();
        
        if (userId == null) {
            return "redirect:/auth/login";
        }

        // Lấy trạng thái từng bài Quiz (Đã đạt/Chưa đạt)
        List<QuizStatusDTO> quizzes = progressService.getQuizzesByTopic(userId, topicId);
        model.addAttribute("quizzes", quizzes);
        
        return "progress/quizzes";
    }
}