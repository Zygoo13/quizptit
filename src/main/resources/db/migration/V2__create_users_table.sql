CREATE TABLE users (
                       user_id BIGINT NOT NULL AUTO_INCREMENT,
                       role_id BIGINT NOT NULL,
                       full_name VARCHAR(100) NOT NULL,
                       email VARCHAR(255) NOT NULL,
                       password_hash VARCHAR(255) NOT NULL,
                       avatar_url VARCHAR(500) NULL,
                       status VARCHAR(20) NOT NULL,
                       created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                       updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

                       CONSTRAINT pk_users PRIMARY KEY (user_id),
                       CONSTRAINT uk_users_email UNIQUE (email),
                       CONSTRAINT fk_users_role
                           FOREIGN KEY (role_id) REFERENCES role(role_id),
                       CONSTRAINT ck_users_status
                           CHECK (status IN ('ACTIVE', 'INACTIVE', 'BANNED'))
);