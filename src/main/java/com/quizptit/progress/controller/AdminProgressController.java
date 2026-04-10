package com.quizptit.progress.controller;

import com.quizptit.content.entity.Subject;
import com.quizptit.content.service.SubjectService;
import com.quizptit.progress.dto.AdminProgressDTO;
import com.quizptit.progress.dto.TopicProgressDTO;
import com.quizptit.progress.service.ProgressService;
import com.quizptit.attempt.service.AttemptService;
import com.quizptit.attempt.entity.Attempt;        
import com.quizptit.user.service.UserService;      
import com.quizptit.user.entity.User;          

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/admin/progress")
@RequiredArgsConstructor
public class AdminProgressController {
    private final ProgressService progressService;
    private final SubjectService subjectService;
    private final AttemptService attemptService;
    private final UserService userService;

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
    
    @GetMapping("/user/{userId}")
    public String viewUserDetailProgress(
            @PathVariable Long userId,
            @RequestParam Long subjectId, 
            Model model) {
        
        // 1. Lấy thông tin cơ bản
        User user = userService.getUserById(userId);
        Subject subject = subjectService.getSubjectById(subjectId);
        
        // 2. Lấy tiến độ theo từng chương
        List<TopicProgressDTO> topicDetails = progressService.getTopicsBySubject(userId, subjectId);

        // 3. Bổ sung: Lấy tối đa 5 bài làm gần nhất của sinh viên trong môn học này
        List<Attempt> recentAttempts = attemptService.getUserAttemptHistory(userId).stream()
                .filter(a -> a.getQuiz().getSubject().getSubjectId().equals(subjectId))
                .limit(5)
                .toList();

        model.addAttribute("user", user);
        model.addAttribute("subject", subject);
        model.addAttribute("topicDetails", topicDetails);
        model.addAttribute("recentAttempts", recentAttempts); // Gửi sang HTML

        return "progress/admin/user-detail-progress";
    }
}