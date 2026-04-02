package com.quizptit.community.entity;

import com.quizptit.user.entity.User;
import jakarta.persistence.*;
        import lombok.*;
        import java.time.LocalDateTime;

@Entity
@Table(name = "moderation_records")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
public class ModerationRecord {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "moderation_id")
    private Long moderationId;

    @Column(name = "target_type", nullable = false, length = 50)
    private String targetType; // QUESTION_POST, COMMENT...

    @Column(name = "target_id", nullable = false)
    private Long targetId;

    @Column(nullable = false, length = 50)
    private String action; // APPROVE, HIDE, DELETE...

    @Column(columnDefinition = "TEXT")
    private String reason;

    @Column(name = "created_at")
    private LocalDateTime createdAt = LocalDateTime.now();

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "moderator_id", nullable = false)
    private User moderator;
}
