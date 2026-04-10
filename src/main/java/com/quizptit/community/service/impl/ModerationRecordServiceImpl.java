package com.quizptit.community.service.impl;

import com.quizptit.community.dto.ModerationRecordRequest;
import com.quizptit.community.dto.ModerationRecordResponse;
import com.quizptit.community.entity.ModerationRecord;
import com.quizptit.community.exception.ResourceNotFoundException;
import com.quizptit.community.repository.ModerationRecordRepository;
import com.quizptit.community.service.ModerationRecordService;
import com.quizptit.user.entity.User;
import com.quizptit.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ModerationRecordServiceImpl implements ModerationRecordService {

    private final ModerationRecordRepository moderationRecordRepository;
    private final UserRepository userRepository;

    @Override
    @Transactional
    public ModerationRecordResponse recordAction(Long postId, Long commentId, ModerationRecordRequest request, Long adminId) {
        User admin = userRepository.findById(adminId)
                .orElseThrow(() -> new ResourceNotFoundException("Admin không tồn tại ID: " + adminId));

        // Xác định loại target và ID tương ứng
        String targetType = (postId != null) ? "QUESTION_POST" : "COMMENT";
        Long targetId = (postId != null) ? postId : commentId;

        // Quan trọng: Đảm bảo request.getAction() không bị null
        String actionValue = request.getAction();
        if (actionValue == null) {
            actionValue = "HIDE"; // Giá trị mặc định nếu lỡ quên gửi từ Postman
        }

        ModerationRecord record = ModerationRecord.builder()
                .targetType(targetType)
                .targetId(targetId)
                .action(actionValue)
                .reason(request.getReason())
                .moderator(admin)
                .createdAt(LocalDateTime.now())
                .build();

        return mapToResponse(moderationRecordRepository.save(record));
    }

    @Override
    public List<ModerationRecordResponse> getHistoryByPost(Long postId) {
        // Tìm theo targetId = postId và targetType = 'QUESTION_POST'
        return moderationRecordRepository.findAll().stream()
                .filter(r -> "QUESTION_POST".equals(r.getTargetType()) && postId.equals(r.getTargetId()))
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void logPostModeration(Long postId, Long adminId, String newStatus, String reason) {
        // 1. Tìm User Admin để gán vào bản ghi
        User admin = userRepository.findById(adminId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy Admin ID: " + adminId));

        // 2. Tạo bản ghi log cho bài viết
        ModerationRecord record = ModerationRecord.builder()
                .targetId(postId)
                .targetType("QUESTION_POST") // Phân biệt với COMMENT
                .action(newStatus)
                .reason(reason)
                .moderator(admin)
                .createdAt(LocalDateTime.now())
                .build();

        // 3. Lưu vào database
        moderationRecordRepository.save(record);
    }

    @Override
    @Transactional
    public void logCommentModeration(Long commentId, Long adminId, String newStatus, String reason) {
        ModerationRecord record = new ModerationRecord();

        // 1. Gán các thông tin cơ bản
        record.setTargetId(commentId);
        record.setTargetType("COMMENT");
        record.setReason(reason);

        // 2. Map newStatus (từ Service truyền vào) sang trường action của Entity
        // Ví dụ: newStatus là "HIDDEN" thì action cũng là "HIDE" hoặc "HIDDEN"
        record.setAction(newStatus);

        // 3. Xử lý trường Moderator (Quan trọng nhất)
        // Vì moderator là một Entity User, bạn cần set Object User cho nó chứ không phải ID
        User admin = userRepository.findById(adminId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy Admin ID: " + adminId));
        record.setModerator(admin);

        record.setCreatedAt(LocalDateTime.now());

        moderationRecordRepository.save(record);
    }

    @Override
    @Transactional(readOnly = true)
    public List<ModerationRecordResponse> getAllRecords() {
        // Lấy toàn bộ log, sắp xếp cái mới nhất lên đầu cho dễ xem
        return moderationRecordRepository.findAll().stream()
                .map(this::mapToResponse) // Dùng hàm mapToResponse để chuyển sang DTO
                .collect(Collectors.toList());
    }

    private ModerationRecordResponse mapToResponse(ModerationRecord record) {
        return ModerationRecordResponse.builder()
                .moderationId(record.getModerationId())
                .postId("QUESTION_POST".equals(record.getTargetType()) ? record.getTargetId() : null)
                .commentId("COMMENT".equals(record.getTargetType()) ? record.getTargetId() : null)
                .action(record.getAction())
                .reason(record.getReason())
                .moderatorName(record.getModerator() != null ? record.getModerator().getFullName() : "N/A")
                .createdAt(record.getCreatedAt())
                .build();
    }
}