-- =========================================================
-- V22__seed_demo_full.sql
-- Seed demo full chức năng cho QuizPTIT
-- Yêu cầu: chạy SAU V17__seed_roles_and_users.sql
-- Bám đúng schema hiện tại
-- =========================================================

-- =========================================================
-- 0) PRECHECK IDS
-- =========================================================
SET @admin_id = (SELECT user_id FROM users WHERE email = 'admin@quizptit.local' LIMIT 1);
SET @student_id = (SELECT user_id FROM users WHERE email = 'student@quizptit.local' LIMIT 1);

-- Nếu V17 chưa chạy thì toàn bộ seed phía sau sẽ không có created_by hợp lệ
-- nên cần chắc chắn admin/student đã tồn tại trước.

-- =========================================================
-- 1) USERS DEMO BỔ SUNG
-- password: 88888888
-- =========================================================

INSERT INTO users (
    role_id, full_name, email, password_hash, avatar_url, status, created_at, updated_at
)
SELECT r.role_id, 'Trần Minh Anh', 'minhanh@quizptit.local',
       '$2a$10$VSRZfFw6NZA.FM96VKJVveWxLN3LSSgM2grD8hBVJHORy9G1eK1LG',
       NULL, 'ACTIVE', '2026-03-20 08:05:00', '2026-03-20 08:05:00'
FROM role r
WHERE r.role_name = 'STUDENT'
  AND NOT EXISTS (SELECT 1 FROM users WHERE email = 'minhanh@quizptit.local');

INSERT INTO users (
    role_id, full_name, email, password_hash, avatar_url, status, created_at, updated_at
)
SELECT r.role_id, 'Lê Hoàng Nam', 'hoangnam@quizptit.local',
       '$2a$10$VSRZfFw6NZA.FM96VKJVveWxLN3LSSgM2grD8hBVJHORy9G1eK1LG',
       NULL, 'ACTIVE', '2026-03-20 08:10:00', '2026-03-20 08:10:00'
FROM role r
WHERE r.role_name = 'STUDENT'
  AND NOT EXISTS (SELECT 1 FROM users WHERE email = 'hoangnam@quizptit.local');

INSERT INTO users (
    role_id, full_name, email, password_hash, avatar_url, status, created_at, updated_at
)
SELECT r.role_id, 'Phạm Thu Hà', 'thuha@quizptit.local',
       '$2a$10$VSRZfFw6NZA.FM96VKJVveWxLN3LSSgM2grD8hBVJHORy9G1eK1LG',
       NULL, 'ACTIVE', '2026-03-20 08:15:00', '2026-03-20 08:15:00'
FROM role r
WHERE r.role_name = 'STUDENT'
  AND NOT EXISTS (SELECT 1 FROM users WHERE email = 'thuha@quizptit.local');

INSERT INTO users (
    role_id, full_name, email, password_hash, avatar_url, status, created_at, updated_at
)
SELECT r.role_id, 'Demo Banned User', 'banned@quizptit.local',
       '$2a$10$VSRZfFw6NZA.FM96VKJVveWxLN3LSSgM2grD8hBVJHORy9G1eK1LG',
       NULL, 'BANNED', '2026-03-20 08:20:00', '2026-03-20 08:20:00'
FROM role r
WHERE r.role_name = 'STUDENT'
  AND NOT EXISTS (SELECT 1 FROM users WHERE email = 'banned@quizptit.local');

-- refresh ids
SET @minhanh_id  = (SELECT user_id FROM users WHERE email = 'minhanh@quizptit.local' LIMIT 1);
SET @hoangnam_id = (SELECT user_id FROM users WHERE email = 'hoangnam@quizptit.local' LIMIT 1);
SET @thuha_id    = (SELECT user_id FROM users WHERE email = 'thuha@quizptit.local' LIMIT 1);

-- =========================================================
-- 2) SUBJECT
-- =========================================================

INSERT INTO subject (subject_name, description, is_active, created_at)
SELECT 'Lập trình Java', 'Môn học về Java core, OOP, collections và xử lý ngoại lệ', TRUE, '2026-03-21 09:00:00'
    WHERE NOT EXISTS (SELECT 1 FROM subject WHERE subject_name = 'Lập trình Java');

INSERT INTO subject (subject_name, description, is_active, created_at)
SELECT 'Cấu trúc dữ liệu và giải thuật', 'Môn học về sorting, searching và phân tích độ phức tạp', TRUE, '2026-03-21 09:05:00'
    WHERE NOT EXISTS (SELECT 1 FROM subject WHERE subject_name = 'Cấu trúc dữ liệu và giải thuật');

INSERT INTO subject (subject_name, description, is_active, created_at)
SELECT 'Cơ sở dữ liệu', 'Môn học về SQL cơ bản, join, index và tối ưu truy vấn', TRUE, '2026-03-21 09:10:00'
    WHERE NOT EXISTS (SELECT 1 FROM subject WHERE subject_name = 'Cơ sở dữ liệu');

INSERT INTO subject (subject_name, description, is_active, created_at)
SELECT 'Mạng máy tính', 'Môn học đã tạo nhưng tạm ẩn để demo quản trị', FALSE, '2026-03-21 09:15:00'
    WHERE NOT EXISTS (SELECT 1 FROM subject WHERE subject_name = 'Mạng máy tính');

SET @java_subject_id = (SELECT subject_id FROM subject WHERE subject_name = 'Lập trình Java' LIMIT 1);
SET @dsa_subject_id  = (SELECT subject_id FROM subject WHERE subject_name = 'Cấu trúc dữ liệu và giải thuật' LIMIT 1);
SET @db_subject_id   = (SELECT subject_id FROM subject WHERE subject_name = 'Cơ sở dữ liệu' LIMIT 1);
SET @net_subject_id  = (SELECT subject_id FROM subject WHERE subject_name = 'Mạng máy tính' LIMIT 1);

-- =========================================================
-- 3) TOPIC
-- =========================================================

INSERT INTO topic (subject_id, topic_name, description, order_no, is_active, created_at)
SELECT @java_subject_id, 'OOP cơ bản', 'Class, object, encapsulation, inheritance, polymorphism', 1, TRUE, '2026-03-21 09:30:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM topic WHERE subject_id = @java_subject_id AND topic_name = 'OOP cơ bản'
);

INSERT INTO topic (subject_id, topic_name, description, order_no, is_active, created_at)
SELECT @java_subject_id, 'Collections Framework', 'List, Set, Map, ArrayList, HashMap', 2, TRUE, '2026-03-21 09:31:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM topic WHERE subject_id = @java_subject_id AND topic_name = 'Collections Framework'
);

INSERT INTO topic (subject_id, topic_name, description, order_no, is_active, created_at)
SELECT @dsa_subject_id, 'Sắp xếp cơ bản', 'Bubble Sort, Selection Sort, Insertion Sort', 1, TRUE, '2026-03-21 09:32:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM topic WHERE subject_id = @dsa_subject_id AND topic_name = 'Sắp xếp cơ bản'
);

INSERT INTO topic (subject_id, topic_name, description, order_no, is_active, created_at)
SELECT @dsa_subject_id, 'Tìm kiếm và độ phức tạp', 'Binary Search, Big-O, tư duy phân tích', 2, TRUE, '2026-03-21 09:33:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM topic WHERE subject_id = @dsa_subject_id AND topic_name = 'Tìm kiếm và độ phức tạp'
);

INSERT INTO topic (subject_id, topic_name, description, order_no, is_active, created_at)
SELECT @db_subject_id, 'SQL cơ bản', 'SELECT, WHERE, GROUP BY, ORDER BY', 1, TRUE, '2026-03-21 09:34:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM topic WHERE subject_id = @db_subject_id AND topic_name = 'SQL cơ bản'
);

INSERT INTO topic (subject_id, topic_name, description, order_no, is_active, created_at)
SELECT @db_subject_id, 'JOIN và INDEX', 'INNER JOIN, LEFT JOIN, index và tối ưu', 2, TRUE, '2026-03-21 09:35:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM topic WHERE subject_id = @db_subject_id AND topic_name = 'JOIN và INDEX'
);

INSERT INTO topic (subject_id, topic_name, description, order_no, is_active, created_at)
SELECT @net_subject_id, 'Mô hình OSI', 'Topic ẩn để demo bật/tắt trạng thái', 1, FALSE, '2026-03-21 09:36:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM topic WHERE subject_id = @net_subject_id AND topic_name = 'Mô hình OSI'
);

SET @oop_topic_id         = (SELECT topic_id FROM topic WHERE subject_id = @java_subject_id AND topic_name = 'OOP cơ bản' LIMIT 1);
SET @collection_topic_id  = (SELECT topic_id FROM topic WHERE subject_id = @java_subject_id AND topic_name = 'Collections Framework' LIMIT 1);
SET @sort_topic_id        = (SELECT topic_id FROM topic WHERE subject_id = @dsa_subject_id AND topic_name = 'Sắp xếp cơ bản' LIMIT 1);
SET @sql_topic_id         = (SELECT topic_id FROM topic WHERE subject_id = @db_subject_id AND topic_name = 'SQL cơ bản' LIMIT 1);
SET @join_topic_id        = (SELECT topic_id FROM topic WHERE subject_id = @db_subject_id AND topic_name = 'JOIN và INDEX' LIMIT 1);

-- =========================================================
-- 4) QUESTION
-- =========================================================

-- OOP
INSERT INTO question (topic_id, content, difficulty_level, explanation, status, created_by, created_at, updated_at)
SELECT @oop_topic_id, 'Tính đóng gói trong OOP nhằm mục đích chính là gì?', 'EASY',
       'Đóng gói giúp ẩn dữ liệu nội bộ và kiểm soát truy cập thông qua method.',
       'APPROVED', @admin_id, '2026-03-22 08:00:00', '2026-03-22 08:00:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM question WHERE topic_id = @oop_topic_id AND content = 'Tính đóng gói trong OOP nhằm mục đích chính là gì?'
);

