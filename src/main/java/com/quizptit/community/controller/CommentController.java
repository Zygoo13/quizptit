package com.quizptit.community.controller;

import com.quizptit.community.dto.CommentRequest;
import com.quizptit.community.dto.CommentResponse;
import com.quizptit.community.dto.ModerationRecordRequest;
import com.quizptit.community.service.CommentService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api/community/comments")
@RequiredArgsConstructor
public class CommentController {

    private final CommentService commentService;

    // BR-36: Thêm bình luận vào bài viết
    @PostMapping("/post/{postId}")
    public ResponseEntity<CommentResponse> addComment(
            @PathVariable Long postId,
            @RequestParam Long userId,
            @Valid @RequestBody CommentRequest request) {
        return ResponseEntity.ok(commentService.addComment(postId, userId, request));
    }

    // BR-40: Lấy danh sách bình luận của bài viết
    @GetMapping("/post/{postId}")
    public ResponseEntity<List<CommentResponse>> getCommentsByPost(@PathVariable Long postId) {
        return ResponseEntity.ok(commentService.getPublicCommentsByPost(postId));
    }

    // BR-37: Xóa bình luận
    @DeleteMapping("/{commentId}")
    public ResponseEntity<String> deleteComment(
            @PathVariable Long commentId,
            @RequestParam Long userId,
            @RequestParam String role) {
        commentService.deleteComment(commentId, userId, role);
        return ResponseEntity.ok("Xóa bình luận thành công!");
    }

    // BR-37: Cập nhật bình luận (Chỉ chính chủ)
    @PutMapping("/{commentId}")
    public ResponseEntity<CommentResponse> updateComment(
            @PathVariable Long commentId,
            @Valid @RequestBody CommentRequest request,
            @RequestParam Long userId) {
        return ResponseEntity.ok(commentService.updateComment(commentId, request, userId));
    }

    // Admin xử lý vi phạm bình luận (Ẩn/Hiện)
    @PatchMapping("/{commentId}/status")
    public ResponseEntity<String> updateCommentStatus(
            @PathVariable Long commentId,
            @RequestParam Long adminId, // ID của Admin thực hiện
            @Valid @RequestBody ModerationRecordRequest request) { // Body chứa Action và Reason

        // Gọi Service với dữ liệu từ DTO
        commentService.updateCommentStatus(
                commentId,
                request.getAction(),
                request.getReason(),
                adminId
        );
        return ResponseEntity.ok("Cập nhật trạng thái bình luận thành công!");
    }
}