INSERT INTO role (role_name, description)
SELECT 'ADMIN', 'System administrator'
    WHERE NOT EXISTS (
    SELECT 1 FROM role WHERE role_name = 'ADMIN'
);

INSERT INTO role (role_name, description)
SELECT 'STUDENT', 'Student user'
    WHERE NOT EXISTS (
    SELECT 1 FROM role WHERE role_name = 'STUDENT'
);

INSERT INTO users (
    role_id,
    full_name,
    email,
    password_hash,
    avatar_url,
    status,
    created_at,
    updated_at
)
SELECT
    r.role_id,
    'System Administrator',
    'admin@quizptit.local',
    '$2a$10$VSRZfFw6NZA.FM96VKJVveWxLN3LSSgM2grD8hBVJHORy9G1eK1LG', -- 88888888
    NULL,
    'ACTIVE',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM role r
WHERE r.role_name = 'ADMIN'
  AND NOT EXISTS (
    SELECT 1 FROM users WHERE email = 'admin@quizptit.local'
);

INSERT INTO users (
    role_id,
    full_name,
    email,
    password_hash,
    avatar_url,
    status,
    created_at,
    updated_at
)
SELECT
    r.role_id,
    'Test Student',
    'student@quizptit.local',
    '$2a$10$VSRZfFw6NZA.FM96VKJVveWxLN3LSSgM2grD8hBVJHORy9G1eK1LG', -- 88888888
    NULL,
    'ACTIVE',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM role r
WHERE r.role_name = 'STUDENT'
  AND NOT EXISTS (
    SELECT 1 FROM users WHERE email = 'student@quizptit.local'
);