INSERT INTO question (topic_id, content, difficulty_level, explanation, status, created_by, created_at, updated_at)
SELECT @oop_topic_id, 'Trong Java, từ khóa nào dùng để kế thừa một class khác?', 'EASY',
       'Class con dùng từ khóa extends để kế thừa class cha.',
       'APPROVED', @admin_id, '2026-03-22 08:05:00', '2026-03-22 08:05:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM question WHERE topic_id = @oop_topic_id AND content = 'Trong Java, từ khóa nào dùng để kế thừa một class khác?'
);

INSERT INTO question (topic_id, content, difficulty_level, explanation, status, created_by, created_at, updated_at)
SELECT @oop_topic_id, 'Đa hình trong Java thể hiện rõ nhất ở cơ chế nào?', 'MEDIUM',
       'Đa hình thường thể hiện qua method overriding và gọi method theo kiểu đối tượng thực tế.',
       'APPROVED', @admin_id, '2026-03-22 08:10:00', '2026-03-22 08:10:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM question WHERE topic_id = @oop_topic_id AND content = 'Đa hình trong Java thể hiện rõ nhất ở cơ chế nào?'
);

INSERT INTO question (topic_id, content, difficulty_level, explanation, status, created_by, created_at, updated_at)
SELECT @oop_topic_id, 'Phát biểu nào đúng về abstract class trong Java?', 'MEDIUM',
       'Abstract class có thể chứa cả abstract method lẫn non-abstract method.',
       'APPROVED', @admin_id, '2026-03-22 08:15:00', '2026-03-22 08:15:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM question WHERE topic_id = @oop_topic_id AND content = 'Phát biểu nào đúng về abstract class trong Java?'
);

INSERT INTO question (topic_id, content, difficulty_level, explanation, status, created_by, created_at, updated_at)
SELECT @oop_topic_id, 'Trong Java, từ khóa goto được sử dụng để nhảy đến nhãn bất kỳ.', 'EASY',
       'Java không hỗ trợ goto như một từ khóa hoạt động thực tế; đây là câu sai để demo ẩn câu hỏi.',
       'HIDDEN', @admin_id, '2026-03-22 09:20:00', '2026-03-22 09:20:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM question WHERE topic_id = @oop_topic_id AND content = 'Trong Java, từ khóa goto được sử dụng để nhảy đến nhãn bất kỳ.'
);

-- Collections
INSERT INTO question (topic_id, content, difficulty_level, explanation, status, created_by, created_at, updated_at)
SELECT @collection_topic_id, 'Collection nào cho phép phần tử trùng lặp và truy cập theo chỉ số?', 'EASY',
       'List cho phép trùng lặp và truy cập theo index.',
       'APPROVED', @admin_id, '2026-03-22 08:20:00', '2026-03-22 08:20:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM question WHERE topic_id = @collection_topic_id AND content = 'Collection nào cho phép phần tử trùng lặp và truy cập theo chỉ số?'
);

INSERT INTO question (topic_id, content, difficulty_level, explanation, status, created_by, created_at, updated_at)
SELECT @collection_topic_id, 'HashMap lưu trữ dữ liệu theo cặp nào?', 'EASY',
       'HashMap lưu dữ liệu theo cặp key-value.',
       'APPROVED', @admin_id, '2026-03-22 08:25:00', '2026-03-22 08:25:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM question WHERE topic_id = @collection_topic_id AND content = 'HashMap lưu trữ dữ liệu theo cặp nào?'
);

INSERT INTO question (topic_id, content, difficulty_level, explanation, status, created_by, created_at, updated_at)
SELECT @collection_topic_id, 'Collection nào không cho phép phần tử trùng lặp?', 'EASY',
       'Set là collection không cho phép phần tử trùng lặp.',
       'APPROVED', @admin_id, '2026-03-22 08:30:00', '2026-03-22 08:30:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM question WHERE topic_id = @collection_topic_id AND content = 'Collection nào không cho phép phần tử trùng lặp?'
);

INSERT INTO question (topic_id, content, difficulty_level, explanation, status, created_by, created_at, updated_at)
SELECT @collection_topic_id, 'Khi cần duyệt theo thứ tự chèn và tra cứu nhanh key, lựa chọn phù hợp hơn là gì?', 'MEDIUM',
       'LinkedHashMap vừa giữ thứ tự chèn vừa hỗ trợ map theo key.',
       'APPROVED', @admin_id, '2026-03-22 08:35:00', '2026-03-22 08:35:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM question WHERE topic_id = @collection_topic_id AND content = 'Khi cần duyệt theo thứ tự chèn và tra cứu nhanh key, lựa chọn phù hợp hơn là gì?'
);

-- Sorting
INSERT INTO question (topic_id, content, difficulty_level, explanation, status, created_by, created_at, updated_at)
SELECT @sort_topic_id, 'Bubble Sort hoạt động dựa trên nguyên tắc nào?', 'EASY',
       'Bubble Sort so sánh các cặp phần tử kề nhau và đổi chỗ nếu sai thứ tự.',
       'APPROVED', @admin_id, '2026-03-22 08:40:00', '2026-03-22 08:40:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM question WHERE topic_id = @sort_topic_id AND content = 'Bubble Sort hoạt động dựa trên nguyên tắc nào?'
);

INSERT INTO question (topic_id, content, difficulty_level, explanation, status, created_by, created_at, updated_at)
SELECT @sort_topic_id, 'Selection Sort mỗi vòng lặp sẽ làm gì?', 'MEDIUM',
       'Selection Sort chọn phần tử nhỏ nhất của đoạn chưa sắp xếp rồi đưa về đầu đoạn.',
       'APPROVED', @admin_id, '2026-03-22 08:45:00', '2026-03-22 08:45:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM question WHERE topic_id = @sort_topic_id AND content = 'Selection Sort mỗi vòng lặp sẽ làm gì?'
);

INSERT INTO question (topic_id, content, difficulty_level, explanation, status, created_by, created_at, updated_at)
SELECT @sort_topic_id, 'Insertion Sort hiệu quả tương đối tốt khi nào?', 'MEDIUM',
       'Insertion Sort khá hiệu quả với dãy nhỏ hoặc gần như đã được sắp xếp.',
       'APPROVED', @admin_id, '2026-03-22 08:50:00', '2026-03-22 08:50:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM question WHERE topic_id = @sort_topic_id AND content = 'Insertion Sort hiệu quả tương đối tốt khi nào?'
);

INSERT INTO question (topic_id, content, difficulty_level, explanation, status, created_by, created_at, updated_at)
SELECT @sort_topic_id, 'Độ phức tạp thời gian trung bình của Bubble Sort là bao nhiêu?', 'HARD',
       'Bubble Sort có độ phức tạp trung bình là O(n^2).',
       'APPROVED', @admin_id, '2026-03-22 08:55:00', '2026-03-22 08:55:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM question WHERE topic_id = @sort_topic_id AND content = 'Độ phức tạp thời gian trung bình của Bubble Sort là bao nhiêu?'
);

-- SQL
INSERT INTO question (topic_id, content, difficulty_level, explanation, status, created_by, created_at, updated_at)
SELECT @sql_topic_id, 'Mệnh đề nào dùng để lọc bản ghi trong câu lệnh SELECT?', 'EASY',
       'WHERE dùng để lọc bản ghi theo điều kiện.',
       'APPROVED', @admin_id, '2026-03-22 09:00:00', '2026-03-22 09:00:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM question WHERE topic_id = @sql_topic_id AND content = 'Mệnh đề nào dùng để lọc bản ghi trong câu lệnh SELECT?'
);

INSERT INTO question (topic_id, content, difficulty_level, explanation, status, created_by, created_at, updated_at)
SELECT @sql_topic_id, 'Hàm COUNT(*) trong SQL dùng để làm gì?', 'EASY',
       'COUNT(*) đếm số dòng thỏa điều kiện truy vấn.',
       'APPROVED', @admin_id, '2026-03-22 09:05:00', '2026-03-22 09:05:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM question WHERE topic_id = @sql_topic_id AND content = 'Hàm COUNT(*) trong SQL dùng để làm gì?'
);

-- JOIN & INDEX
INSERT INTO question (topic_id, content, difficulty_level, explanation, status, created_by, created_at, updated_at)
SELECT @join_topic_id, 'INNER JOIN trả về dữ liệu như thế nào?', 'MEDIUM',
       'INNER JOIN chỉ trả về các bản ghi có khóa khớp ở cả hai bảng.',
       'APPROVED', @admin_id, '2026-03-22 09:10:00', '2026-03-22 09:10:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM question WHERE topic_id = @join_topic_id AND content = 'INNER JOIN trả về dữ liệu như thế nào?'
);

INSERT INTO question (topic_id, content, difficulty_level, explanation, status, created_by, created_at, updated_at)
SELECT @join_topic_id, 'Index trong cơ sở dữ liệu chủ yếu giúp cải thiện điều gì?', 'MEDIUM',
       'Index giúp tăng tốc truy vấn tìm kiếm/tra cứu, đổi lại tốn thêm chi phí ghi và bộ nhớ.',
       'APPROVED', @admin_id, '2026-03-22 09:15:00', '2026-03-22 09:15:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM question WHERE topic_id = @join_topic_id AND content = 'Index trong cơ sở dữ liệu chủ yếu giúp cải thiện điều gì?'
);

-- =========================================================
-- 5) ANSWER OPTION
-- =========================================================

