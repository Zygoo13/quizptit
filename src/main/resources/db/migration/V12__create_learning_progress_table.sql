CREATE TABLE learning_progress (
    progress_id BIGINT NOT NULL AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    topic_id BIGINT NOT NULL,
    total_quizzes INT NOT NULL DEFAULT 0,
    completed_quizzes INT NOT NULL DEFAULT 0, 
    progress_percentage DECIMAL(5,2) NOT NULL DEFAULT 0.00, 
    
    total_attempts INT NOT NULL DEFAULT 0,
    correct_rate DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    mastery_score DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    
    last_practiced_at DATETIME NULL,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT pk_learning_progress PRIMARY KEY (progress_id),
    CONSTRAINT fk_learning_progress_user
        FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT fk_learning_progress_topic
        FOREIGN KEY (topic_id) REFERENCES topic(topic_id),
    CONSTRAINT uk_learning_progress_user_topic
        UNIQUE (user_id, topic_id),
        
    CONSTRAINT ck_learning_progress_total_attempts
        CHECK (total_attempts >= 0),
    CONSTRAINT ck_learning_progress_progress_percentage
        CHECK (progress_percentage >= 0 AND progress_percentage <= 100),
    CONSTRAINT ck_learning_progress_mastery_score
        CHECK (mastery_score >= 0 AND mastery_score <= 10)
);