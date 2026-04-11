package com.quizptit.community.controller;

import com.quizptit.user.entity.User;
import com.quizptit.user.repository.UserRepository;
import org.springframework.ui.Model;
import com.quizptit.community.service.CommentService;
import com.quizptit.community.service.ModerationRecordService;
import com.quizptit.community.service.QuestionPostService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;

@Controller
@RequestMapping("/admin/community")
@RequiredArgsConstructor
public class AdminCommunityController {

    private final QuestionPostService questionService;
    private final CommentService commentService;
    private final ModerationRecordService moderationService;
    private final UserRepository userRepository;

    // 1. /admin/community/questions
    @GetMapping("/questions")
    public String listQuestions(Model model) {
        model.addAttribute("questions", questionService.getAllPostsForAdmin());
        return "community/admin/question-list";
    }

    // 2. /admin/community/comments
    @GetMapping("/comments")
    public String listComments(Model model) {
        model.addAttribute("comments", commentService.getAllCommentsForAdmin());
        return "community/admin/comment-list";
    }

    // 3. /admin/community/moderation-records
    @GetMapping("/moderation-records")
    public String listModerationLogs(@RequestParam(defaultValue = "QUESTION_POST") String type, Model model) {
        model.addAttribute("records", moderationService.getRecordsByType(type));
        model.addAttribute("currentType", type);
        return "community/admin/moderation-record-list";
    }

    // 4. Các Route xử lý hành động (Hide/Restore/Delete)
    // Ví dụ cho Question: /admin/community/questions/{id}/hide
    @PostMapping("/questions/{id}/{action}")
    public String handleQuestionAction(@PathVariable Long id,
                                       @PathVariable String action,
                                       @RequestParam(required = false, defaultValue = "Admin action") String reason,
                                       Principal principal) {
        String status = action.equalsIgnoreCase("hide") ? "HIDDEN" :
                action.equalsIgnoreCase("restore") ? "VISIBLE" : "DELETED";

        questionService.updatePostStatus(id, status, reason, principal.getName());
        return "redirect:/admin/community/moderation-records?type=QUESTION_POST";
    }

    // Tương tự cho Comment: /admin/community/comments/{id}/{action}
    @PostMapping("/comments/{id}/{action}")
    public String handleCommentAction(@PathVariable Long id,
                                      @PathVariable String action,
                                      @RequestParam(required = false, defaultValue = "Admin action") String reason,
                                      Principal principal) {
        String status = action.equalsIgnoreCase("hide") ? "HIDDEN" :
                action.equalsIgnoreCase("restore") ? "VISIBLE" : "DELETED";

        // Tìm Admin để lấy ID (Long) truyền vào Service
        User admin = userRepository.findByEmail(principal.getName())
                .orElseThrow(() -> new RuntimeException("Admin không tồn tại"));

        commentService.updateCommentStatus(id, status, reason, admin.getUserId());

        return "redirect:/admin/community/moderation-records?type=COMMENT";
    }
}
