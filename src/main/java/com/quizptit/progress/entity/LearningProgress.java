package com.quizptit.progress.entity;
import com.quizptit.user.entity.User;
import com.quizptit.content.entity.Topic;
import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "learning_progress")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class LearningProgress {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "progress_id")
    private Long progressId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "topic_id", nullable = false)
    private Topic topic;

    @Column(name = "total_attempts", nullable = false)
    private int totalAttempts;

    @Column(name = "correct_rate", nullable = false)
    private BigDecimal correctRate;

    @Column(name = "mastery_score", nullable = false)
    private BigDecimal masteryScore;

    @Column(name = "last_practiced_at")
    private LocalDateTime lastPracticedAt;
}