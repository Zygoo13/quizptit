CREATE TABLE attempt_answer (
    attempt_answer_id BIGINT NOT NULL AUTO_INCREMENT,
    attempt_question_id BIGINT NOT NULL,
    selected_option_id BIGINT NULL,
    is_correct BOOLEAN NOT NULL DEFAULT FALSE,
    score_obtained DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    answered_at DATETIME NULL,

    CONSTRAINT pk_attempt_answer PRIMARY KEY (attempt_answer_id),
    CONSTRAINT fk_attempt_answer_attempt_question
        FOREIGN KEY (attempt_question_id) REFERENCES attempt_question(attempt_question_id),
    CONSTRAINT fk_attempt_answer_selected_option
        FOREIGN KEY (selected_option_id) REFERENCES answer_option(option_id),
    CONSTRAINT uk_attempt_answer_attempt_question UNIQUE (attempt_question_id),
    CONSTRAINT ck_attempt_answer_score_obtained
        CHECK (score_obtained >= 0)
);