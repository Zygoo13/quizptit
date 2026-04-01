package com.quizptit.content.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "answer_option")
@Getter
@Setter
@NoArgsConstructor
public class AnswerOption {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "option_id")
    private Long optionId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "question_id", nullable = false)
    private Question question;

    @Column(name = "option_label", nullable = false, length = 10)
    private String optionLabel;

    @Column(name = "content", nullable = false, length = 500)
    private String content;

    @Column(name = "is_correct", nullable = false)
    private Boolean isCorrect = false;
}
