package com.quizptit.attempt.entity;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;

import com.quizptit.content.entity.Question;

@Entity
@Table(name = "attempt_question", uniqueConstraints = {
        @UniqueConstraint(name = "uk_attempt_question_attempt_question", columnNames = { "attempt_id", "question_id" }),
        @UniqueConstraint(name = "uk_attempt_question_attempt_order", columnNames = { "attempt_id", "order_no" })
})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AttemptQuestion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "attempt_question_id")
    private Long attemptQuestionId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "attempt_id", nullable = false)
    private Attempt attempt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "question_id", nullable = false)
    private Question question;

    @Column(name = "order_no", nullable = false)
    private Integer orderNo;

    @Column(name = "score_weight", nullable = false, precision = 10, scale = 2)
    @Builder.Default
    private BigDecimal scoreWeight = BigDecimal.ONE;
}
