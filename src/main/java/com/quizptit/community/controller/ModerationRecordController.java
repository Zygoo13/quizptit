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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.security.Principal;

@Controller
@RequestMapping("/admin/community")
@RequiredArgsConstructor
public class ModerationRecordController {

    private final QuestionPostService questionService;
    private final CommentService commentService;
    private final ModerationRecordService moderationService;
    private final UserRepository userRepository;

    @GetMapping("/questions")
    public String listQuestions(Model model) {
        model.addAttribute("questions", questionService.getAllPostsForAdmin());
        return "community/admin/question-list";
    }

    @GetMapping("/comments")
    public String listComments(Model model) {
        model.addAttribute("comments", commentService.getAllCommentsForAdmin());
        return "community/admin/comment-list";
    }

    @GetMapping("/moderation-records")
    public String listModerationLogs(@RequestParam(defaultValue = "QUESTION_POST") String type, Model model) {
        model.addAttribute("records", moderationService.getRecordsByType(type));
        model.addAttribute("currentType", type);
        return "community/admin/moderation-record-list";
    }

    @PostMapping("/questions/{id}/{action}")
    public String handleQuestionAction(@PathVariable Long id,
                                       @PathVariable String action,
                                       @RequestParam(required = false, defaultValue = "Admin xử lý nội dung") String reason,
                                       Principal principal,
                                       RedirectAttributes redirectAttributes) {

        String status = action.equalsIgnoreCase("restore") ? "VISIBLE"
                : action.equalsIgnoreCase("hide") ? "HIDDEN"
                : "DELETED";

        questionService.updatePostStatus(id, status, reason, principal.getName());
        redirectAttributes.addFlashAttribute("message", "Thao tác bài viết thành công!");

        if ("restore".equalsIgnoreCase(action)) {
            return "redirect:/admin/community/moderation-records?type=QUESTION_POST";
        }
        return "redirect:/admin/community/questions";
    }

    @PostMapping("/comments/{id}/{action}")
    public String handleCommentAction(@PathVariable Long id,
                                      @PathVariable String action,
                                      @RequestParam(required = false, defaultValue = "Admin xử lý nội dung") String reason,
                                      Principal principal,
                                      RedirectAttributes redirectAttributes) {

        String status = action.equalsIgnoreCase("restore") ? "VISIBLE"
                : action.equalsIgnoreCase("hide") ? "HIDDEN"
                : "DELETED";

        User admin = userRepository.findByEmail(principal.getName())
                .orElseThrow(() -> new RuntimeException("Admin không tồn tại"));

        commentService.updateCommentStatus(id, status, reason, admin.getUserId());
        redirectAttributes.addFlashAttribute("message", "Thao tác bình luận thành công!");

        if ("restore".equalsIgnoreCase(action)) {
            return "redirect:/admin/community/moderation-records?type=COMMENT";
        }
        return "redirect:/admin/community/comments";
    }
}