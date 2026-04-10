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
import java.util.List;

@Controller
@RequestMapping("/community")
@RequiredArgsConstructor
public class CommentController {

    private final CommentService commentService;
    private final UserRepository userRepository;

    // BR-33, BR-36: Thêm bình luận/phản hồi vào bài viết
    // Route: /community/questions/{questionPostId}/comments/create
    @PostMapping("/questions/{postId}/comments/create")

    public String addComment(
            @PathVariable Long postId,
            Principal principal,
            @Valid @ModelAttribute CommentRequest request) {
        // Truyền email thay vì User Entity
        commentService.addCommentByEmail(postId, principal.getName(), request);
        return "redirect:/community/questions/" + postId;
    }

    // BR-37: Mở trang chỉnh sửa
    @GetMapping("/comments/{commentId}/edit")
    public String showEditCommentPage(@PathVariable Long commentId, Model model) {
        return "community/comment-edit";
    }

    // BR-37: Xử lý cập nhật
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

    // BR-37: Xóa bình luận
    @PostMapping("/admin/comments/{commentId}/hide")
    public String hideCommentAdmin(
            @PathVariable Long commentId,
            java.security.Principal principal, // Dùng Principal mặc định
            @RequestParam String reason) {

        // 1. Tìm Admin từ email của Principal
        User admin = userRepository.findByEmail(principal.getName())
                .orElseThrow(() -> new RuntimeException("Admin không tồn tại"));

        // 2. Tìm comment để lấy postId
        Comment comment = commentService.findById(commentId)
                .orElseThrow(() -> new ResourceNotFoundException("Bình luận không tồn tại"));

        // 3. Thực hiện update dùng ID của admin vừa tìm được
        commentService.updateCommentStatus(commentId, "HIDDEN", reason, admin.getUserId());

        return "redirect:/community/questions/" + comment.getQuestionPost().getQuestionPostId();
    }

    // --- GIỮ NGUYÊN CÁC HÀM KHÁC, CHỈ THÊM/SỬA PHẦN NÀY ---

    // Hàm cũ dành cho User (Bạn giữ nguyên)
    @PostMapping("/comments/{commentId}/delete")
    public String deleteComment(@PathVariable Long commentId, Principal principal) {
        Comment comment = commentService.findById(commentId)
                .orElseThrow(() -> new ResourceNotFoundException("Bình luận không tồn tại"));
        commentService.deleteCommentByEmail(commentId, principal.getName());
        return "redirect:/community/questions/" + comment.getQuestionPost().getQuestionPostId();
    }

    // THÊM HÀM NÀY: Dành riêng cho Admin bấm nút "Xóa" (Lỗi 500 là do thiếu cái này)
    @PostMapping("/admin/comments/{commentId}/delete")
    public String deleteCommentAdmin(
            @PathVariable Long commentId,
            Principal principal,
            @RequestParam String reason) { // Nhận reason từ Modal Admin

        User admin = userRepository.findByEmail(principal.getName())
                .orElseThrow(() -> new RuntimeException("Admin không tồn tại"));

        // Gọi thẳng hàm updateStatus với action là DELETED
        commentService.updateCommentStatus(commentId, "DELETED", reason, admin.getUserId());

        Comment comment = commentService.findById(commentId).get();
        return "redirect:/community/questions/" + comment.getQuestionPost().getQuestionPostId();
    }

    // Admin khôi phục bình luận
    @PostMapping("/admin/community/comments/{commentId}/restore")
    @ResponseBody
    public String restoreCommentAdmin(
            @PathVariable Long commentId,
            @AuthenticationPrincipal User admin) {

        commentService.updateCommentStatus(commentId, "VISIBLE", "Khôi phục bởi Admin", admin.getUserId());
        return "Đã khôi phục bình luận thành công";
    }
}