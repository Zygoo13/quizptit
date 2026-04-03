package com.quizptit.community.entity;

import com.quizptit.user.entity.User;
import jakarta.persistence.*;
        import lombok.*;
        import java.time.LocalDateTime;

@Entity
@Table(name = "moderation_record")
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
    @JoinColumn(name = "question_post_id", nullable = false)
    private QuestionPost questionPost;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "moderator_id", nullable = false)
    private User user;

    public Long getModerationId() {
        return moderationId;
    }

    public void setModerationId(Long moderationId) {
        this.moderationId = moderationId;
    }

    public String getTargetType() {
        return targetType;
    }

    public void setTargetType(String targetType) {
        this.targetType = targetType;
    }

    public Long getTargetId() {
        return targetId;
    }

    public void setTargetId(Long targetId) {
        this.targetId = targetId;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public User getUser() {
        return user;
    }

    public void setModerator(User moderator) {
        this.user = moderator;
    }

    public QuestionPost getQuestionPost() {
        return questionPost;
    }

    public void setQuestionPost(QuestionPost questionPost) {
        this.questionPost = questionPost;
    }
}
