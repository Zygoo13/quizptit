CREATE TABLE comment (
                         comment_id BIGINT NOT NULL AUTO_INCREMENT,
                         question_post_id BIGINT NOT NULL,
                         user_id BIGINT NOT NULL,
                         content TEXT NOT NULL,
                         status VARCHAR(20) NOT NULL,
                         created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

                         CONSTRAINT pk_comment PRIMARY KEY (comment_id),
                         CONSTRAINT fk_comment_question_post
                             FOREIGN KEY (question_post_id) REFERENCES question_post(question_post_id),
                         CONSTRAINT fk_comment_user
                             FOREIGN KEY (user_id) REFERENCES users(user_id),
                         CONSTRAINT ck_comment_status
                             CHECK (status IN ('VISIBLE', 'HIDDEN'))
);