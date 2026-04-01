CREATE TABLE attempt_question (
    attempt_question_id BIGINT NOT NULL AUTO_INCREMENT,
    attempt_id BIGINT NOT NULL,
    question_id BIGINT NOT NULL,
    order_no INT NOT NULL,
    score_weight DECIMAL(10,2) NOT NULL DEFAULT 1.00,

    CONSTRAINT pk_attempt_question PRIMARY KEY (attempt_question_id),
    CONSTRAINT fk_attempt_question_attempt
        FOREIGN KEY (attempt_id) REFERENCES attempt(attempt_id),
    CONSTRAINT fk_attempt_question_question
        FOREIGN KEY (question_id) REFERENCES question(question_id),
    CONSTRAINT uk_attempt_question_attempt_question
        UNIQUE (attempt_id, question_id),
    CONSTRAINT uk_attempt_question_attempt_order
        UNIQUE (attempt_id, order_no),
    CONSTRAINT ck_attempt_question_order_no
        CHECK (order_no > 0),
    CONSTRAINT ck_attempt_question_score_weight
        CHECK (score_weight >= 0)
);