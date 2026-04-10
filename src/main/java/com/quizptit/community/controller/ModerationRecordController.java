package com.quizptit.community.controller;

import com.quizptit.community.dto.ModerationRecordRequest;
import com.quizptit.community.dto.ModerationRecordResponse;
import com.quizptit.community.service.ModerationRecordService;
import com.quizptit.community.service.QuestionPostService;
import com.quizptit.user.entity.User;
import com.quizptit.user.repository.UserRepository;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@RestController
@RequestMapping("/api/community/admin/moderation")
@RequiredArgsConstructor
public class ModerationRecordController {

    private final ModerationRecordService moderationService;
    private final QuestionPostService postService;
    private final UserRepository userRepository;

    // BR-38, 39: Admin thay đổi trạng thái bài viết & Ghi log
    @PatchMapping("/post/{postId}")
    public ResponseEntity<String> moderatePost(
            @PathVariable Long postId,
            @RequestParam String status,
            Principal principal, // <--- Thay adminId bằng Principal
            @Valid @RequestBody ModerationRecordRequest request) {

        // 1. Cập nhật status bài viết (Truyền principal.getName() là String Email)
        postService.updatePostStatus(postId, status, request.getReason(), principal.getName());

        // 2. Tìm User Admin để lưu vết (Lưu ý: recordAction của bạn vẫn đang dùng Long adminId)
        // Bạn cần tìm adminId từ email để truyền vào moderationService
        User admin = userRepository.findByEmail(principal.getName()).orElseThrow();
        moderationService.recordAction(postId, null, request, admin.getUserId());

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