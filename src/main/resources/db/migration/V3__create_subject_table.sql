CREATE TABLE subject (
    subject_id BIGINT NOT NULL AUTO_INCREMENT,
    subject_name VARCHAR(150) NOT NULL,
    description VARCHAR(500) NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_subject PRIMARY KEY (subject_id),
    CONSTRAINT uk_subject_subject_name UNIQUE (subject_name)
);