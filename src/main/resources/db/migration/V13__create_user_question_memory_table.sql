CREATE TABLE user_question_memory (
                                      memory_id BIGINT NOT NULL AUTO_INCREMENT,
                                      user_id BIGINT NOT NULL,
                                      question_id BIGINT NOT NULL,
                                      last_result VARCHAR(20) NOT NULL,
                                      correct_streak INT NOT NULL DEFAULT 0,
                                      wrong_count INT NOT NULL DEFAULT 0,
                                      review_count INT NOT NULL DEFAULT 0,
                                      memory_score DECIMAL(10,2) NOT NULL DEFAULT 0.00,
                                      understanding_level VARCHAR(20) NOT NULL,
                                      last_reviewed_at DATETIME NULL,
                                      next_review_at DATETIME NULL,
                                      updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

                                      CONSTRAINT pk_user_question_memory PRIMARY KEY (memory_id),
                                      CONSTRAINT fk_user_question_memory_user
                                          FOREIGN KEY (user_id) REFERENCES users(user_id),
                                      CONSTRAINT fk_user_question_memory_question
                                          FOREIGN KEY (question_id) REFERENCES question(question_id),
                                      CONSTRAINT uk_user_question_memory_user_question
                                          UNIQUE (user_id, question_id),
                                      CONSTRAINT ck_user_question_memory_last_result
                                          CHECK (last_result IN ('CORRECT', 'INCORRECT', 'SKIPPED')),
                                      CONSTRAINT ck_user_question_memory_correct_streak
                                          CHECK (correct_streak >= 0),
                                      CONSTRAINT ck_user_question_memory_wrong_count
                                          CHECK (wrong_count >= 0),
                                      CONSTRAINT ck_user_question_memory_review_count
                                          CHECK (review_count >= 0),
                                      CONSTRAINT ck_user_question_memory_memory_score
                                          CHECK (memory_score >= 0),
                                      CONSTRAINT ck_user_question_memory_understanding_level
                                          CHECK (understanding_level IN ('LOW', 'MEDIUM', 'HIGH'))
);