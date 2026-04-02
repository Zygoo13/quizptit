package com.quizptit.community.controller;

import com.quizptit.community.entity.Comment;
import com.quizptit.community.service.CommentService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/community/comments")
@RequiredArgsConstructor
public class CommentController {

    private final CommentService commentService;

    // BR-36: Lấy danh sách bình luận của một bài đăng cụ thể
    @GetMapping("/post/{postId}")
    public ResponseEntity<List<Comment>> getCommentsByPost(@PathVariable Long postId) {
        return ResponseEntity.ok(commentService.getCommentsByPost(postId));
    }

    // BR-33: Đăng bình luận mới (Cần userId của người đang login và postId của bài viết)
    @PostMapping("/{postId}/{userId}")
    public ResponseEntity<Comment> addComment(
            @PathVariable Long postId,
            @PathVariable Long userId,
            @RequestBody Comment comment) {
        return ResponseEntity.ok(commentService.addComment(postId, comment, userId));
    }

    // BR-37: Xóa bình luận (Chính chủ hoặc Admin)
    @DeleteMapping("/{commentId}")
    public ResponseEntity<String> deleteComment(
            @PathVariable Long commentId,
            @RequestParam Long userId,
            @RequestParam String userRole) {
        commentService.deleteComment(commentId, userId, userRole);
        return ResponseEntity.ok("Đã xóa bình luận thành công!");
    }
}