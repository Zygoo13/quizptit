package com.quizptit.quiz.entity;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;

import com.quizptit.content.entity.Question;

@Entity
@Table(name = "quiz_question", uniqueConstraints = {
        @UniqueConstraint(name = "uk_quiz_question_quiz_question", columnNames = { "quiz_id", "question_id" }),
        @UniqueConstraint(name = "uk_quiz_question_quiz_order", columnNames = { "quiz_id", "order_no" })
})
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class QuizQuestion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "quiz_question_id")
    private Long quizQuestionId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "quiz_id", nullable = false)
    private Quiz quiz;

    // Entity Question này thuộc về module Content do Người 2 phụ trách
    // Bạn chỉ cần reference đến nó là được
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "question_id", nullable = false)
    private Question question;

    @Column(name = "order_no", nullable = false)
    private Integer orderNo;

    @Column(name = "score_weight", nullable = false, precision = 10, scale = 2)
    @Builder.Default
    private BigDecimal scoreWeight = BigDecimal.ONE;
}
