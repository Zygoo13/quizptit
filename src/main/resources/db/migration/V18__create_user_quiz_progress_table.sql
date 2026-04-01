CREATE TABLE user_quiz_progress (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    quiz_id BIGINT NOT NULL,
    topic_id BIGINT NOT NULL,
    highest_score DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    total_attempts INT DEFAULT 0,
    last_attempt_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_uqp_user FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT fk_uqp_quiz FOREIGN KEY (quiz_id) REFERENCES quiz(quiz_id),
    CONSTRAINT fk_uqp_topic FOREIGN KEY (topic_id) REFERENCES topic(topic_id),
    UNIQUE KEY unique_user_quiz (user_id, quiz_id),

    CONSTRAINT ck_user_quiz_progress_highest_score
        CHECK (highest_score >= 0 AND highest_score <= 1)
);