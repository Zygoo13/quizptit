package com.quizptit.community.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.quizptit.common.base.BaseEntity;
import com.quizptit.user.entity.User;
import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "question_post")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class QuestionPost extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "question_post_id")
    private Long questionPostId;

    @Column(nullable = false, length = 255)
    private String title;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String content;

    @Builder.Default
    @Column(name = "view_count", nullable = false)
    private Integer viewCount = 0;

    @Builder.Default
    @Column(name = "like_count", nullable = false)
    private Integer likeCount = 0;

    @Builder.Default
    @Column(name = "comment_count", nullable = false)
    private Integer commentCount = 0;

    @Builder.Default
    @Column(nullable = false, length = 20)
    private String status = "VISIBLE";

    @Column(name = "theme_color")
    private String themeColor;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private User user;

    @Column(name = "topic_id", nullable = false)
    private Long topicId;

    @Builder.Default
    @OneToMany(mappedBy = "questionPost", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Comment> comments = new ArrayList<>();
}