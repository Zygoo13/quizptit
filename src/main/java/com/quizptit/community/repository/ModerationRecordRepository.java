package com.quizptit.community.repository;

import com.quizptit.community.entity.ModerationRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ModerationRecordRepository extends JpaRepository<ModerationRecord, Long> {
    // Tìm lịch sử kiểm duyệt theo loại (QUESTION_POST hoặc COMMENT)
    List<ModerationRecord> findByTargetTypeAndTargetId(String targetType, Long targetId);

    // Tìm tất cả các bản ghi kiểm duyệt của một Moderator (User)
    List<ModerationRecord> findByModeratorUserId(Long userId);
}