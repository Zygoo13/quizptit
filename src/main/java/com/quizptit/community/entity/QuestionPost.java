package com.quizptit.community.entity;

import com.quizptit.common.base.BaseEntity;
import com.quizptit.user.entity.User;
import jakarta.persistence.*;
        import lombok.*;

@Entity
@Table(name = "question_posts")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
public class QuestionPost extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "question_post_id")
    private Long questionPostId;

    @Column(nullable = false, length = 255)
    private String title;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String content;

    @Column(name = "view_count")
    private Integer viewCount = 0;

    @Column(nullable = false, length = 20)
    private String status = "VISIBLE"; // VISIBLE, HIDDEN

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "topic_id")
    private Long topicId;
}