SET @q1  = (SELECT question_id FROM question WHERE topic_id = @oop_topic_id        AND content = 'Tính đóng gói trong OOP nhằm mục đích chính là gì?' LIMIT 1);
SET @q2  = (SELECT question_id FROM question WHERE topic_id = @oop_topic_id        AND content = 'Trong Java, từ khóa nào dùng để kế thừa một class khác?' LIMIT 1);
SET @q3  = (SELECT question_id FROM question WHERE topic_id = @oop_topic_id        AND content = 'Đa hình trong Java thể hiện rõ nhất ở cơ chế nào?' LIMIT 1);
SET @q4  = (SELECT question_id FROM question WHERE topic_id = @oop_topic_id        AND content = 'Phát biểu nào đúng về abstract class trong Java?' LIMIT 1);
SET @q5  = (SELECT question_id FROM question WHERE topic_id = @collection_topic_id AND content = 'Collection nào cho phép phần tử trùng lặp và truy cập theo chỉ số?' LIMIT 1);
SET @q6  = (SELECT question_id FROM question WHERE topic_id = @collection_topic_id AND content = 'HashMap lưu trữ dữ liệu theo cặp nào?' LIMIT 1);
SET @q7  = (SELECT question_id FROM question WHERE topic_id = @collection_topic_id AND content = 'Collection nào không cho phép phần tử trùng lặp?' LIMIT 1);
SET @q8  = (SELECT question_id FROM question WHERE topic_id = @collection_topic_id AND content = 'Khi cần duyệt theo thứ tự chèn và tra cứu nhanh key, lựa chọn phù hợp hơn là gì?' LIMIT 1);
SET @q9  = (SELECT question_id FROM question WHERE topic_id = @sort_topic_id       AND content = 'Bubble Sort hoạt động dựa trên nguyên tắc nào?' LIMIT 1);
SET @q10 = (SELECT question_id FROM question WHERE topic_id = @sort_topic_id       AND content = 'Selection Sort mỗi vòng lặp sẽ làm gì?' LIMIT 1);
SET @q11 = (SELECT question_id FROM question WHERE topic_id = @sort_topic_id       AND content = 'Insertion Sort hiệu quả tương đối tốt khi nào?' LIMIT 1);
SET @q12 = (SELECT question_id FROM question WHERE topic_id = @sort_topic_id       AND content = 'Độ phức tạp thời gian trung bình của Bubble Sort là bao nhiêu?' LIMIT 1);
SET @q13 = (SELECT question_id FROM question WHERE topic_id = @sql_topic_id        AND content = 'Mệnh đề nào dùng để lọc bản ghi trong câu lệnh SELECT?' LIMIT 1);
SET @q14 = (SELECT question_id FROM question WHERE topic_id = @sql_topic_id        AND content = 'Hàm COUNT(*) trong SQL dùng để làm gì?' LIMIT 1);
SET @q15 = (SELECT question_id FROM question WHERE topic_id = @join_topic_id       AND content = 'INNER JOIN trả về dữ liệu như thế nào?' LIMIT 1);
SET @q16 = (SELECT question_id FROM question WHERE topic_id = @join_topic_id       AND content = 'Index trong cơ sở dữ liệu chủ yếu giúp cải thiện điều gì?' LIMIT 1);
SET @q17 = (SELECT question_id FROM question WHERE topic_id = @oop_topic_id        AND content = 'Trong Java, từ khóa goto được sử dụng để nhảy đến nhãn bất kỳ.' LIMIT 1);

-- helper pattern: mỗi câu 4 đáp án
-- q1
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q1, 'A', 'Ẩn dữ liệu và kiểm soát truy cập', TRUE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q1 AND option_label = 'A');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q1, 'B', 'Cho phép class có nhiều cha', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q1 AND option_label = 'B');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q1, 'C', 'Bắt buộc mọi method đều là static', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q1 AND option_label = 'C');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q1, 'D', 'Tăng tốc độ biên dịch', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q1 AND option_label = 'D');

-- q2
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q2, 'A', 'implements', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q2 AND option_label = 'A');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q2, 'B', 'extends', TRUE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q2 AND option_label = 'B');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q2, 'C', 'inherits', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q2 AND option_label = 'C');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q2, 'D', 'instanceof', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q2 AND option_label = 'D');

-- q3
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q3, 'A', 'Method overloading duy nhất', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q3 AND option_label = 'A');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q3, 'B', 'Method overriding', TRUE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q3 AND option_label = 'B');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q3, 'C', 'Đổi tên package', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q3 AND option_label = 'C');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q3, 'D', 'Dùng final class', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q3 AND option_label = 'D');

-- q4
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q4, 'A', 'Abstract class không thể có constructor', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q4 AND option_label = 'A');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q4, 'B', 'Abstract class có thể chứa method thường và method abstract', TRUE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q4 AND option_label = 'B');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q4, 'C', 'Mọi method trong abstract class đều phải là private', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q4 AND option_label = 'C');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q4, 'D', 'Abstract class có thể được new trực tiếp', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q4 AND option_label = 'D');

-- q5
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q5, 'A', 'Set', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q5 AND option_label = 'A');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q5, 'B', 'List', TRUE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q5 AND option_label = 'B');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q5, 'C', 'Map', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q5 AND option_label = 'C');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q5, 'D', 'Queue', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q5 AND option_label = 'D');

-- q6
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q6, 'A', 'key-value', TRUE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q6 AND option_label = 'A');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q6, 'B', 'index-value', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q6 AND option_label = 'B');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q6, 'C', 'key-key', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q6 AND option_label = 'C');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q6, 'D', 'value-value', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q6 AND option_label = 'D');

-- q7
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q7, 'A', 'List', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q7 AND option_label = 'A');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q7, 'B', 'Set', TRUE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q7 AND option_label = 'B');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q7, 'C', 'Array', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q7 AND option_label = 'C');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q7, 'D', 'StringBuilder', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q7 AND option_label = 'D');

-- q8
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q8, 'A', 'HashSet', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q8 AND option_label = 'A');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q8, 'B', 'TreeSet', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q8 AND option_label = 'B');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q8, 'C', 'LinkedHashMap', TRUE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q8 AND option_label = 'C');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q8, 'D', 'PriorityQueue', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q8 AND option_label = 'D');

-- q9
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q9, 'A', 'Chia đôi mảng rồi đệ quy', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q9 AND option_label = 'A');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q9, 'B', 'So sánh các phần tử kề nhau và đổi chỗ nếu cần', TRUE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q9 AND option_label = 'B');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q9, 'C', 'Chọn pivot rồi partition', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q9 AND option_label = 'C');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q9, 'D', 'Duyệt từ giữa ra hai đầu', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q9 AND option_label = 'D');

-- q10
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q10, 'A', 'Mỗi vòng chọn phần tử nhỏ nhất của đoạn chưa sắp xếp', TRUE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q10 AND option_label = 'A');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q10, 'B', 'Luôn hoán đổi hai phần tử ngẫu nhiên', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q10 AND option_label = 'B');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q10, 'C', 'Chèn phần tử vào cây nhị phân', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q10 AND option_label = 'C');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q10, 'D', 'Đếm số lần xuất hiện của phần tử', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q10 AND option_label = 'D');

-- q11
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q11, 'A', 'Khi dữ liệu hoàn toàn đảo ngược và cực lớn', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q11 AND option_label = 'A');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q11, 'B', 'Khi dữ liệu nhỏ hoặc gần như đã có thứ tự', TRUE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q11 AND option_label = 'B');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q11, 'C', 'Khi luôn cần chia để trị', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q11 AND option_label = 'C');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q11, 'D', 'Khi chỉ được dùng hash table', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q11 AND option_label = 'D');

-- q12
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q12, 'A', 'O(log n)', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q12 AND option_label = 'A');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q12, 'B', 'O(n)', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q12 AND option_label = 'B');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q12, 'C', 'O(n^2)', TRUE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q12 AND option_label = 'C');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q12, 'D', 'O(1)', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q12 AND option_label = 'D');

-- q13
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q13, 'A', 'GROUP BY', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q13 AND option_label = 'A');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q13, 'B', 'WHERE', TRUE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q13 AND option_label = 'B');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q13, 'C', 'ORDER BY', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q13 AND option_label = 'C');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q13, 'D', 'LIMIT', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q13 AND option_label = 'D');

-- q14
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q14, 'A', 'Đếm số cột của bảng', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q14 AND option_label = 'A');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q14, 'B', 'Đếm số dòng', TRUE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q14 AND option_label = 'B');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q14, 'C', 'Xóa dữ liệu NULL', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q14 AND option_label = 'C');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q14, 'D', 'Tạo index tự động', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q14 AND option_label = 'D');

-- q15
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q15, 'A', 'Trả về tất cả bản ghi của bảng trái', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q15 AND option_label = 'A');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q15, 'B', 'Chỉ trả về các bản ghi khớp ở cả hai bảng', TRUE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q15 AND option_label = 'B');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q15, 'C', 'Luôn trả về số dòng gấp đôi', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q15 AND option_label = 'C');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q15, 'D', 'Chỉ dùng được với 1 bảng', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q15 AND option_label = 'D');

-- q16
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q16, 'A', 'Tăng tốc độ truy vấn', TRUE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q16 AND option_label = 'A');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q16, 'B', 'Mã hóa toàn bộ dữ liệu', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q16 AND option_label = 'B');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q16, 'C', 'Tự động backup', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q16 AND option_label = 'C');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q16, 'D', 'Xóa bản ghi trùng lặp', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q16 AND option_label = 'D');

-- q17
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q17, 'A', 'Đúng', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q17 AND option_label = 'A');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q17, 'B', 'Sai', TRUE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q17 AND option_label = 'B');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q17, 'C', 'Chỉ đúng với Java 17', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q17 AND option_label = 'C');
INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT @q17, 'D', 'Chỉ đúng với JVM đặc biệt', FALSE
    WHERE NOT EXISTS (SELECT 1 FROM answer_option WHERE question_id = @q17 AND option_label = 'D');

-- =========================================================
-- 6) QUIZ
-- =========================================================

INSERT INTO quiz (subject_id, topic_id, title, description, quiz_type, duration_minutes, total_questions, created_by, is_published, created_at, updated_at)
SELECT @java_subject_id, @oop_topic_id, 'Java OOP cơ bản - Quiz 1',
       'Bài luyện nhập môn OOP trong Java, phù hợp demo luồng làm bài thủ công.',
       'MANUAL', 15, 4, @admin_id, TRUE, '2026-03-23 09:00:00', '2026-03-23 09:00:00'
    WHERE NOT EXISTS (SELECT 1 FROM quiz WHERE title = 'Java OOP cơ bản - Quiz 1');

