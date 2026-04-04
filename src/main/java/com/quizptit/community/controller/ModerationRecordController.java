package com.quizptit.community.controller;

import com.quizptit.community.dto.ModerationRecordRequest;
import com.quizptit.community.dto.ModerationRecordResponse;
import com.quizptit.community.service.ModerationRecordService;
import com.quizptit.community.service.QuestionPostService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/community/admin/moderation")
@RequiredArgsConstructor
public class ModerationRecordController {

    private final ModerationRecordService moderationService;
    private final QuestionPostService postService;

    // BR-38, 39: Admin thay đổi trạng thái bài viết & Ghi log
    @PatchMapping("/post/{postId}")
    public ResponseEntity<String> moderatePost(
            @PathVariable Long postId,
            @RequestParam String status,
            @RequestParam Long adminId,
            @Valid @RequestBody ModerationRecordRequest request) { // <--- PHẢI CÓ @RequestBody VÀ @Valid

        // 1. Cập nhật status bài viết
        postService.updatePostStatus(postId, status, request.getReason(), adminId);

        // 2. Lưu vết vào lịch sử kiểm duyệt
        moderationService.recordAction(postId, null, request, adminId);

        return ResponseEntity.ok("Cập nhật trạng thái bài viết thành công!");
    }

    // Lấy lịch sử kiểm duyệt của một bài viết
    @GetMapping("/history/{postId}")
    public ResponseEntity<List<ModerationRecordResponse>> getHistory(@PathVariable Long postId) {
        return ResponseEntity.ok(moderationService.getHistoryByPost(postId));
    }

    // Lấy tất cả lịch sử kiểm duyệt (Dành cho Admin xem báo cáo)
    @GetMapping("/all")
    public ResponseEntity<List<ModerationRecordResponse>> getAllRecords() {
        return ResponseEntity.ok(moderationService.getAllRecords());
    }
}