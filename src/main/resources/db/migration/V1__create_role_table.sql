CREATE TABLE role (
                      role_id BIGINT NOT NULL AUTO_INCREMENT,
                      role_name VARCHAR(50) NOT NULL,
                      description VARCHAR(255) NULL,

                      CONSTRAINT pk_role PRIMARY KEY (role_id),
                      CONSTRAINT uk_role_role_name UNIQUE (role_name)
);