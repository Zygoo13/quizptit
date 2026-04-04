package com.quizptit.community.controller;

import com.quizptit.community.dto.QuestionPostRequest;
import com.quizptit.community.dto.QuestionPostResponse;
import com.quizptit.community.service.QuestionPostService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api/community/posts")
@RequiredArgsConstructor
public class QuestionPostController {

    private final QuestionPostService postService;

    // BR-33, 34, 35: Sinh viên đăng bài mới
    @PostMapping
    public ResponseEntity<QuestionPostResponse> createPost(
            @Valid @RequestBody QuestionPostRequest request,
            @RequestParam Long userId,
            @RequestParam Long topicId) {
        return ResponseEntity.ok(postService.createPost(request, userId, topicId));
    }

    // BR-40: Lấy danh sách bài viết hiển thị (VISIBLE)
    @GetMapping
    public ResponseEntity<List<QuestionPostResponse>> getPublicPosts() {
        return ResponseEntity.ok(postService.getPublicPosts());
    }

    // Lấy chi tiết 1 bài viết
    @GetMapping("/{postId}")
    public ResponseEntity<QuestionPostResponse> getPostById(
            @PathVariable Long postId,
            @RequestParam(required = false) Long userId,    // Có thể null nếu là khách
            @RequestParam(required = false) String role) {  // Có thể null nếu là khách
        return ResponseEntity.ok(postService.getPostById(postId, userId, role));
    }

    // BR-37: Cập nhật bài viết (Chỉ chính chủ)
    @PutMapping("/{postId}")
    public ResponseEntity<QuestionPostResponse> updatePost(
            @PathVariable Long postId,
            @Valid @RequestBody QuestionPostRequest request,
            @RequestParam Long userId) {
        return ResponseEntity.ok(postService.updatePost(postId, request, userId));
    }

    // BR-37, 38: Xóa bài viết
    @DeleteMapping("/{postId}")
    public ResponseEntity<String> deletePost(
            @PathVariable Long postId,
            @RequestParam Long userId,
            @RequestParam String role) {
        postService.deletePost(postId, userId, role);
        return ResponseEntity.ok("Xóa bài viết thành công!");
    }

    // BR-41: Lấy tất cả bài viết dành cho Admin (Bao gồm cả bài bị ẩn/xóa)
    @GetMapping("/admin/all")
    public ResponseEntity<List<QuestionPostResponse>> getAllPostsForAdmin() {
        // Sau này chỗ này sẽ check Role ADMIN ở đây
        return ResponseEntity.ok(postService.getAllPostsForAdmin());
    }
}