package com.quizptit.community.repository;

import com.quizptit.community.entity.ModerationRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ModerationRecordRepository extends JpaRepository<ModerationRecord, Long> {

    List<ModerationRecord> findByTargetTypeOrderByCreatedAtDesc(String targetType);

    Optional<ModerationRecord> findTopByTargetTypeAndTargetIdOrderByCreatedAtDesc(String targetType, Long targetId);
}