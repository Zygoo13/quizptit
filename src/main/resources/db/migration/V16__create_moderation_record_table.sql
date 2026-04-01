CREATE TABLE moderation_record (
    moderation_id BIGINT NOT NULL AUTO_INCREMENT,
    moderator_id BIGINT NOT NULL,
    target_type VARCHAR(30) NOT NULL,
    target_id BIGINT NOT NULL,
    action VARCHAR(20) NOT NULL,
    reason VARCHAR(500) NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_moderation_record PRIMARY KEY (moderation_id),
    CONSTRAINT fk_moderation_record_moderator
        FOREIGN KEY (moderator_id) REFERENCES users(user_id),
    CONSTRAINT ck_moderation_record_target_type
        CHECK (target_type IN ('QUESTION_POST', 'COMMENT', 'QUESTION')),
    CONSTRAINT ck_moderation_record_action
        CHECK (action IN ('APPROVE', 'REJECT', 'HIDE', 'DELETE', 'RESTORE'))
);