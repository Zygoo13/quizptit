package com.quizptit.review.entity;

import com.quizptit.common.base.BaseEntity;
import com.quizptit.user.entity.User;
import com.quizptit.content.entity.Question;
import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "user_question_memory")
@Builder
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class UserQuestionMemory extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "memory_id")
    private Long memoryId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "question_id", nullable = false)
    private Question question;

    @Column(name = "last_result", nullable = false)
    private boolean lastResult;

    @Column(name = "correct_streak", nullable = false)
    private int correctStreak;

    @Column(name = "wrong_streak", nullable = false)
    private int wrongStreak;

    @Column(name = "review_count", nullable = false)
    private int reviewCount;

    @Column(name = "memory_score", nullable = false)
    private BigDecimal memoryScore;

    @Column(name = "last_reviewed_at")
    private LocalDateTime lastReviewedAt;

    @Column(name = "next_review_at")
    private LocalDateTime nextReviewAt;
}