package com.quizptit.community.controller;

import com.quizptit.community.entity.QuestionPost;
import com.quizptit.community.service.QuestionPostService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/community/posts")
@RequiredArgsConstructor
public class QuestionPostController {

    private final QuestionPostService questionPostService;

    // Lấy tất cả bài viết hiển thị (VISIBLE) để hiện lên trang Cộng đồng
    @GetMapping
    public ResponseEntity<List<QuestionPost>> getAllPublicPosts() {
        return ResponseEntity.ok(questionPostService.getPublicPosts());
    }

    // API Đăng bài mới: Truyền userId và topicId qua URL để test cho nhanh
    @PostMapping("/create/{userId}/{topicId}")
    public ResponseEntity<QuestionPost> createPost(
            @RequestBody QuestionPost post,
            @PathVariable Long userId,
            @PathVariable Long topicId) {
        return ResponseEntity.ok(questionPostService.createPost(post, userId, topicId));
    }
}