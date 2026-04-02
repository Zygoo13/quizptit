package com.quizptit.community.controller;

import com.quizptit.community.service.impl.ModerationRecordServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/community/admin")
@RequiredArgsConstructor
public class ModerationRecordController {

    private final ModerationRecordServiceImpl moderationService;

    // API Ẩn bài viết vi phạm
    @PatchMapping("/hide-post/{postId}")
    public ResponseEntity<String> hidePost(
            @PathVariable Long postId,
            @RequestParam Long adminId,
            @RequestParam String reason) {
        moderationService.hidePost(postId, adminId, reason);
        return ResponseEntity.ok("Đã ẩn bài viết thành công!");
    }
}