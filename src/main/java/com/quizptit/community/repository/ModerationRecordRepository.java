package com.quizptit.community.repository;

import com.quizptit.community.entity.ModerationRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ModerationRecordRepository extends JpaRepository<ModerationRecord, Long> {

    List<ModerationRecord> findByTargetTypeAndTargetId(String targetType, Long targetId);

    List<ModerationRecord> findByModeratorUserId(Long userId);

    List<ModerationRecord> findByTargetTypeOrderByCreatedAtDesc(String type);
}