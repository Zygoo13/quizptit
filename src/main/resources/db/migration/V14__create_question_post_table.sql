CREATE TABLE question_post (
                               question_post_id BIGINT NOT NULL AUTO_INCREMENT,
                               user_id BIGINT NOT NULL,
                               topic_id BIGINT NOT NULL,
                               title VARCHAR(255) NOT NULL,
                               content TEXT NOT NULL,
                               status VARCHAR(20) NOT NULL,
                               view_count INT NOT NULL DEFAULT 0,
                               like_count INT NOT NULL DEFAULT 0,
                               comment_count INT NOT NULL DEFAULT 0,
                               theme_color VARCHAR(50) DEFAULT '#ffffff',
                               created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                               updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

                               CONSTRAINT pk_question_post PRIMARY KEY (question_post_id),
                               CONSTRAINT fk_question_post_user
                                   FOREIGN KEY (user_id) REFERENCES users(user_id),
                               CONSTRAINT fk_question_post_topic
                                   FOREIGN KEY (topic_id) REFERENCES topic(topic_id),
                               CONSTRAINT ck_question_post_status
                                   CHECK (status IN ('VISIBLE', 'HIDDEN')),
                               CONSTRAINT ck_question_post_view_count
                                   CHECK (view_count >= 0)
);