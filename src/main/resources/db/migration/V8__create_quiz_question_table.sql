CREATE TABLE quiz_question (
                               quiz_question_id BIGINT NOT NULL AUTO_INCREMENT,
                               quiz_id BIGINT NOT NULL,
                               question_id BIGINT NOT NULL,
                               order_no INT NOT NULL,
                               score_weight DECIMAL(10,2) NOT NULL DEFAULT 1.00,

                               CONSTRAINT pk_quiz_question PRIMARY KEY (quiz_question_id),
                               CONSTRAINT fk_quiz_question_quiz
                                   FOREIGN KEY (quiz_id) REFERENCES quiz(quiz_id),
                               CONSTRAINT fk_quiz_question_question
                                   FOREIGN KEY (question_id) REFERENCES question(question_id),
                               CONSTRAINT uk_quiz_question_quiz_question
                                   UNIQUE (quiz_id, question_id),
                               CONSTRAINT uk_quiz_question_quiz_order
                                   UNIQUE (quiz_id, order_no),
                               CONSTRAINT ck_quiz_question_order_no
                                   CHECK (order_no > 0),
                               CONSTRAINT ck_quiz_question_score_weight
                                   CHECK (score_weight >= 0)
);