INSERT INTO quiz (subject_id, topic_id, title, description, quiz_type, duration_minutes, total_questions, created_by, is_published, created_at, updated_at)
SELECT @java_subject_id, @collection_topic_id, 'Java Collections - Quiz 1',
       'Bài luyện về List, Set, Map và lựa chọn cấu trúc dữ liệu phù hợp.',
       'MANUAL', 15, 4, @admin_id, TRUE, '2026-03-23 09:05:00', '2026-03-23 09:05:00'
    WHERE NOT EXISTS (SELECT 1 FROM quiz WHERE title = 'Java Collections - Quiz 1');

INSERT INTO quiz (subject_id, topic_id, title, description, quiz_type, duration_minutes, total_questions, created_by, is_published, created_at, updated_at)
SELECT @dsa_subject_id, @sort_topic_id, 'DSA Sorting Foundations',
       'Quiz về các thuật toán sắp xếp cơ bản và độ phức tạp.',
       'MANUAL', 20, 4, @admin_id, TRUE, '2026-03-23 09:10:00', '2026-03-23 09:10:00'
    WHERE NOT EXISTS (SELECT 1 FROM quiz WHERE title = 'DSA Sorting Foundations');

INSERT INTO quiz (subject_id, topic_id, title, description, quiz_type, duration_minutes, total_questions, created_by, is_published, created_at, updated_at)
SELECT @db_subject_id, @sql_topic_id, 'SQL Basics and Join',
       'Quiz về SQL cơ bản, COUNT, JOIN và INDEX.',
       'MANUAL', 20, 4, @admin_id, TRUE, '2026-03-23 09:15:00', '2026-03-23 09:15:00'
    WHERE NOT EXISTS (SELECT 1 FROM quiz WHERE title = 'SQL Basics and Join');

INSERT INTO quiz (subject_id, topic_id, title, description, quiz_type, duration_minutes, total_questions, created_by, is_published, created_at, updated_at)
SELECT @java_subject_id, NULL, 'Java Random Practice 10 câu',
       'Quiz random toàn môn Java để demo tạo đề ngẫu nhiên.',
       'RANDOM', 25, 10, @admin_id, TRUE, '2026-03-23 09:20:00', '2026-03-23 09:20:00'
    WHERE NOT EXISTS (SELECT 1 FROM quiz WHERE title = 'Java Random Practice 10 câu');

INSERT INTO quiz (subject_id, topic_id, title, description, quiz_type, duration_minutes, total_questions, created_by, is_published, created_at, updated_at)
SELECT @java_subject_id, @oop_topic_id, 'Quiz nháp - Chưa publish',
       'Quiz dùng để demo quản trị và trạng thái publish/unpublish.',
       'MANUAL', 10, 2, @admin_id, FALSE, '2026-03-23 09:25:00', '2026-03-23 09:25:00'
    WHERE NOT EXISTS (SELECT 1 FROM quiz WHERE title = 'Quiz nháp - Chưa publish');

SET @quiz_oop_id       = (SELECT quiz_id FROM quiz WHERE title = 'Java OOP cơ bản - Quiz 1' LIMIT 1);
SET @quiz_collection_id= (SELECT quiz_id FROM quiz WHERE title = 'Java Collections - Quiz 1' LIMIT 1);
SET @quiz_dsa_id       = (SELECT quiz_id FROM quiz WHERE title = 'DSA Sorting Foundations' LIMIT 1);
SET @quiz_sql_id       = (SELECT quiz_id FROM quiz WHERE title = 'SQL Basics and Join' LIMIT 1);
SET @quiz_draft_id     = (SELECT quiz_id FROM quiz WHERE title = 'Quiz nháp - Chưa publish' LIMIT 1);

-- =========================================================
-- 7) QUIZ QUESTION
-- =========================================================

INSERT INTO quiz_question (quiz_id, question_id, order_no, score_weight)
SELECT @quiz_oop_id, @q1, 1, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM quiz_question WHERE quiz_id = @quiz_oop_id AND question_id = @q1);
INSERT INTO quiz_question (quiz_id, question_id, order_no, score_weight)
SELECT @quiz_oop_id, @q2, 2, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM quiz_question WHERE quiz_id = @quiz_oop_id AND question_id = @q2);
INSERT INTO quiz_question (quiz_id, question_id, order_no, score_weight)
SELECT @quiz_oop_id, @q3, 3, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM quiz_question WHERE quiz_id = @quiz_oop_id AND question_id = @q3);
INSERT INTO quiz_question (quiz_id, question_id, order_no, score_weight)
SELECT @quiz_oop_id, @q4, 4, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM quiz_question WHERE quiz_id = @quiz_oop_id AND question_id = @q4);

INSERT INTO quiz_question (quiz_id, question_id, order_no, score_weight)
SELECT @quiz_collection_id, @q5, 1, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM quiz_question WHERE quiz_id = @quiz_collection_id AND question_id = @q5);
INSERT INTO quiz_question (quiz_id, question_id, order_no, score_weight)
SELECT @quiz_collection_id, @q6, 2, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM quiz_question WHERE quiz_id = @quiz_collection_id AND question_id = @q6);
INSERT INTO quiz_question (quiz_id, question_id, order_no, score_weight)
SELECT @quiz_collection_id, @q7, 3, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM quiz_question WHERE quiz_id = @quiz_collection_id AND question_id = @q7);
INSERT INTO quiz_question (quiz_id, question_id, order_no, score_weight)
SELECT @quiz_collection_id, @q8, 4, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM quiz_question WHERE quiz_id = @quiz_collection_id AND question_id = @q8);

INSERT INTO quiz_question (quiz_id, question_id, order_no, score_weight)
SELECT @quiz_dsa_id, @q9, 1, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM quiz_question WHERE quiz_id = @quiz_dsa_id AND question_id = @q9);
INSERT INTO quiz_question (quiz_id, question_id, order_no, score_weight)
SELECT @quiz_dsa_id, @q10, 2, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM quiz_question WHERE quiz_id = @quiz_dsa_id AND question_id = @q10);
INSERT INTO quiz_question (quiz_id, question_id, order_no, score_weight)
SELECT @quiz_dsa_id, @q11, 3, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM quiz_question WHERE quiz_id = @quiz_dsa_id AND question_id = @q11);
INSERT INTO quiz_question (quiz_id, question_id, order_no, score_weight)
SELECT @quiz_dsa_id, @q12, 4, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM quiz_question WHERE quiz_id = @quiz_dsa_id AND question_id = @q12);

INSERT INTO quiz_question (quiz_id, question_id, order_no, score_weight)
SELECT @quiz_sql_id, @q13, 1, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM quiz_question WHERE quiz_id = @quiz_sql_id AND question_id = @q13);
INSERT INTO quiz_question (quiz_id, question_id, order_no, score_weight)
SELECT @quiz_sql_id, @q14, 2, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM quiz_question WHERE quiz_id = @quiz_sql_id AND question_id = @q14);
INSERT INTO quiz_question (quiz_id, question_id, order_no, score_weight)
SELECT @quiz_sql_id, @q15, 3, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM quiz_question WHERE quiz_id = @quiz_sql_id AND question_id = @q15);
INSERT INTO quiz_question (quiz_id, question_id, order_no, score_weight)
SELECT @quiz_sql_id, @q16, 4, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM quiz_question WHERE quiz_id = @quiz_sql_id AND question_id = @q16);

INSERT INTO quiz_question (quiz_id, question_id, order_no, score_weight)
SELECT @quiz_draft_id, @q1, 1, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM quiz_question WHERE quiz_id = @quiz_draft_id AND question_id = @q1);
INSERT INTO quiz_question (quiz_id, question_id, order_no, score_weight)
SELECT @quiz_draft_id, @q17, 2, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM quiz_question WHERE quiz_id = @quiz_draft_id AND question_id = @q17);

-- =========================================================
-- 8) ATTEMPT
-- =========================================================

INSERT INTO attempt (user_id, quiz_id, started_at, submitted_at, total_score, correct_count, status, duration_seconds, total_questions)
SELECT @student_id, @quiz_oop_id, '2026-03-24 19:00:00', '2026-03-24 19:08:30', 3.00, 3, 'GRADED', 510, 4
    WHERE NOT EXISTS (
    SELECT 1 FROM attempt WHERE user_id = @student_id AND quiz_id = @quiz_oop_id AND started_at = '2026-03-24 19:00:00'
);

INSERT INTO attempt (user_id, quiz_id, started_at, submitted_at, total_score, correct_count, status, duration_seconds, total_questions)
SELECT @student_id, @quiz_dsa_id, '2026-03-25 20:00:00', '2026-03-25 20:12:00', 2.00, 2, 'GRADED', 720, 4
    WHERE NOT EXISTS (
    SELECT 1 FROM attempt WHERE user_id = @student_id AND quiz_id = @quiz_dsa_id AND started_at = '2026-03-25 20:00:00'
);

INSERT INTO attempt (user_id, quiz_id, started_at, submitted_at, total_score, correct_count, status, duration_seconds, total_questions)
SELECT @student_id, @quiz_sql_id, '2026-03-26 21:00:00', NULL, 0.00, 0, 'IN_PROGRESS', 420, 4
    WHERE NOT EXISTS (
    SELECT 1 FROM attempt WHERE user_id = @student_id AND quiz_id = @quiz_sql_id AND started_at = '2026-03-26 21:00:00'
);

INSERT INTO attempt (user_id, quiz_id, started_at, submitted_at, total_score, correct_count, status, duration_seconds, total_questions)
SELECT @minhanh_id, @quiz_collection_id, '2026-03-24 18:30:00', '2026-03-24 18:37:00', 4.00, 4, 'GRADED', 420, 4
    WHERE NOT EXISTS (
    SELECT 1 FROM attempt WHERE user_id = @minhanh_id AND quiz_id = @quiz_collection_id AND started_at = '2026-03-24 18:30:00'
);

