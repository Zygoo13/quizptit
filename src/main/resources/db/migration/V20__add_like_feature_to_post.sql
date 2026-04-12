CREATE TABLE post_likes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    post_id BIGINT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    -- Ràng buộc để không bao giờ có chuyện 1 người like 1 bài 2 lần trong DB
    UNIQUE KEY unique_user_post_like (user_id, post_id),
    CONSTRAINT fk_like_user FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT fk_like_post FOREIGN KEY (post_id) REFERENCES question_post(question_post_id)
);