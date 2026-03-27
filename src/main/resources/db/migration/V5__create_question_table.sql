CREATE TABLE question (
                          question_id BIGINT NOT NULL AUTO_INCREMENT,
                          topic_id BIGINT NOT NULL,
                          content TEXT NOT NULL,
                          difficulty_level VARCHAR(20) NOT NULL,
                          explanation TEXT NULL,
                          status VARCHAR(20) NOT NULL,
                          created_by BIGINT NOT NULL,
                          created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                          updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

                          CONSTRAINT pk_question PRIMARY KEY (question_id),
                          CONSTRAINT fk_question_topic
                              FOREIGN KEY (topic_id) REFERENCES topic(topic_id),
                          CONSTRAINT fk_question_created_by
                              FOREIGN KEY (created_by) REFERENCES users(user_id),
                          CONSTRAINT ck_question_difficulty_level
                              CHECK (difficulty_level IN ('EASY', 'MEDIUM', 'HARD')),
                          CONSTRAINT ck_question_status
                              CHECK (status IN ('DRAFT', 'APPROVED', 'HIDDEN'))
);