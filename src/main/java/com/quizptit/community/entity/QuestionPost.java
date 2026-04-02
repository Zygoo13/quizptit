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

    public Long getQuestionPostId() {
        return questionPostId;
    }

    public void setQuestionPostId(Long questionPostId) {
        this.questionPostId = questionPostId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getViewCount() {
        return viewCount;
    }

    public void setViewCount(Integer viewCount) {
        this.viewCount = viewCount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Long getTopicId() {
        return topicId;
    }

    public void setTopicId(Long topicId) {
        this.topicId = topicId;
    }
}
