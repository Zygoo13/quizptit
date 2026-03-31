CREATE TABLE quiz (
    quiz_id BIGINT NOT NULL AUTO_INCREMENT,
    subject_id BIGINT NOT NULL,
    topic_id BIGINT NULL,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(1000) NULL,
    quiz_type VARCHAR(20) NOT NULL,
    duration_minutes INT NOT NULL,
    total_questions INT NOT NULL,
    created_by BIGINT NOT NULL,
    is_published BOOLEAN NOT NULL DEFAULT FALSE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT pk_quiz PRIMARY KEY (quiz_id),
    CONSTRAINT fk_quiz_subject
        FOREIGN KEY (subject_id) REFERENCES subject(subject_id),
    CONSTRAINT fk_quiz_topic
        FOREIGN KEY (topic_id) REFERENCES topic(topic_id),
    CONSTRAINT fk_quiz_created_by
        FOREIGN KEY (created_by) REFERENCES users(user_id),
    CONSTRAINT ck_quiz_quiz_type
        CHECK (quiz_type IN ('MANUAL', 'RANDOM')),
    CONSTRAINT ck_quiz_duration_minutes
        CHECK (duration_minutes > 0),
    CONSTRAINT ck_quiz_total_questions
        CHECK (total_questions > 0)
);