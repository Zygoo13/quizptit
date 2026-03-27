CREATE TABLE answer_option (
                               option_id BIGINT NOT NULL AUTO_INCREMENT,
                               question_id BIGINT NOT NULL,
                               option_label VARCHAR(10) NOT NULL,
                               content VARCHAR(500) NOT NULL,
                               is_correct BOOLEAN NOT NULL DEFAULT FALSE,

                               CONSTRAINT pk_answer_option PRIMARY KEY (option_id),
                               CONSTRAINT fk_answer_option_question
                                   FOREIGN KEY (question_id) REFERENCES question(question_id),
                               CONSTRAINT uk_answer_option_question_label
                                   UNIQUE (question_id, option_label)
);