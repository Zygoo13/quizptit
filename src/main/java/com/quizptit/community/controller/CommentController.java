package com.quizptit.community.controller;

import com.quizptit.common.exception.ResourceNotFoundException;
import com.quizptit.community.dto.CommentRequest;
import com.quizptit.community.dto.CommentResponse;
import com.quizptit.community.entity.Comment;
import com.quizptit.community.service.CommentService;
import com.quizptit.user.entity.User;
import com.quizptit.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.security.Principal;

@Controller
@RequestMapping("/community")
@RequiredArgsConstructor
public class CommentController {

    private final CommentService commentService;
    private final UserRepository userRepository;

    @PostMapping("/questions/{postId}/comments/create")
    public String addComment(@PathVariable Long postId,
                             Principal principal,
                             @Valid @ModelAttribute CommentRequest request) {
        CommentResponse newComment = commentService.addCommentByEmail(postId, principal.getName(), request);
        return "redirect:/community/questions/" + postId + "#comment-" + newComment.getCommentId();
    }

    @GetMapping("/comments/{commentId}/edit")
    public String showEditCommentPage(@PathVariable Long commentId, Model model) {
        return "community/comment-edit";
    }

    @PostMapping("/comments/update/{id}")
    public String updateComment(@PathVariable Long id,
                                @ModelAttribute CommentRequest request,
                                Principal principal) {
        commentService.updateComment(id, request, principal.getName());
        Long postId = commentService.findById(id)
                .map(c -> c.getQuestionPost().getQuestionPostId())
                .orElse(0L);
        return "redirect:/community/questions/" + postId + "#comment-" + id;
    }

    @PostMapping("/admin/comments/{commentId}/hide")
    public String hideCommentAdmin(@PathVariable Long commentId,
                                   Principal principal,
                                   @RequestParam String reason) {
        User admin = userRepository.findByEmail(principal.getName())
                .orElseThrow(() -> new RuntimeException("Admin không tồn tại"));

        Comment comment = commentService.findById(commentId)
                .orElseThrow(() -> new ResourceNotFoundException("Bình luận không tồn tại"));

        commentService.updateCommentStatus(commentId, "HIDDEN", reason, admin.getUserId());
        return "redirect:/community/questions/" + comment.getQuestionPost().getQuestionPostId();
    }

    @PostMapping("/comments/{commentId}/delete")
    public String deleteComment(@PathVariable Long commentId, Principal principal) {
        Comment comment = commentService.findById(commentId)
                .orElseThrow(() -> new ResourceNotFoundException("Bình luận không tồn tại"));
        commentService.deleteCommentByEmail(commentId, principal.getName());
        return "redirect:/community/questions/" + comment.getQuestionPost().getQuestionPostId();
    }

    @PostMapping("/admin/comments/{commentId}/delete")
    public String deleteCommentAdmin(@PathVariable Long commentId,
                                     Principal principal,
                                     @RequestParam String reason) {
        User admin = userRepository.findByEmail(principal.getName())
                .orElseThrow(() -> new RuntimeException("Admin không tồn tại"));

        commentService.updateCommentStatus(commentId, "HIDDEN", reason, admin.getUserId());

        Comment comment = commentService.findById(commentId)
                .orElseThrow(() -> new ResourceNotFoundException("Bình luận không tồn tại"));
        return "redirect:/community/questions/" + comment.getQuestionPost().getQuestionPostId();
    }

    @PostMapping("/admin/community/comments/{commentId}/restore")
    @ResponseBody
    public String restoreCommentAdmin(@PathVariable Long commentId,
                                      @AuthenticationPrincipal User admin) {
        commentService.updateCommentStatus(commentId, "VISIBLE", "Khôi phục bởi Admin", admin.getUserId());
        return "Đã khôi phục bình luận thành công";
    }
}