INSERT INTO attempt (user_id, quiz_id, started_at, submitted_at, total_score, correct_count, status, duration_seconds, total_questions)
SELECT @hoangnam_id, @quiz_sql_id, '2026-03-25 21:30:00', '2026-03-25 21:45:00', 1.00, 1, 'GRADED', 900, 4
    WHERE NOT EXISTS (
    SELECT 1 FROM attempt WHERE user_id = @hoangnam_id AND quiz_id = @quiz_sql_id AND started_at = '2026-03-25 21:30:00'
);

INSERT INTO attempt (user_id, quiz_id, started_at, submitted_at, total_score, correct_count, status, duration_seconds, total_questions)
SELECT @thuha_id, @quiz_oop_id, '2026-03-26 18:00:00', '2026-03-26 18:06:00', 4.00, 4, 'GRADED', 360, 4
    WHERE NOT EXISTS (
    SELECT 1 FROM attempt WHERE user_id = @thuha_id AND quiz_id = @quiz_oop_id AND started_at = '2026-03-26 18:00:00'
);

SET @attempt_student_oop  = (SELECT attempt_id FROM attempt WHERE user_id = @student_id  AND quiz_id = @quiz_oop_id        AND started_at = '2026-03-24 19:00:00' LIMIT 1);
SET @attempt_student_dsa  = (SELECT attempt_id FROM attempt WHERE user_id = @student_id  AND quiz_id = @quiz_dsa_id        AND started_at = '2026-03-25 20:00:00' LIMIT 1);
SET @attempt_student_sql  = (SELECT attempt_id FROM attempt WHERE user_id = @student_id  AND quiz_id = @quiz_sql_id        AND started_at = '2026-03-26 21:00:00' LIMIT 1);
SET @attempt_minhanh_col  = (SELECT attempt_id FROM attempt WHERE user_id = @minhanh_id  AND quiz_id = @quiz_collection_id AND started_at = '2026-03-24 18:30:00' LIMIT 1);
SET @attempt_hoangnam_sql = (SELECT attempt_id FROM attempt WHERE user_id = @hoangnam_id AND quiz_id = @quiz_sql_id        AND started_at = '2026-03-25 21:30:00' LIMIT 1);
SET @attempt_thuha_oop    = (SELECT attempt_id FROM attempt WHERE user_id = @thuha_id    AND quiz_id = @quiz_oop_id        AND started_at = '2026-03-26 18:00:00' LIMIT 1);

-- =========================================================
-- 9) ATTEMPT QUESTION
-- =========================================================

-- helper insert block
INSERT INTO attempt_question (attempt_id, question_id, order_no, score_weight)
SELECT @attempt_student_oop, @q1, 1, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM attempt_question WHERE attempt_id = @attempt_student_oop AND question_id = @q1);
INSERT INTO attempt_question (attempt_id, question_id, order_no, score_weight)
SELECT @attempt_student_oop, @q2, 2, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM attempt_question WHERE attempt_id = @attempt_student_oop AND question_id = @q2);
INSERT INTO attempt_question (attempt_id, question_id, order_no, score_weight)
SELECT @attempt_student_oop, @q3, 3, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM attempt_question WHERE attempt_id = @attempt_student_oop AND question_id = @q3);
INSERT INTO attempt_question (attempt_id, question_id, order_no, score_weight)
SELECT @attempt_student_oop, @q4, 4, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM attempt_question WHERE attempt_id = @attempt_student_oop AND question_id = @q4);

INSERT INTO attempt_question (attempt_id, question_id, order_no, score_weight)
SELECT @attempt_student_dsa, @q9, 1, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM attempt_question WHERE attempt_id = @attempt_student_dsa AND question_id = @q9);
INSERT INTO attempt_question (attempt_id, question_id, order_no, score_weight)
SELECT @attempt_student_dsa, @q10, 2, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM attempt_question WHERE attempt_id = @attempt_student_dsa AND question_id = @q10);
INSERT INTO attempt_question (attempt_id, question_id, order_no, score_weight)
SELECT @attempt_student_dsa, @q11, 3, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM attempt_question WHERE attempt_id = @attempt_student_dsa AND question_id = @q11);
INSERT INTO attempt_question (attempt_id, question_id, order_no, score_weight)
SELECT @attempt_student_dsa, @q12, 4, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM attempt_question WHERE attempt_id = @attempt_student_dsa AND question_id = @q12);

INSERT INTO attempt_question (attempt_id, question_id, order_no, score_weight)
SELECT @attempt_student_sql, @q13, 1, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM attempt_question WHERE attempt_id = @attempt_student_sql AND question_id = @q13);
INSERT INTO attempt_question (attempt_id, question_id, order_no, score_weight)
SELECT @attempt_student_sql, @q14, 2, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM attempt_question WHERE attempt_id = @attempt_student_sql AND question_id = @q14);
INSERT INTO attempt_question (attempt_id, question_id, order_no, score_weight)
SELECT @attempt_student_sql, @q15, 3, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM attempt_question WHERE attempt_id = @attempt_student_sql AND question_id = @q15);
INSERT INTO attempt_question (attempt_id, question_id, order_no, score_weight)
SELECT @attempt_student_sql, @q16, 4, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM attempt_question WHERE attempt_id = @attempt_student_sql AND question_id = @q16);

INSERT INTO attempt_question (attempt_id, question_id, order_no, score_weight)
SELECT @attempt_minhanh_col, @q5, 1, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM attempt_question WHERE attempt_id = @attempt_minhanh_col AND question_id = @q5);
INSERT INTO attempt_question (attempt_id, question_id, order_no, score_weight)
SELECT @attempt_minhanh_col, @q6, 2, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM attempt_question WHERE attempt_id = @attempt_minhanh_col AND question_id = @q6);
INSERT INTO attempt_question (attempt_id, question_id, order_no, score_weight)
SELECT @attempt_minhanh_col, @q7, 3, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM attempt_question WHERE attempt_id = @attempt_minhanh_col AND question_id = @q7);
INSERT INTO attempt_question (attempt_id, question_id, order_no, score_weight)
SELECT @attempt_minhanh_col, @q8, 4, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM attempt_question WHERE attempt_id = @attempt_minhanh_col AND question_id = @q8);

INSERT INTO attempt_question (attempt_id, question_id, order_no, score_weight)
SELECT @attempt_hoangnam_sql, @q13, 1, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM attempt_question WHERE attempt_id = @attempt_hoangnam_sql AND question_id = @q13);
INSERT INTO attempt_question (attempt_id, question_id, order_no, score_weight)
SELECT @attempt_hoangnam_sql, @q14, 2, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM attempt_question WHERE attempt_id = @attempt_hoangnam_sql AND question_id = @q14);
INSERT INTO attempt_question (attempt_id, question_id, order_no, score_weight)
SELECT @attempt_hoangnam_sql, @q15, 3, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM attempt_question WHERE attempt_id = @attempt_hoangnam_sql AND question_id = @q15);
INSERT INTO attempt_question (attempt_id, question_id, order_no, score_weight)
SELECT @attempt_hoangnam_sql, @q16, 4, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM attempt_question WHERE attempt_id = @attempt_hoangnam_sql AND question_id = @q16);

INSERT INTO attempt_question (attempt_id, question_id, order_no, score_weight)
SELECT @attempt_thuha_oop, @q1, 1, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM attempt_question WHERE attempt_id = @attempt_thuha_oop AND question_id = @q1);
INSERT INTO attempt_question (attempt_id, question_id, order_no, score_weight)
SELECT @attempt_thuha_oop, @q2, 2, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM attempt_question WHERE attempt_id = @attempt_thuha_oop AND question_id = @q2);
INSERT INTO attempt_question (attempt_id, question_id, order_no, score_weight)
SELECT @attempt_thuha_oop, @q3, 3, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM attempt_question WHERE attempt_id = @attempt_thuha_oop AND question_id = @q3);
INSERT INTO attempt_question (attempt_id, question_id, order_no, score_weight)
SELECT @attempt_thuha_oop, @q4, 4, 1.00
    WHERE NOT EXISTS (SELECT 1 FROM attempt_question WHERE attempt_id = @attempt_thuha_oop AND question_id = @q4);

-- =========================================================
-- 10) ATTEMPT ANSWER
-- =========================================================

SET @q1_true  = (SELECT option_id FROM answer_option WHERE question_id = @q1  AND is_correct = TRUE  LIMIT 1);
SET @q2_true  = (SELECT option_id FROM answer_option WHERE question_id = @q2  AND is_correct = TRUE  LIMIT 1);
SET @q3_true  = (SELECT option_id FROM answer_option WHERE question_id = @q3  AND is_correct = TRUE  LIMIT 1);
SET @q3_wrong = (SELECT option_id FROM answer_option WHERE question_id = @q3  AND option_label = 'A' LIMIT 1);
SET @q4_true  = (SELECT option_id FROM answer_option WHERE question_id = @q4  AND is_correct = TRUE  LIMIT 1);
SET @q5_true  = (SELECT option_id FROM answer_option WHERE question_id = @q5  AND is_correct = TRUE  LIMIT 1);
SET @q6_true  = (SELECT option_id FROM answer_option WHERE question_id = @q6  AND is_correct = TRUE  LIMIT 1);
SET @q7_true  = (SELECT option_id FROM answer_option WHERE question_id = @q7  AND is_correct = TRUE  LIMIT 1);
SET @q8_true  = (SELECT option_id FROM answer_option WHERE question_id = @q8  AND is_correct = TRUE  LIMIT 1);
SET @q9_true  = (SELECT option_id FROM answer_option WHERE question_id = @q9  AND is_correct = TRUE  LIMIT 1);
SET @q10_wrong= (SELECT option_id FROM answer_option WHERE question_id = @q10 AND option_label = 'D' LIMIT 1);
SET @q11_true = (SELECT option_id FROM answer_option WHERE question_id = @q11 AND is_correct = TRUE  LIMIT 1);
SET @q12_wrong= (SELECT option_id FROM answer_option WHERE question_id = @q12 AND option_label = 'B' LIMIT 1);
SET @q13_true = (SELECT option_id FROM answer_option WHERE question_id = @q13 AND is_correct = TRUE  LIMIT 1);
SET @q13_wrong= (SELECT option_id FROM answer_option WHERE question_id = @q13 AND option_label = 'C' LIMIT 1);
SET @q14_true = (SELECT option_id FROM answer_option WHERE question_id = @q14 AND is_correct = TRUE  LIMIT 1);
SET @q14_wrong= (SELECT option_id FROM answer_option WHERE question_id = @q14 AND option_label = 'A' LIMIT 1);
SET @q15_wrong= (SELECT option_id FROM answer_option WHERE question_id = @q15 AND option_label = 'A' LIMIT 1);
SET @q16_wrong= (SELECT option_id FROM answer_option WHERE question_id = @q16 AND option_label = 'D' LIMIT 1);

