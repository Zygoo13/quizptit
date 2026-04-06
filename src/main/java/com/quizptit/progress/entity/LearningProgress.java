package com.quizptit.progress.entity;

import com.quizptit.user.entity.User;
import com.quizptit.content.entity.Topic;
import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "learning_progress")
@Getter 
@Setter 
@NoArgsConstructor 
@AllArgsConstructor
@Builder
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
    
    @Column(name = "total_quizzes", nullable = false)
    private int totalQuizzes;

    @Column(name = "completed_quizzes", nullable = false)
    private int completedQuizzes;

    @Column(name = "progress_percentage", nullable = false)
    private BigDecimal progressPercentage;

    // ------------------------------------------------------

    @Column(name = "correct_rate", nullable = false)
    private BigDecimal correctRate;

    @Column(name = "mastery_score", nullable = false)
    private BigDecimal masteryScore;

    @Column(name = "last_practiced_at")
    private LocalDateTime lastPracticedAt;
}