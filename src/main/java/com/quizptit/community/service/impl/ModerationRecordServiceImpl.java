package com.quizptit.community.service.impl;

import com.quizptit.community.dto.ModerationRecordRequest;
import com.quizptit.community.dto.ModerationRecordResponse;
import com.quizptit.community.entity.ModerationRecord;
import com.quizptit.community.exception.ResourceNotFoundException;
import com.quizptit.community.repository.CommentRepository;
import com.quizptit.community.repository.ModerationRecordRepository;
import com.quizptit.community.repository.QuestionPostRepository;
import com.quizptit.community.service.ModerationRecordService;
import com.quizptit.user.entity.User;
import com.quizptit.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ModerationRecordServiceImpl implements ModerationRecordService {

    private final ModerationRecordRepository moderationRecordRepository;
    private final UserRepository userRepository;
    private final CommentRepository commentRepository;
    private final QuestionPostRepository questionPostRepository;

    @Override
    public List<ModerationRecordResponse> getRecordsByType(String type) {
        List<ModerationRecord> list = moderationRecordRepository.findByTargetTypeOrderByCreatedAtDesc(type);

        return list.stream()
                .filter(Objects::nonNull)
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public ModerationRecordResponse recordAction(Long postId, Long commentId, ModerationRecordRequest request, Long adminId) {
        User admin = userRepository.findById(adminId)
                .orElseThrow(() -> new ResourceNotFoundException("Admin không tồn tại ID: " + adminId));

        String targetType = (postId != null) ? "QUESTION_POST" : "COMMENT";
        Long targetId = (postId != null) ? postId : commentId;

        String actionValue = normalizeAction(request.getAction());

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
        return moderationRecordRepository.findAll().stream()
                .filter(r -> "QUESTION_POST".equals(r.getTargetType()) && postId.equals(r.getTargetId()))
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void logPostModeration(Long postId, Long adminId, String action, String reason) {
        User admin = userRepository.findById(adminId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy Admin ID: " + adminId));

        String actionValue = normalizeAction(action);

        ModerationRecord record = ModerationRecord.builder()
                .targetId(postId)
                .targetType("QUESTION_POST")
                .action(actionValue)
                .reason(reason)
                .moderator(admin)
                .createdAt(LocalDateTime.now())
                .build();

        moderationRecordRepository.save(record);
    }

    @Override
    @Transactional
    public void logCommentModeration(Long commentId, Long adminId, String action, String reason) {
        User admin = userRepository.findById(adminId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy Admin ID: " + adminId));

        String actionValue = normalizeAction(action);

        ModerationRecord record = ModerationRecord.builder()
                .targetId(commentId)
                .targetType("COMMENT")
                .action(actionValue)
                .reason(reason)
                .moderator(admin)
                .createdAt(LocalDateTime.now())
                .build();

        moderationRecordRepository.save(record);
    }

    @Override
    @Transactional(readOnly = true)
    public List<ModerationRecordResponse> getAllRecords() {
        return moderationRecordRepository.findAll().stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    private String normalizeAction(String action) {
        if (action == null || action.isBlank()) {
            return "HIDE";
        }

        String actionValue = action.toUpperCase().trim();

        if ("HIDDEN".equals(actionValue) || "DELETED".equals(actionValue)) {
            return "HIDE";
        }

        if ("VISIBLE".equals(actionValue)) {
            return "RESTORE";
        }

        return actionValue;
    }

    private ModerationRecordResponse mapToResponse(ModerationRecord record) {
        Long finalPostId = null;
        String content = "Nội dung không tồn tại";

        if ("QUESTION_POST".equals(record.getTargetType())) {
            finalPostId = record.getTargetId();
            content = questionPostRepository.findById(record.getTargetId())
                    .map(p -> p.getTitle())
                    .orElse("Bài viết đã bị xóa vĩnh viễn");
        } else if ("COMMENT".equals(record.getTargetType())) {
            var commentOpt = commentRepository.findById(record.getTargetId());
            if (commentOpt.isPresent()) {
                var comment = commentOpt.get();
                finalPostId = comment.getQuestionPost().getQuestionPostId();
                content = comment.getContent();
            } else {
                content = "Bình luận đã bị xóa vĩnh viễn";
            }
        }

        return ModerationRecordResponse.builder()
                .moderationId(record.getModerationId())
                .postId(finalPostId)
                .commentId("COMMENT".equals(record.getTargetType()) ? record.getTargetId() : null)
                .content(content)
                .action(record.getAction())
                .reason(record.getReason())
                .moderatorName(record.getModerator() != null
                        ? "[" + record.getModerator().getUserId() + "] " + record.getModerator().getFullName()
                        : "N/A")
                .createdAt(record.getCreatedAt())
                .build();
    }
}