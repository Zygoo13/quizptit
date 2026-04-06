package com.quizptit.progress.entity;

import com.quizptit.user.entity.User;
import com.quizptit.quiz.entity.Quiz; // Chờ thay đổi theo thực tế
import com.quizptit.content.entity.Topic;
import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "user_quiz_progress")
@Builder
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class UserQuizProgress {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "quiz_id", nullable = false)
    private Quiz quiz;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "topic_id", nullable = false)
    private Topic topic;

    @Column(name = "highest_score", nullable = false)
    private BigDecimal highestScore;

    @Column(name = "total_attempts")
    private int totalAttempts;

    @Column(name = "last_attempt_at")
    private LocalDateTime lastAttemptAt;
}