-- student oop 3/4
INSERT INTO attempt_answer (attempt_question_id, selected_option_id, is_correct, score_obtained, answered_at)
SELECT aq.attempt_question_id, @q1_true, TRUE, 1.00, '2026-03-24 19:02:00'
FROM attempt_question aq
WHERE aq.attempt_id = @attempt_student_oop AND aq.question_id = @q1
  AND NOT EXISTS (SELECT 1 FROM attempt_answer WHERE attempt_question_id = aq.attempt_question_id);

INSERT INTO attempt_answer (attempt_question_id, selected_option_id, is_correct, score_obtained, answered_at)
SELECT aq.attempt_question_id, @q2_true, TRUE, 1.00, '2026-03-24 19:03:00'
FROM attempt_question aq
WHERE aq.attempt_id = @attempt_student_oop AND aq.question_id = @q2
  AND NOT EXISTS (SELECT 1 FROM attempt_answer WHERE attempt_question_id = aq.attempt_question_id);

INSERT INTO attempt_answer (attempt_question_id, selected_option_id, is_correct, score_obtained, answered_at)
SELECT aq.attempt_question_id, @q3_wrong, FALSE, 0.00, '2026-03-24 19:05:00'
FROM attempt_question aq
WHERE aq.attempt_id = @attempt_student_oop AND aq.question_id = @q3
  AND NOT EXISTS (SELECT 1 FROM attempt_answer WHERE attempt_question_id = aq.attempt_question_id);

INSERT INTO attempt_answer (attempt_question_id, selected_option_id, is_correct, score_obtained, answered_at)
SELECT aq.attempt_question_id, @q4_true, TRUE, 1.00, '2026-03-24 19:07:00'
FROM attempt_question aq
WHERE aq.attempt_id = @attempt_student_oop AND aq.question_id = @q4
  AND NOT EXISTS (SELECT 1 FROM attempt_answer WHERE attempt_question_id = aq.attempt_question_id);

-- student dsa 2/4
INSERT INTO attempt_answer (attempt_question_id, selected_option_id, is_correct, score_obtained, answered_at)
SELECT aq.attempt_question_id, @q9_true, TRUE, 1.00, '2026-03-25 20:02:00'
FROM attempt_question aq
WHERE aq.attempt_id = @attempt_student_dsa AND aq.question_id = @q9
  AND NOT EXISTS (SELECT 1 FROM attempt_answer WHERE attempt_question_id = aq.attempt_question_id);

INSERT INTO attempt_answer (attempt_question_id, selected_option_id, is_correct, score_obtained, answered_at)
SELECT aq.attempt_question_id, @q10_wrong, FALSE, 0.00, '2026-03-25 20:04:00'
FROM attempt_question aq
WHERE aq.attempt_id = @attempt_student_dsa AND aq.question_id = @q10
  AND NOT EXISTS (SELECT 1 FROM attempt_answer WHERE attempt_question_id = aq.attempt_question_id);

INSERT INTO attempt_answer (attempt_question_id, selected_option_id, is_correct, score_obtained, answered_at)
SELECT aq.attempt_question_id, @q11_true, TRUE, 1.00, '2026-03-25 20:07:00'
FROM attempt_question aq
WHERE aq.attempt_id = @attempt_student_dsa AND aq.question_id = @q11
  AND NOT EXISTS (SELECT 1 FROM attempt_answer WHERE attempt_question_id = aq.attempt_question_id);

INSERT INTO attempt_answer (attempt_question_id, selected_option_id, is_correct, score_obtained, answered_at)
SELECT aq.attempt_question_id, @q12_wrong, FALSE, 0.00, '2026-03-25 20:10:00'
FROM attempt_question aq
WHERE aq.attempt_id = @attempt_student_dsa AND aq.question_id = @q12
  AND NOT EXISTS (SELECT 1 FROM attempt_answer WHERE attempt_question_id = aq.attempt_question_id);

-- student sql in progress 2 answered
INSERT INTO attempt_answer (attempt_question_id, selected_option_id, is_correct, score_obtained, answered_at)
SELECT aq.attempt_question_id, @q13_true, TRUE, 1.00, '2026-03-26 21:03:00'
FROM attempt_question aq
WHERE aq.attempt_id = @attempt_student_sql AND aq.question_id = @q13
  AND NOT EXISTS (SELECT 1 FROM attempt_answer WHERE attempt_question_id = aq.attempt_question_id);

INSERT INTO attempt_answer (attempt_question_id, selected_option_id, is_correct, score_obtained, answered_at)
SELECT aq.attempt_question_id, @q14_wrong, FALSE, 0.00, '2026-03-26 21:05:00'
FROM attempt_question aq
WHERE aq.attempt_id = @attempt_student_sql AND aq.question_id = @q14
  AND NOT EXISTS (SELECT 1 FROM attempt_answer WHERE attempt_question_id = aq.attempt_question_id);

-- minhanh all correct
INSERT INTO attempt_answer (attempt_question_id, selected_option_id, is_correct, score_obtained, answered_at)
SELECT aq.attempt_question_id,
       (SELECT option_id FROM answer_option WHERE question_id = aq.question_id AND is_correct = TRUE LIMIT 1),
       TRUE, 1.00, '2026-03-24 18:31:00'
FROM attempt_question aq
WHERE aq.attempt_id = @attempt_minhanh_col
  AND NOT EXISTS (SELECT 1 FROM attempt_answer WHERE attempt_question_id = aq.attempt_question_id);

-- hoangnam only 1 correct
INSERT INTO attempt_answer (attempt_question_id, selected_option_id, is_correct, score_obtained, answered_at)
SELECT aq.attempt_question_id,
       CASE
           WHEN aq.question_id = @q13 THEN @q13_wrong
           WHEN aq.question_id = @q14 THEN @q14_true
           WHEN aq.question_id = @q15 THEN @q15_wrong
           WHEN aq.question_id = @q16 THEN @q16_wrong
           END,
       CASE WHEN aq.question_id = @q14 THEN TRUE ELSE FALSE END,
       CASE WHEN aq.question_id = @q14 THEN 1.00 ELSE 0.00 END,
       '2026-03-25 21:35:00'
FROM attempt_question aq
WHERE aq.attempt_id = @attempt_hoangnam_sql
  AND NOT EXISTS (SELECT 1 FROM attempt_answer WHERE attempt_question_id = aq.attempt_question_id);

-- thuha all correct
INSERT INTO attempt_answer (attempt_question_id, selected_option_id, is_correct, score_obtained, answered_at)
SELECT aq.attempt_question_id,
       (SELECT option_id FROM answer_option WHERE question_id = aq.question_id AND is_correct = TRUE LIMIT 1),
       TRUE, 1.00, '2026-03-26 18:02:00'
FROM attempt_question aq
WHERE aq.attempt_id = @attempt_thuha_oop
  AND NOT EXISTS (SELECT 1 FROM attempt_answer WHERE attempt_question_id = aq.attempt_question_id);

-- =========================================================
-- 11) LEARNING PROGRESS
-- =========================================================

INSERT INTO learning_progress (user_id, topic_id, total_quizzes, completed_quizzes, progress_percentage, total_attempts, correct_rate, mastery_score, last_practiced_at, updated_at)
SELECT @student_id, @oop_topic_id, 1, 1, 75.00, 1, 75.00, 7.50, '2026-03-24 19:08:30', '2026-03-24 19:08:30'
    WHERE NOT EXISTS (SELECT 1 FROM learning_progress WHERE user_id = @student_id AND topic_id = @oop_topic_id);

INSERT INTO learning_progress (user_id, topic_id, total_quizzes, completed_quizzes, progress_percentage, total_attempts, correct_rate, mastery_score, last_practiced_at, updated_at)
SELECT @student_id, @sort_topic_id, 1, 1, 50.00, 1, 50.00, 5.00, '2026-03-25 20:12:00', '2026-03-25 20:12:00'
    WHERE NOT EXISTS (SELECT 1 FROM learning_progress WHERE user_id = @student_id AND topic_id = @sort_topic_id);

INSERT INTO learning_progress (user_id, topic_id, total_quizzes, completed_quizzes, progress_percentage, total_attempts, correct_rate, mastery_score, last_practiced_at, updated_at)
SELECT @minhanh_id, @collection_topic_id, 1, 1, 100.00, 1, 100.00, 9.80, '2026-03-24 18:37:00', '2026-03-24 18:37:00'
    WHERE NOT EXISTS (SELECT 1 FROM learning_progress WHERE user_id = @minhanh_id AND topic_id = @collection_topic_id);

INSERT INTO learning_progress (user_id, topic_id, total_quizzes, completed_quizzes, progress_percentage, total_attempts, correct_rate, mastery_score, last_practiced_at, updated_at)
SELECT @hoangnam_id, @sql_topic_id, 1, 1, 25.00, 1, 25.00, 2.50, '2026-03-25 21:45:00', '2026-03-25 21:45:00'
    WHERE NOT EXISTS (SELECT 1 FROM learning_progress WHERE user_id = @hoangnam_id AND topic_id = @sql_topic_id);

INSERT INTO learning_progress (user_id, topic_id, total_quizzes, completed_quizzes, progress_percentage, total_attempts, correct_rate, mastery_score, last_practiced_at, updated_at)
SELECT @thuha_id, @oop_topic_id, 1, 1, 100.00, 1, 100.00, 10.00, '2026-03-26 18:06:00', '2026-03-26 18:06:00'
    WHERE NOT EXISTS (SELECT 1 FROM learning_progress WHERE user_id = @thuha_id AND topic_id = @oop_topic_id);

