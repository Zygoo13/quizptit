package com.quizptit.community.repository;

import com.quizptit.community.entity.ModerationRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ModerationRecordRepository extends JpaRepository<ModerationRecord, Long> {
}