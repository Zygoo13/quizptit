package com.quizptit.attempt.entity;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

import com.quizptit.content.entity.AnswerOption;

@Entity
@Table(name = "attempt_answer")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AttemptAnswer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "attempt_answer_id")
    private Long attemptAnswerId;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "attempt_question_id", nullable = false, unique = true)
    private AttemptQuestion attemptQuestion;

    // AnswerOption thuộc về module Content do Người 2 phụ trách
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "selected_option_id")
    private AnswerOption selectedOption;

    @Column(name = "is_correct", nullable = false)
    @Builder.Default
    private Boolean isCorrect = false;

    @Column(name = "score_obtained", nullable = false, precision = 10, scale = 2)
    @Builder.Default
    private BigDecimal scoreObtained = BigDecimal.ZERO;

    @Column(name = "answered_at")
    private LocalDateTime answeredAt;
}