-- =========================================================
-- 12) USER QUESTION MEMORY
-- =========================================================

INSERT INTO user_question_memory (user_id, question_id, last_result, correct_streak, wrong_streak, review_count, memory_score, last_reviewed_at, next_review_at, created_at, updated_at)
SELECT @student_id, @q1, TRUE, 2, 0, 3, 8.50, '2026-03-24 19:08:30', '2026-03-30 08:00:00', '2026-03-24 19:08:30', '2026-03-24 19:08:30'
    WHERE NOT EXISTS (SELECT 1 FROM user_question_memory WHERE user_id = @student_id AND question_id = @q1);

INSERT INTO user_question_memory (user_id, question_id, last_result, correct_streak, wrong_streak, review_count, memory_score, last_reviewed_at, next_review_at, created_at, updated_at)
SELECT @student_id, @q3, FALSE, 0, 2, 3, 3.20, '2026-03-24 19:08:30', '2026-03-27 08:00:00', '2026-03-24 19:08:30', '2026-03-24 19:08:30'
    WHERE NOT EXISTS (SELECT 1 FROM user_question_memory WHERE user_id = @student_id AND question_id = @q3);

INSERT INTO user_question_memory (user_id, question_id, last_result, correct_streak, wrong_streak, review_count, memory_score, last_reviewed_at, next_review_at, created_at, updated_at)
SELECT @student_id, @q4, TRUE, 1, 0, 2, 7.00, '2026-03-24 19:08:30', '2026-03-29 08:00:00', '2026-03-24 19:08:30', '2026-03-24 19:08:30'
    WHERE NOT EXISTS (SELECT 1 FROM user_question_memory WHERE user_id = @student_id AND question_id = @q4);

INSERT INTO user_question_memory (user_id, question_id, last_result, correct_streak, wrong_streak, review_count, memory_score, last_reviewed_at, next_review_at, created_at, updated_at)
SELECT @student_id, @q10, FALSE, 0, 3, 4, 2.50, '2026-03-25 20:12:00', '2026-03-26 09:00:00', '2026-03-25 20:12:00', '2026-03-25 20:12:00'
    WHERE NOT EXISTS (SELECT 1 FROM user_question_memory WHERE user_id = @student_id AND question_id = @q10);

INSERT INTO user_question_memory (user_id, question_id, last_result, correct_streak, wrong_streak, review_count, memory_score, last_reviewed_at, next_review_at, created_at, updated_at)
SELECT @student_id, @q12, FALSE, 0, 2, 4, 3.00, '2026-03-25 20:12:00', '2026-03-26 10:00:00', '2026-03-25 20:12:00', '2026-03-25 20:12:00'
    WHERE NOT EXISTS (SELECT 1 FROM user_question_memory WHERE user_id = @student_id AND question_id = @q12);

INSERT INTO user_question_memory (user_id, question_id, last_result, correct_streak, wrong_streak, review_count, memory_score, last_reviewed_at, next_review_at, created_at, updated_at)
SELECT @minhanh_id, @q6, TRUE, 4, 0, 4, 9.70, '2026-03-24 18:37:00', '2026-04-05 08:00:00', '2026-03-24 18:37:00', '2026-03-24 18:37:00'
    WHERE NOT EXISTS (SELECT 1 FROM user_question_memory WHERE user_id = @minhanh_id AND question_id = @q6);

INSERT INTO user_question_memory (user_id, question_id, last_result, correct_streak, wrong_streak, review_count, memory_score, last_reviewed_at, next_review_at, created_at, updated_at)
SELECT @hoangnam_id, @q15, FALSE, 0, 4, 5, 1.80, '2026-03-25 21:45:00', '2026-03-26 07:00:00', '2026-03-25 21:45:00', '2026-03-25 21:45:00'
    WHERE NOT EXISTS (SELECT 1 FROM user_question_memory WHERE user_id = @hoangnam_id AND question_id = @q15);

-- =========================================================
-- 13) USER QUIZ PROGRESS
-- highest_score phải <= 1 theo CHECK
-- =========================================================

INSERT INTO user_quiz_progress (user_id, quiz_id, topic_id, highest_score, total_attempts, last_attempt_at)
SELECT @student_id, @quiz_oop_id, @oop_topic_id, 0.75, 1, '2026-03-24 19:08:30'
    WHERE NOT EXISTS (SELECT 1 FROM user_quiz_progress WHERE user_id = @student_id AND quiz_id = @quiz_oop_id);

INSERT INTO user_quiz_progress (user_id, quiz_id, topic_id, highest_score, total_attempts, last_attempt_at)
SELECT @student_id, @quiz_dsa_id, @sort_topic_id, 0.50, 1, '2026-03-25 20:12:00'
    WHERE NOT EXISTS (SELECT 1 FROM user_quiz_progress WHERE user_id = @student_id AND quiz_id = @quiz_dsa_id);

INSERT INTO user_quiz_progress (user_id, quiz_id, topic_id, highest_score, total_attempts, last_attempt_at)
SELECT @minhanh_id, @quiz_collection_id, @collection_topic_id, 1.00, 1, '2026-03-24 18:37:00'
    WHERE NOT EXISTS (SELECT 1 FROM user_quiz_progress WHERE user_id = @minhanh_id AND quiz_id = @quiz_collection_id);

INSERT INTO user_quiz_progress (user_id, quiz_id, topic_id, highest_score, total_attempts, last_attempt_at)
SELECT @hoangnam_id, @quiz_sql_id, @sql_topic_id, 0.25, 1, '2026-03-25 21:45:00'
    WHERE NOT EXISTS (SELECT 1 FROM user_quiz_progress WHERE user_id = @hoangnam_id AND quiz_id = @quiz_sql_id);

INSERT INTO user_quiz_progress (user_id, quiz_id, topic_id, highest_score, total_attempts, last_attempt_at)
SELECT @thuha_id, @quiz_oop_id, @oop_topic_id, 1.00, 1, '2026-03-26 18:06:00'
    WHERE NOT EXISTS (SELECT 1 FROM user_quiz_progress WHERE user_id = @thuha_id AND quiz_id = @quiz_oop_id);

-- =========================================================
-- 14) QUESTION POST
-- =========================================================

INSERT INTO question_post (user_id, topic_id, title, content, status, view_count, like_count, comment_count, theme_color, created_at, updated_at)
SELECT @student_id, @oop_topic_id,
       'Phân biệt abstract class và interface trong Java như thế nào?',
       'Mình đang hơi rối giữa abstract class và interface. Trong bài toán thực tế thì khi nào nên chọn abstract class, khi nào nên chọn interface?',
       'VISIBLE', 125, 0, 0, '#E8F0FE', '2026-03-27 09:00:00', '2026-03-27 09:00:00'
    WHERE NOT EXISTS (SELECT 1 FROM question_post WHERE title = 'Phân biệt abstract class và interface trong Java như thế nào?');

INSERT INTO question_post (user_id, topic_id, title, content, status, view_count, like_count, comment_count, theme_color, created_at, updated_at)
SELECT @minhanh_id, @collection_topic_id,
       'Vì sao HashMap không đảm bảo thứ tự phần tử?',
       'Mình thấy duyệt HashMap mỗi lần có thể ra thứ tự khác nhau. Cơ chế bên trong của nó là gì và khi nào nên dùng LinkedHashMap?',
       'VISIBLE', 98, 0, 0, '#FFF4E5', '2026-03-27 10:00:00', '2026-03-27 10:00:00'
    WHERE NOT EXISTS (SELECT 1 FROM question_post WHERE title = 'Vì sao HashMap không đảm bảo thứ tự phần tử?');

INSERT INTO question_post (user_id, topic_id, title, content, status, view_count, like_count, comment_count, theme_color, created_at, updated_at)
SELECT @hoangnam_id, @sort_topic_id,
       'Bubble Sort với Insertion Sort nên chọn cái nào khi mảng gần như có thứ tự?',
       'Nếu dữ liệu gần như đã được sắp xếp rồi thì nên dùng Bubble Sort hay Insertion Sort? Mong mọi người giải thích theo trực giác.',
       'VISIBLE', 76, 0, 0, '#EAFBF1', '2026-03-27 11:00:00', '2026-03-27 11:00:00'
    WHERE NOT EXISTS (SELECT 1 FROM question_post WHERE title = 'Bubble Sort với Insertion Sort nên chọn cái nào khi mảng gần như có thứ tự?');

INSERT INTO question_post (user_id, topic_id, title, content, status, view_count, like_count, comment_count, theme_color, created_at, updated_at)
SELECT @thuha_id, @join_topic_id,
       'INNER JOIN khác LEFT JOIN ở trường hợp nào dễ thấy nhất?',
       'Ai có thể cho mình một ví dụ ngắn dễ nhớ để phân biệt INNER JOIN và LEFT JOIN không? Mình đọc lý thuyết rồi mà vẫn hay lẫn.',
       'VISIBLE', 143, 0, 0, '#F5EFFF', '2026-03-27 12:00:00', '2026-03-27 12:00:00'
    WHERE NOT EXISTS (SELECT 1 FROM question_post WHERE title = 'INNER JOIN khác LEFT JOIN ở trường hợp nào dễ thấy nhất?');

INSERT INTO question_post (user_id, topic_id, title, content, status, view_count, like_count, comment_count, theme_color, created_at, updated_at)
SELECT @student_id, @oop_topic_id,
       'Post vi phạm để demo moderation',
       'Nội dung này được tạo ra chỉ để demo chức năng ẩn/khôi phục/xóa trong khu vực quản trị.',
       'HIDDEN', 12, 0, 0, '#FFECEC', '2026-03-27 13:00:00', '2026-03-27 13:15:00'
    WHERE NOT EXISTS (SELECT 1 FROM question_post WHERE title = 'Post vi phạm để demo moderation');

