CREATE TABLE attempt (
                         attempt_id BIGINT NOT NULL AUTO_INCREMENT,
                         user_id BIGINT NOT NULL,
                         quiz_id BIGINT NOT NULL,
                         started_at DATETIME NOT NULL,
                         submitted_at DATETIME NULL,
                         total_score DECIMAL(10,2) NOT NULL DEFAULT 0.00,
                         correct_count INT NOT NULL DEFAULT 0,
                         status VARCHAR(20) NOT NULL,
                         duration_seconds INT NOT NULL DEFAULT 0,

                         CONSTRAINT pk_attempt PRIMARY KEY (attempt_id),
                         CONSTRAINT fk_attempt_user
                             FOREIGN KEY (user_id) REFERENCES users(user_id),
                         CONSTRAINT fk_attempt_quiz
                             FOREIGN KEY (quiz_id) REFERENCES quiz(quiz_id),
                         CONSTRAINT ck_attempt_status
                             CHECK (status IN ('IN_PROGRESS', 'SUBMITTED', 'GRADED')),
                         CONSTRAINT ck_attempt_correct_count
                             CHECK (correct_count >= 0),
                         CONSTRAINT ck_attempt_duration_seconds
                             CHECK (duration_seconds >= 0),
                         CONSTRAINT ck_attempt_total_score
                             CHECK (total_score >= 0)
);