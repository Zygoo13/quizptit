package com.quizptit.community.service;

import com.quizptit.community.dto.ModerationRecordRequest;
import com.quizptit.community.dto.ModerationRecordResponse;
import com.quizptit.community.entity.ModerationRecord;

import java.util.List;

public interface ModerationRecordService {

    // BR-38, 41: Ghi lại một hành động kiểm duyệt (Ẩn, Xóa, Khôi phục)
    ModerationRecordResponse recordAction(Long postId, Long commentId, ModerationRecordRequest request, Long adminId);

    // BR-41: Lấy lịch sử kiểm duyệt của một bài viết cụ thể
    List<ModerationRecordResponse> getHistoryByPost(Long postId);

    // Lấy tất cả danh sách kiểm duyệt (Dành cho báo cáo quản trị)
    List<ModerationRecordResponse> getAllRecords();

    void logCommentModeration(Long commentId, Long adminId, String newStatus, String reason);

    void logPostModeration(Long postId, Long userId, String status, String reason);

    List<ModerationRecordResponse> getRecordsByType(String type); // type là "POST" hoặc "COMMENT"
}