SET @post1 = (SELECT question_post_id FROM question_post WHERE title = 'Phân biệt abstract class và interface trong Java như thế nào?' LIMIT 1);
SET @post2 = (SELECT question_post_id FROM question_post WHERE title = 'Vì sao HashMap không đảm bảo thứ tự phần tử?' LIMIT 1);
SET @post3 = (SELECT question_post_id FROM question_post WHERE title = 'Bubble Sort với Insertion Sort nên chọn cái nào khi mảng gần như có thứ tự?' LIMIT 1);
SET @post4 = (SELECT question_post_id FROM question_post WHERE title = 'INNER JOIN khác LEFT JOIN ở trường hợp nào dễ thấy nhất?' LIMIT 1);
SET @post5 = (SELECT question_post_id FROM question_post WHERE title = 'Post vi phạm để demo moderation' LIMIT 1);

-- =========================================================
-- 15) COMMENT
-- =========================================================

INSERT INTO comment (question_post_id, user_id, parent_id, content, status, created_at, updated_at)
SELECT @post1, @minhanh_id, NULL,
       'Interface phù hợp khi bạn muốn mô tả capability chung cho nhiều class không cùng hệ kế thừa.',
       'VISIBLE', '2026-03-27 09:15:00', '2026-03-27 09:15:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM comment WHERE question_post_id = @post1 AND user_id = @minhanh_id AND parent_id IS NULL
      AND content = 'Interface phù hợp khi bạn muốn mô tả capability chung cho nhiều class không cùng hệ kế thừa.'
);

INSERT INTO comment (question_post_id, user_id, parent_id, content, status, created_at, updated_at)
SELECT @post1, @thuha_id, NULL,
       'Abstract class hợp khi bạn muốn tái sử dụng code chung và vẫn giữ một số phần bắt buộc subclass phải override.',
       'VISIBLE', '2026-03-27 09:20:00', '2026-03-27 09:20:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM comment WHERE question_post_id = @post1 AND user_id = @thuha_id AND parent_id IS NULL
      AND content = 'Abstract class hợp khi bạn muốn tái sử dụng code chung và vẫn giữ một số phần bắt buộc subclass phải override.'
);

SET @parent_comment_1 = (
    SELECT comment_id FROM comment
    WHERE question_post_id = @post1
      AND content = 'Interface phù hợp khi bạn muốn mô tả capability chung cho nhiều class không cùng hệ kế thừa.'
    LIMIT 1
);

INSERT INTO comment (question_post_id, user_id, parent_id, content, status, created_at, updated_at)
SELECT @post1, @student_id, @parent_comment_1,
       'Ví dụ này dễ hiểu quá, cảm ơn bạn. Mình sẽ thử nhớ theo hướng capability vs base implementation.',
       'VISIBLE', '2026-03-27 09:25:00', '2026-03-27 09:25:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM comment WHERE question_post_id = @post1 AND user_id = @student_id AND parent_id = @parent_comment_1
      AND content = 'Ví dụ này dễ hiểu quá, cảm ơn bạn. Mình sẽ thử nhớ theo hướng capability vs base implementation.'
);

INSERT INTO comment (question_post_id, user_id, parent_id, content, status, created_at, updated_at)
SELECT @post2, @student_id, NULL,
       'HashMap ưu tiên hiệu năng tra cứu theo hash, còn LinkedHashMap thêm linked list để giữ thứ tự chèn.',
       'VISIBLE', '2026-03-27 10:10:00', '2026-03-27 10:10:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM comment WHERE question_post_id = @post2 AND user_id = @student_id AND parent_id IS NULL
      AND content = 'HashMap ưu tiên hiệu năng tra cứu theo hash, còn LinkedHashMap thêm linked list để giữ thứ tự chèn.'
);

INSERT INTO comment (question_post_id, user_id, parent_id, content, status, created_at, updated_at)
SELECT @post3, @thuha_id, NULL,
       'Nếu mảng gần như có thứ tự thì Insertion Sort thường hợp hơn vì số lần dịch chuyển ít.',
       'VISIBLE', '2026-03-27 11:12:00', '2026-03-27 11:12:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM comment WHERE question_post_id = @post3 AND user_id = @thuha_id AND parent_id IS NULL
      AND content = 'Nếu mảng gần như có thứ tự thì Insertion Sort thường hợp hơn vì số lần dịch chuyển ít.'
);

INSERT INTO comment (question_post_id, user_id, parent_id, content, status, created_at, updated_at)
SELECT @post4, @hoangnam_id, NULL,
       'INNER JOIN chỉ lấy các dòng khớp ở cả 2 bên, còn LEFT JOIN giữ toàn bộ bảng bên trái kể cả khi không khớp.',
       'VISIBLE', '2026-03-27 12:10:00', '2026-03-27 12:10:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM comment WHERE question_post_id = @post4 AND user_id = @hoangnam_id AND parent_id IS NULL
      AND content = 'INNER JOIN chỉ lấy các dòng khớp ở cả 2 bên, còn LEFT JOIN giữ toàn bộ bảng bên trái kể cả khi không khớp.'
);

INSERT INTO comment (question_post_id, user_id, parent_id, content, status, created_at, updated_at)
SELECT @post5, @hoangnam_id, NULL,
       'Comment này cũng dùng để demo moderation và hiện đang bị ẩn.',
       'HIDDEN', '2026-03-27 13:05:00', '2026-03-27 13:15:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM comment WHERE question_post_id = @post5 AND user_id = @hoangnam_id AND parent_id IS NULL
      AND content = 'Comment này cũng dùng để demo moderation và hiện đang bị ẩn.'
);

SET @hidden_comment_id = (
    SELECT comment_id FROM comment
    WHERE question_post_id = @post5
      AND content = 'Comment này cũng dùng để demo moderation và hiện đang bị ẩn.'
    LIMIT 1
);

-- =========================================================
-- 16) POST LIKES
-- =========================================================

INSERT INTO post_likes (user_id, post_id, created_at)
SELECT @minhanh_id, @post1, '2026-03-27 09:30:00'
    WHERE NOT EXISTS (SELECT 1 FROM post_likes WHERE user_id = @minhanh_id AND post_id = @post1);

INSERT INTO post_likes (user_id, post_id, created_at)
SELECT @thuha_id, @post1, '2026-03-27 09:31:00'
    WHERE NOT EXISTS (SELECT 1 FROM post_likes WHERE user_id = @thuha_id AND post_id = @post1);

INSERT INTO post_likes (user_id, post_id, created_at)
SELECT @student_id, @post2, '2026-03-27 10:20:00'
    WHERE NOT EXISTS (SELECT 1 FROM post_likes WHERE user_id = @student_id AND post_id = @post2);

INSERT INTO post_likes (user_id, post_id, created_at)
SELECT @minhanh_id, @post4, '2026-03-27 12:20:00'
    WHERE NOT EXISTS (SELECT 1 FROM post_likes WHERE user_id = @minhanh_id AND post_id = @post4);

INSERT INTO post_likes (user_id, post_id, created_at)
SELECT @student_id, @post4, '2026-03-27 12:21:00'
    WHERE NOT EXISTS (SELECT 1 FROM post_likes WHERE user_id = @student_id AND post_id = @post4);

-- =========================================================
-- 17) MODERATION RECORD
-- =========================================================

INSERT INTO moderation_record (moderator_id, target_type, target_id, action, reason, created_at)
SELECT @admin_id, 'QUESTION_POST', @post5, 'HIDE',
       'Ẩn bài để demo chức năng kiểm duyệt nội dung cộng đồng.', '2026-03-27 13:15:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM moderation_record WHERE target_type = 'QUESTION_POST' AND target_id = @post5 AND action = 'HIDE'
);

INSERT INTO moderation_record (moderator_id, target_type, target_id, action, reason, created_at)
SELECT @admin_id, 'COMMENT', @hidden_comment_id, 'HIDE',
       'Ẩn comment để demo moderation chi tiết theo bình luận.', '2026-03-27 13:16:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM moderation_record WHERE target_type = 'COMMENT' AND target_id = @hidden_comment_id AND action = 'HIDE'
);

INSERT INTO moderation_record (moderator_id, target_type, target_id, action, reason, created_at)
SELECT @admin_id, 'QUESTION', @q17, 'HIDE',
       'Ẩn câu hỏi sai kiến thức để demo moderation trên ngân hàng câu hỏi.', '2026-03-27 13:17:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM moderation_record WHERE target_type = 'QUESTION' AND target_id = @q17 AND action = 'HIDE'
);

-- =========================================================
-- 18) SYNC DENORMALIZED COUNTS
-- =========================================================

UPDATE question_post p
SET p.like_count = (
    SELECT COUNT(*) FROM post_likes l WHERE l.post_id = p.question_post_id
);

UPDATE question_post p
SET p.comment_count = (
    SELECT COUNT(*) FROM comment c
    WHERE c.question_post_id = p.question_post_id
      AND c.status = 'VISIBLE'
);

-- =========================================================
-- 19) BACKFILL total_questions nếu cần
-- =========================================================

UPDATE attempt a
SET a.total_questions = (
    SELECT COUNT(*) FROM attempt_question aq WHERE aq.attempt_id = a.attempt_id
)
WHERE a.total_questions = 0;

-- =========================================================
-- 20) CHECK NHANH
-- =========================================================
-- SELECT COUNT(*) AS role_count FROM role;
-- SELECT COUNT(*) AS user_count FROM users;
-- SELECT COUNT(*) AS subject_count FROM subject;
-- SELECT COUNT(*) AS topic_count FROM topic;
-- SELECT COUNT(*) AS question_count FROM question;
-- SELECT COUNT(*) AS answer_option_count FROM answer_option;
-- SELECT COUNT(*) AS quiz_count FROM quiz;
-- SELECT COUNT(*) AS attempt_count FROM attempt;
-- SELECT COUNT(*) AS progress_count FROM learning_progress;
-- SELECT COUNT(*) AS memory_count FROM user_question_memory;
-- SELECT COUNT(*) AS post_count FROM question_post;
-- SELECT COUNT(*) AS comment_count FROM comment;
-- SELECT COUNT(*) AS moderation_count FROM moderation_record;