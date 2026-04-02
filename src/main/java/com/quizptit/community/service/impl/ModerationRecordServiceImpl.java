package com.quizptit.community.service.impl;

import com.quizptit.community.entity.ModerationRecord;
import com.quizptit.community.entity.QuestionPost;
import com.quizptit.community.repository.ModerationRecordRepository;
import com.quizptit.community.repository.QuestionPostRepository;
import com.quizptit.user.entity.User;
import com.quizptit.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class ModerationRecordServiceImpl {

    private final QuestionPostRepository postRepository;
    private final ModerationRecordRepository moderationRepository;
    private final UserRepository userRepository; // Để lấy thông tin Admin thực hiện kiểm duyệt

    @Transactional
    public void hidePost(Long postId, Long adminId, String reason) {
        // 1. Tìm bài viết cần ẩn
        QuestionPost post = postRepository.findById(postId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy bài viết để ẩn"));

        // 2. BR-38, 39: Chuyển trạng thái sang HIDDEN (Cập nhật trực tiếp vào Entity của bạn)
        post.setStatus("HIDDEN");
        postRepository.save(post);

        // 3. BR-41: Lưu vết vào bảng ModerationRecord để Admin theo dõi
        User admin = userRepository.findById(adminId)
                .orElseThrow(() -> new RuntimeException("Admin không tồn tại"));

        ModerationRecord record = new ModerationRecord();
        record.setQuestionPost(post);
        record.setUser(admin);
        record.setReason(reason);
        record.setAction("HIDE");
        // Lưu ý: createdAt sẽ tự có nếu ModerationRecord cũng extends BaseEntity

        moderationRepository.save(record);
    }
}