package com.quizptit.community.entity;

import com.quizptit.common.base.BaseEntity;
import com.quizptit.user.entity.User;
import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Table(name = "comment")
@Getter @Setter
@Builder
@NoArgsConstructor @AllArgsConstructor
public class Comment extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "comment_id")
    private Long commentId;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String content;

    @Column(nullable = false, length = 20)
    private String status = "VISIBLE";

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "question_post_id", nullable = false)
    private QuestionPost questionPost;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "parent_id")
    private Comment parentComment; // Nếu null là cmt cấp 1, nếu có giá trị là cmt cấp 2

    @OneToMany(mappedBy = "parentComment", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("createdAt ASC") // Phản hồi hiện theo thứ tự thời gian
    private List<Comment> replies;


}
