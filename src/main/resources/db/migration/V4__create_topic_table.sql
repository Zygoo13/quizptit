CREATE TABLE topic (
                       topic_id BIGINT NOT NULL AUTO_INCREMENT,
                       subject_id BIGINT NOT NULL,
                       topic_name VARCHAR(150) NOT NULL,
                       description VARCHAR(500) NULL,
                       order_no INT NOT NULL,
                       is_active BOOLEAN NOT NULL DEFAULT TRUE,
                       created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

                       CONSTRAINT pk_topic PRIMARY KEY (topic_id),
                       CONSTRAINT fk_topic_subject
                           FOREIGN KEY (subject_id) REFERENCES subject(subject_id),
                       CONSTRAINT uk_topic_subject_topic_name UNIQUE (subject_id, topic_name)
);