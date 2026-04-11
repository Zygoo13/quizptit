package com.quizptit.community.entity;

import com.quizptit.user.entity.User;
import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "moderation_record")
@Getter @Setter
@Builder
@NoArgsConstructor @AllArgsConstructor
public class ModerationRecord {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "moderation_id")
    private Long moderationId;

    @Column(name = "target_type", nullable = false, length = 30)
    private String targetType; // QUESTION_POST, COMMENT, QUESTION

    @Column(name = "target_id", nullable = false)
    private Long targetId;

    @Column(nullable = false, length = 20)
    private String action; // APPROVE, REJECT, HIDE, DELETE, RESTORE

    @Column(length = 500)
    private String reason;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "moderator_id", nullable = false)
    private User moderator;
}