-- =========================================================
-- V23__new_seed.sql
-- Seed sạch:
-- - users bổ sung
-- - content lớn: 3 subject, 5 topic, mỗi topic 16 question
-- - quiz tối thiểu
-- - community >= 5 bài đăng
-- - KHÔNG có attempt / attempt_question / attempt_answer
-- - KHÔNG có learning_progress / user_question_memory / user_quiz_progress
-- =========================================================

SET @admin_id = COALESCE(
    (SELECT user_id FROM users WHERE email = 'admin@quizptit.local' LIMIT 1),
    (SELECT u.user_id
     FROM users u
     JOIN role r ON r.role_id = u.role_id
     WHERE r.role_name = 'ADMIN'
     ORDER BY u.user_id
     LIMIT 1)
);

SET @student_id = COALESCE(
    (SELECT user_id FROM users WHERE email = 'student@quizptit.local' LIMIT 1),
    (SELECT u.user_id
     FROM users u
     JOIN role r ON r.role_id = u.role_id
     WHERE r.role_name = 'STUDENT'
     ORDER BY u.user_id
     LIMIT 1)
);

-- =========================================================
-- 1) USERS DEMO BỔ SUNG
-- =========================================================

INSERT INTO users (role_id, full_name, email, password_hash, avatar_url, status, created_at, updated_at)
SELECT r.role_id, 'Trần Minh Anh', 'minhanh@quizptit.local',
       '$2a$10$VSRZfFw6NZA.FM96VKJVveWxLN3LSSgM2grD8hBVJHORy9G1eK1LG',
       NULL, 'ACTIVE', '2026-03-20 08:05:00', '2026-03-20 08:05:00'
FROM role r
WHERE r.role_name = 'STUDENT'
  AND NOT EXISTS (SELECT 1 FROM users WHERE email = 'minhanh@quizptit.local');

INSERT INTO users (role_id, full_name, email, password_hash, avatar_url, status, created_at, updated_at)
SELECT r.role_id, 'Lê Hoàng Nam', 'hoangnam@quizptit.local',
       '$2a$10$VSRZfFw6NZA.FM96VKJVveWxLN3LSSgM2grD8hBVJHORy9G1eK1LG',
       NULL, 'ACTIVE', '2026-03-20 08:10:00', '2026-03-20 08:10:00'
FROM role r
WHERE r.role_name = 'STUDENT'
  AND NOT EXISTS (SELECT 1 FROM users WHERE email = 'hoangnam@quizptit.local');

INSERT INTO users (role_id, full_name, email, password_hash, avatar_url, status, created_at, updated_at)
SELECT r.role_id, 'Phạm Thu Hà', 'thuha@quizptit.local',
       '$2a$10$VSRZfFw6NZA.FM96VKJVveWxLN3LSSgM2grD8hBVJHORy9G1eK1LG',
       NULL, 'ACTIVE', '2026-03-20 08:15:00', '2026-03-20 08:15:00'
FROM role r
WHERE r.role_name = 'STUDENT'
  AND NOT EXISTS (SELECT 1 FROM users WHERE email = 'thuha@quizptit.local');

INSERT INTO users (role_id, full_name, email, password_hash, avatar_url, status, created_at, updated_at)
SELECT r.role_id, 'Nguyễn Gia Bảo', 'giabao@quizptit.local',
       '$2a$10$VSRZfFw6NZA.FM96VKJVveWxLN3LSSgM2grD8hBVJHORy9G1eK1LG',
       NULL, 'ACTIVE', '2026-03-20 08:18:00', '2026-03-20 08:18:00'
FROM role r
WHERE r.role_name = 'STUDENT'
  AND NOT EXISTS (SELECT 1 FROM users WHERE email = 'giabao@quizptit.local');

INSERT INTO users (role_id, full_name, email, password_hash, avatar_url, status, created_at, updated_at)
SELECT r.role_id, 'Demo Banned User', 'banned@quizptit.local',
       '$2a$10$VSRZfFw6NZA.FM96VKJVveWxLN3LSSgM2grD8hBVJHORy9G1eK1LG',
       NULL, 'BANNED', '2026-03-20 08:20:00', '2026-03-20 08:20:00'
FROM role r
WHERE r.role_name = 'STUDENT'
  AND NOT EXISTS (SELECT 1 FROM users WHERE email = 'banned@quizptit.local');

SET @minhanh_id = (SELECT user_id FROM users WHERE email = 'minhanh@quizptit.local' LIMIT 1);
SET @hoangnam_id = (SELECT user_id FROM users WHERE email = 'hoangnam@quizptit.local' LIMIT 1);
SET @thuha_id = (SELECT user_id FROM users WHERE email = 'thuha@quizptit.local' LIMIT 1);
SET @giabao_id = (SELECT user_id FROM users WHERE email = 'giabao@quizptit.local' LIMIT 1);

-- =========================================================
-- 2) SUBJECT / TOPIC
-- =========================================================

CREATE TEMPORARY TABLE tmp_subjects (
    subject_name VARCHAR(150),
    description VARCHAR(500),
    is_active BOOLEAN
);

INSERT INTO tmp_subjects (subject_name, description, is_active) VALUES
                                                                    ('Lập trình Java', 'Java core, OOP, Collections Framework', TRUE),
                                                                    ('Cấu trúc dữ liệu và giải thuật', 'Thuật toán sắp xếp, tìm kiếm và phân tích độ phức tạp', TRUE),
                                                                    ('Cơ sở dữ liệu', 'SQL cơ bản, truy vấn và thao tác dữ liệu', TRUE);

INSERT INTO subject (subject_name, description, is_active, created_at)
SELECT s.subject_name, s.description, s.is_active, '2026-03-21 09:00:00'
FROM tmp_subjects s
WHERE NOT EXISTS (
    SELECT 1 FROM subject x WHERE x.subject_name = s.subject_name
);

CREATE TEMPORARY TABLE tmp_topics (
    topic_key VARCHAR(50),
    subject_name VARCHAR(150),
    topic_name VARCHAR(150),
    description VARCHAR(500),
    order_no INT,
    is_active BOOLEAN
);

INSERT INTO tmp_topics (topic_key, subject_name, topic_name, description, order_no, is_active) VALUES
                                                                                                   ('java_oop',         'Lập trình Java',                 'OOP cơ bản',                 'Class, object, encapsulation, inheritance, polymorphism', 1, TRUE),
                                                                                                   ('java_collections', 'Lập trình Java',                 'Collections Framework',      'List, Set, Map, Queue và cấu trúc dữ liệu chuẩn của Java', 2, TRUE),
                                                                                                   ('dsa_sorting',      'Cấu trúc dữ liệu và giải thuật', 'Sắp xếp cơ bản',             'Bubble, Selection, Insertion, Merge, Quick Sort', 1, TRUE),
                                                                                                   ('dsa_searching',    'Cấu trúc dữ liệu và giải thuật', 'Tìm kiếm và độ phức tạp',    'Linear Search, Binary Search, Big-O', 2, TRUE),
                                                                                                   ('db_sql',           'Cơ sở dữ liệu',                  'SQL cơ bản',                 'SELECT, WHERE, GROUP BY, HAVING, ORDER BY', 1, TRUE);

INSERT INTO topic (subject_id, topic_name, description, order_no, is_active, created_at)
SELECT s.subject_id, t.topic_name, t.description, t.order_no, t.is_active, '2026-03-21 09:30:00'
FROM tmp_topics t
         JOIN subject s ON s.subject_name = t.subject_name
WHERE NOT EXISTS (
    SELECT 1
    FROM topic x
    WHERE x.subject_id = s.subject_id
      AND x.topic_name = t.topic_name
);

-- =========================================================
-- 3) QUESTION BANK
-- =========================================================

CREATE TEMPORARY TABLE tmp_questions (
    topic_key VARCHAR(50),
    qno INT,
    content TEXT,
    difficulty_level VARCHAR(20),
    explanation TEXT,
    option_a VARCHAR(500),
    option_b VARCHAR(500),
    option_c VARCHAR(500),
    option_d VARCHAR(500),
    correct_label VARCHAR(10)
);

INSERT INTO tmp_questions (topic_key, qno, content, difficulty_level, explanation, option_a, option_b, option_c, option_d, correct_label) VALUES
-- =========================================================
-- JAVA OOP (16)
-- =========================================================
('java_oop', 1, 'Tính đóng gói trong OOP nhằm mục đích chính là gì?', 'EASY', 'Đóng gói giúp ẩn dữ liệu nội bộ và kiểm soát truy cập qua method.', 'Ẩn dữ liệu và kiểm soát truy cập', 'Cho phép một class có nhiều class cha', 'Tăng tốc độ biên dịch', 'Bắt buộc mọi method đều static', 'A'),
('java_oop', 2, 'Trong Java, từ khóa nào dùng để kế thừa một class khác?', 'EASY', 'Class con dùng từ khóa extends để kế thừa class cha.', 'implements', 'extends', 'inherits', 'instanceof', 'B'),
('java_oop', 3, 'Đa hình trong Java thể hiện rõ nhất ở cơ chế nào?', 'MEDIUM', 'Đa hình thường thể hiện qua method overriding.', 'Đổi tên package', 'Method overriding', 'Dùng final class', 'Khai báo biến local', 'B'),
('java_oop', 4, 'Phát biểu nào đúng về abstract class trong Java?', 'MEDIUM', 'Abstract class có thể có cả abstract method và non-abstract method.', 'Không thể có constructor', 'Có thể chứa method thường và method abstract', 'Mọi method đều phải private', 'Có thể khởi tạo trực tiếp bằng new', 'B'),
('java_oop', 5, 'Interface trong Java thường được dùng khi nào?', 'EASY', 'Interface phù hợp để mô tả một năng lực/cam kết mà nhiều class khác nhau cùng triển khai.', 'Khi cần chia sẻ một cấu trúc dữ liệu tĩnh', 'Khi cần mô tả một capability chung', 'Khi muốn thay thế package', 'Khi chỉ có duy nhất một class dùng', 'B'),
('java_oop', 6, 'Từ khóa super thường được dùng để làm gì?', 'EASY', 'super giúp truy cập thành phần của class cha.', 'Tham chiếu tới class con', 'Tham chiếu tới đối tượng hiện tại', 'Gọi constructor hoặc field của class cha', 'Đánh dấu method static', 'C'),
('java_oop', 7, 'Từ khóa this trong Java đại diện cho điều gì?', 'EASY', 'this tham chiếu tới đối tượng hiện tại.', 'Class cha hiện tại', 'Đối tượng hiện tại', 'Package hiện tại', 'Phương thức hiện tại', 'B'),
('java_oop', 8, 'Method overloading là gì?', 'MEDIUM', 'Overloading là nhiều method cùng tên nhưng khác tham số trong cùng một class.', 'Override method của class cha', 'Khai báo 2 class cùng tên', 'Nhiều method cùng tên nhưng khác tham số', 'Nhiều constructor ở nhiều package', 'C'),
('java_oop', 9, 'Method overriding yêu cầu điều gì?', 'MEDIUM', 'Overriding cần cùng chữ ký method giữa cha và con.', 'Tên khác nhau nhưng cùng tham số', 'Cùng chữ ký method với class cha', 'Phải là method private', 'Chỉ dùng cho static method', 'B'),
('java_oop', 10, 'Access modifier nào có phạm vi truy cập rộng nhất?', 'EASY', 'public cho phép truy cập rộng nhất.', 'private', 'protected', 'default', 'public', 'D'),
('java_oop', 11, 'Phát biểu nào đúng về constructor?', 'EASY', 'Constructor có tên trùng với tên class và không có kiểu trả về.', 'Constructor bắt buộc trả về void', 'Constructor có tên bất kỳ', 'Constructor không có kiểu trả về', 'Constructor luôn là static', 'C'),
('java_oop', 12, 'Từ khóa final khi áp dụng cho class có ý nghĩa gì?', 'MEDIUM', 'final class không thể bị kế thừa.', 'Class chỉ được tạo 1 object', 'Class không thể bị kế thừa', 'Class bắt buộc chứa final method', 'Class không thể có constructor', 'B'),
('java_oop', 13, 'Quan hệ composition thường được hiểu như thế nào?', 'MEDIUM', 'Composition là quan hệ whole-part chặt chẽ, vòng đời phần phụ thuộc vào phần tổng thể.', 'Hai class luôn độc lập hoàn toàn', 'Một class chỉ gọi static method của class khác', 'Quan hệ whole-part chặt chẽ', 'Quan hệ kế thừa nhiều lớp', 'C'),
('java_oop', 14, 'instanceof dùng để làm gì?', 'EASY', 'instanceof kiểm tra object có thuộc một kiểu dữ liệu nào đó hay không.', 'So sánh 2 chuỗi', 'Kiểm tra kiểu của object', 'Kiểm tra method có override chưa', 'Ép kiểu dữ liệu nguyên thủy', 'B'),
('java_oop', 15, 'Nếu một field được khai báo private thì bên ngoài class truy cập phù hợp nhất bằng cách nào?', 'EASY', 'Nên truy cập qua getter/setter công khai nếu cần.', 'Truy cập trực tiếp từ mọi class', 'Dùng getter/setter', 'Đổi field thành protected ngay', 'Dùng instanceof', 'B'),
('java_oop', 16, 'Static method thuộc về đối tượng hay class?', 'EASY', 'Static method thuộc về class.', 'Thuộc object cụ thể', 'Thuộc constructor', 'Thuộc class', 'Thuộc package', 'C'),

-- =========================================================
-- JAVA COLLECTIONS (16)
-- =========================================================
('java_collections', 1, 'Collection nào cho phép phần tử trùng lặp và truy cập theo chỉ số?', 'EASY', 'List cho phép trùng lặp và truy cập theo index.', 'Set', 'List', 'Map', 'Queue', 'B'),
('java_collections', 2, 'HashMap lưu trữ dữ liệu theo cấu trúc nào?', 'EASY', 'HashMap lưu theo cặp key-value.', 'value-value', 'index-value', 'key-value', 'key-key', 'C'),
('java_collections', 3, 'Collection nào không cho phép phần tử trùng lặp?', 'EASY', 'Set không cho phép phần tử trùng lặp.', 'List', 'Queue', 'Set', 'ArrayList', 'C'),
('java_collections', 4, 'Collection nào giữ thứ tự chèn của phần tử trong khi vẫn là Map?', 'MEDIUM', 'LinkedHashMap vừa là Map vừa giữ thứ tự chèn.', 'HashMap', 'TreeMap', 'LinkedHashMap', 'Hashtable', 'C'),
('java_collections', 5, 'TreeSet sắp xếp phần tử theo gì?', 'MEDIUM', 'TreeSet giữ dữ liệu theo thứ tự tự nhiên hoặc Comparator.', 'Theo thứ tự chèn', 'Theo thứ tự ngẫu nhiên', 'Theo thứ tự tự nhiên hoặc Comparator', 'Không sắp xếp', 'C'),
('java_collections', 6, 'ArrayList có ưu điểm rõ nhất ở thao tác nào?', 'EASY', 'ArrayList truy cập theo index nhanh.', 'Truy cập theo index', 'Chèn đầu danh sách nhanh nhất', 'Tìm key-value', 'Sắp xếp tự động', 'A'),
('java_collections', 7, 'LinkedList phù hợp hơn ArrayList trong trường hợp nào?', 'MEDIUM', 'LinkedList thuận lợi hơn khi chèn/xóa nhiều ở đầu hoặc giữa danh sách.', 'Chỉ đọc theo index rất nhiều', 'Chèn/xóa thường xuyên', 'Lưu cặp key-value', 'Không bao giờ có phần tử trùng', 'B'),
('java_collections', 8, 'Map có được coi là subtype trực tiếp của Collection không?', 'MEDIUM', 'Map là cấu trúc riêng, không kế thừa Collection.', 'Có', 'Không', 'Chỉ trong Java 8', 'Chỉ với HashMap', 'B'),
('java_collections', 9, 'Queue thường tuân theo nguyên tắc nào?', 'EASY', 'Queue thường theo FIFO.', 'LIFO', 'FIFO', 'Ngẫu nhiên', 'Theo key-value', 'B'),
('java_collections', 10, 'Deque cho phép thao tác ở đâu?', 'MEDIUM', 'Deque cho phép thêm/xóa ở cả hai đầu.', 'Chỉ ở đầu', 'Chỉ ở cuối', 'Ở cả hai đầu', 'Chỉ ở giữa', 'C'),
('java_collections', 11, 'Comparator được dùng để làm gì?', 'MEDIUM', 'Comparator định nghĩa cách so sánh bên ngoài class.', 'Định nghĩa thứ tự so sánh tùy chỉnh', 'Dùng để clone object', 'Khóa mọi thao tác sort', 'Ép kiểu danh sách', 'A'),
('java_collections', 12, 'Comparable thường được implement khi nào?', 'MEDIUM', 'Comparable dùng khi muốn đối tượng tự định nghĩa thứ tự tự nhiên của chính nó.', 'Khi muốn thứ tự tự nhiên của object', 'Khi cần lưu key-value', 'Khi cần duyệt ngẫu nhiên', 'Khi cần cấm sort', 'A'),
('java_collections', 13, 'HashSet được xây dựng dựa trên cấu trúc nào để tra cứu nhanh?', 'MEDIUM', 'HashSet dựa trên hashing.', 'Cây AVL', 'Mảng 2 chiều', 'Hashing', 'Danh sách liên kết kép bắt buộc', 'C'),
('java_collections', 14, 'ListIterator khác Iterator ở điểm nào nổi bật?', 'MEDIUM', 'ListIterator cho phép duyệt hai chiều trên List.', 'ListIterator chỉ dùng cho Set', 'ListIterator duyệt hai chiều', 'ListIterator không hỗ trợ remove', 'ListIterator bắt buộc là static', 'B'),
('java_collections', 15, 'Phát biểu nào đúng về null trong HashMap?', 'MEDIUM', 'HashMap cho phép một key null và nhiều value null.', 'Không cho phép null nào', 'Cho phép 1 key null và nhiều value null', 'Cho phép nhiều key null nhưng không value null', 'Chỉ cho value null duy nhất', 'B'),
('java_collections', 16, 'Phương thức size() thường trả về gì?', 'EASY', 'size() trả về số phần tử hiện có trong collection/map.', 'Dung lượng bộ nhớ', 'Số bucket nội bộ', 'Số phần tử hiện có', 'Độ sâu tối đa', 'C'),

-- =========================================================
-- DSA SORTING (16)
-- =========================================================
('dsa_sorting', 1, 'Bubble Sort hoạt động chủ yếu bằng cách nào?', 'EASY', 'Bubble Sort so sánh các phần tử kề nhau và đổi chỗ nếu sai thứ tự.', 'Chọn pivot rồi partition', 'So sánh cặp kề nhau và đổi chỗ', 'Chia mảng làm hai nửa', 'Dùng heap tối đa', 'B'),
('dsa_sorting', 2, 'Selection Sort mỗi vòng lặp thường làm gì?', 'MEDIUM', 'Selection Sort chọn phần tử nhỏ nhất của đoạn chưa sắp xếp.', 'Đổi ngẫu nhiên hai phần tử', 'Chọn phần tử nhỏ nhất của đoạn chưa sắp xếp', 'Chia đôi mảng', 'Tạo cây nhị phân', 'B'),
('dsa_sorting', 3, 'Insertion Sort phù hợp hơn khi nào?', 'MEDIUM', 'Insertion Sort khá tốt với dãy nhỏ hoặc gần như đã có thứ tự.', 'Dữ liệu cực lớn và ngẫu nhiên', 'Dãy nhỏ hoặc gần như có thứ tự', 'Bắt buộc ổn định trên file ngoài', 'Chỉ dùng cho số nguyên tố', 'B'),
('dsa_sorting', 4, 'Merge Sort thuộc nhóm kỹ thuật nào?', 'MEDIUM', 'Merge Sort là thuật toán chia để trị.', 'Tham lam', 'Quy hoạch động', 'Chia để trị', 'Nhánh cận', 'C'),
('dsa_sorting', 5, 'Quick Sort chọn phần tử nào để phân hoạch?', 'MEDIUM', 'Quick Sort chọn một pivot để partition.', 'Pivot', 'Root', 'Leaf', 'Median tuyệt đối bắt buộc', 'A'),
('dsa_sorting', 6, 'Độ phức tạp trung bình của Quick Sort là gì?', 'MEDIUM', 'Quick Sort trung bình O(n log n).', 'O(n)', 'O(log n)', 'O(n log n)', 'O(n^2 log n)', 'C'),
('dsa_sorting', 7, 'Độ phức tạp trung bình của Bubble Sort là gì?', 'EASY', 'Bubble Sort trung bình O(n^2).', 'O(1)', 'O(log n)', 'O(n)', 'O(n^2)', 'D'),
('dsa_sorting', 8, 'Thuật toán nào sau đây là stable theo bản chất chuẩn?', 'MEDIUM', 'Merge Sort là stable theo triển khai chuẩn phổ biến.', 'Selection Sort', 'Quick Sort', 'Merge Sort', 'Heap Sort', 'C'),
('dsa_sorting', 9, 'Heap Sort thường dựa trên cấu trúc gì?', 'MEDIUM', 'Heap Sort dựa trên heap.', 'Hash table', 'Heap', 'Queue tuyến tính', 'Danh sách liên kết đơn', 'B'),
('dsa_sorting', 10, 'Thuật toán nào sau đây luôn chia mảng thành hai nửa rồi trộn lại?', 'EASY', 'Merge Sort chia mảng và sau đó merge.', 'Insertion Sort', 'Bubble Sort', 'Merge Sort', 'Selection Sort', 'C'),
('dsa_sorting', 11, 'Selection Sort có tính stable mặc định không?', 'MEDIUM', 'Selection Sort thường không stable ở bản cài đặt cơ bản.', 'Có', 'Không', 'Chỉ với mảng số nguyên', 'Chỉ khi n < 10', 'B'),
('dsa_sorting', 12, 'Thuật toán nào dưới đây thường là in-place?', 'MEDIUM', 'Insertion Sort thường là in-place.', 'Merge Sort', 'Counting Sort', 'Insertion Sort', 'Radix Sort', 'C'),
('dsa_sorting', 13, 'Best case của Insertion Sort có thể là gì?', 'MEDIUM', 'Nếu mảng đã có thứ tự, Insertion Sort có thể đạt O(n).', 'O(n)', 'O(log n)', 'O(n log n)', 'O(n^2)', 'A'),
('dsa_sorting', 14, 'Quick Sort có thể rơi vào worst case nào?', 'HARD', 'Worst case của Quick Sort là O(n^2).', 'O(1)', 'O(log n)', 'O(n)', 'O(n^2)', 'D'),
('dsa_sorting', 15, 'Thuật toán nào phù hợp khi cần sort ổn định và hiệu quả trên linked list?', 'HARD', 'Merge Sort phù hợp tốt trên linked list.', 'Selection Sort', 'Merge Sort', 'Bubble Sort', 'Heap Sort', 'B'),
('dsa_sorting', 16, 'Khái niệm in-place sort nghĩa là gì?', 'MEDIUM', 'In-place sort dùng rất ít bộ nhớ phụ ngoài đầu vào.', 'Luôn stable', 'Không dùng vòng lặp', 'Dùng rất ít bộ nhớ phụ', 'Chỉ dùng cho mảng đã sắp xếp', 'C'),

-- =========================================================
-- DSA SEARCHING (16)
-- =========================================================
('dsa_searching', 1, 'Linear Search có ý tưởng chính là gì?', 'EASY', 'Linear Search duyệt tuần tự từng phần tử.', 'Chia đôi dữ liệu liên tục', 'Duyệt tuần tự từng phần tử', 'Dùng heap', 'Dùng cây đỏ đen bắt buộc', 'B'),
('dsa_searching', 2, 'Binary Search yêu cầu điều kiện tiên quyết nào?', 'EASY', 'Binary Search yêu cầu dữ liệu đã được sắp xếp.', 'Dữ liệu phải là số nguyên tố', 'Dữ liệu phải không có trùng lặp', 'Dữ liệu đã được sắp xếp', 'Dữ liệu phải nằm trong hash table', 'C'),
('dsa_searching', 3, 'Độ phức tạp của Binary Search là gì?', 'EASY', 'Binary Search có độ phức tạp O(log n).', 'O(1)', 'O(log n)', 'O(n)', 'O(n log n)', 'B'),
('dsa_searching', 4, 'Độ phức tạp của Linear Search trong worst case là gì?', 'EASY', 'Linear Search worst case O(n).', 'O(log n)', 'O(n)', 'O(n log n)', 'O(n^2)', 'B'),
('dsa_searching', 5, 'Trong Binary Search, sau mỗi bước không gian tìm kiếm thay đổi thế nào?', 'MEDIUM', 'Mỗi bước thường loại bỏ khoảng một nửa dữ liệu.', 'Tăng gấp đôi', 'Giảm đi 1 phần tử', 'Giảm khoảng một nửa', 'Không đổi', 'C'),
('dsa_searching', 6, 'Nếu dữ liệu chưa sắp xếp, lựa chọn đơn giản nhất để tìm kiếm trực tiếp là gì?', 'EASY', 'Linear Search là cách đơn giản nhất.', 'Binary Search', 'Linear Search', 'Interpolation Search', 'DFS', 'B'),
('dsa_searching', 7, 'Hashing giúp hỗ trợ tìm kiếm nhanh nhờ điều gì?', 'MEDIUM', 'Hashing ánh xạ key tới bucket/ô lưu trữ.', 'Sắp xếp toàn bộ dữ liệu', 'Ánh xạ key tới vị trí lưu trữ', 'Loại bỏ mọi phần tử trùng', 'Chia đôi mảng liên tục', 'B'),
('dsa_searching', 8, 'Nếu dùng cây nhị phân tìm kiếm cân bằng, thao tác tìm kiếm thường là?', 'MEDIUM', 'BST cân bằng thường cho tìm kiếm O(log n).', 'O(1)', 'O(log n)', 'O(n)', 'O(n^2)', 'B'),
('dsa_searching', 9, 'BFS thường dùng cấu trúc nào?', 'MEDIUM', 'BFS thường dùng queue.', 'Stack', 'Queue', 'Heap', 'Map', 'B'),
('dsa_searching', 10, 'DFS thường dùng cấu trúc nào?', 'MEDIUM', 'DFS thường dùng stack hoặc đệ quy.', 'Queue', 'Stack', 'HashSet', 'LinkedHashMap', 'B'),
('dsa_searching', 11, 'Binary Search so sánh phần tử nào ở mỗi bước?', 'EASY', 'Binary Search so sánh với phần tử giữa.', 'Phần tử đầu', 'Phần tử cuối', 'Phần tử giữa', 'Phần tử ngẫu nhiên', 'C'),
('dsa_searching', 12, 'Nếu mảng có nhiều phần tử trùng giá trị cần tìm, Binary Search chuẩn trả về gì?', 'MEDIUM', 'Binary Search chuẩn chỉ đảm bảo tìm được một vị trí hợp lệ, không mặc định là đầu hoặc cuối.', 'Luôn vị trí đầu tiên', 'Luôn vị trí cuối cùng', 'Một vị trí hợp lệ bất kỳ', 'Không tìm được', 'C'),
('dsa_searching', 13, 'Visited set trong BFS/DFS chủ yếu để làm gì?', 'MEDIUM', 'Visited set tránh thăm lặp và vòng lặp vô hạn.', 'Lưu trọng số cạnh', 'Đếm số node lá', 'Tránh thăm lặp', 'Tính chiều cao cây', 'C'),
('dsa_searching', 14, 'Big-O chủ yếu mô tả điều gì?', 'EASY', 'Big-O mô tả tốc độ tăng của chi phí theo kích thước đầu vào.', 'Giá trị chính xác tuyệt đối của thời gian chạy', 'Tốc độ tăng của chi phí theo input size', 'Số dòng code', 'Dung lượng ổ cứng', 'B'),
('dsa_searching', 15, 'Phương pháp nào phù hợp để tìm kiếm nhanh trên dữ liệu key-value động?', 'MEDIUM', 'HashMap phù hợp tra cứu nhanh key-value động.', 'ArrayList tuần tự', 'HashMap', 'Bubble Sort', 'Selection Sort', 'B'),
('dsa_searching', 16, 'Worst case của tìm kiếm trên BST không cân bằng có thể là gì?', 'HARD', 'Nếu BST lệch hoàn toàn, tìm kiếm có thể O(n).', 'O(1)', 'O(log n)', 'O(n)', 'O(n log n)', 'C'),

-- =========================================================
-- DB SQL (16)
-- =========================================================
('db_sql', 1, 'Mệnh đề nào dùng để lọc bản ghi trong câu lệnh SELECT?', 'EASY', 'WHERE dùng để lọc bản ghi theo điều kiện.', 'GROUP BY', 'WHERE', 'ORDER BY', 'LIMIT', 'B'),
('db_sql', 2, 'Hàm COUNT(*) trong SQL dùng để làm gì?', 'EASY', 'COUNT(*) đếm số dòng.', 'Đếm số cột', 'Đếm số dòng', 'Xóa NULL', 'Tạo index', 'B'),
('db_sql', 3, 'ORDER BY dùng để làm gì?', 'EASY', 'ORDER BY dùng để sắp xếp kết quả truy vấn.', 'Lọc dữ liệu', 'Nhóm dữ liệu', 'Sắp xếp kết quả', 'Xóa bản ghi', 'C'),
('db_sql', 4, 'GROUP BY dùng để làm gì?', 'MEDIUM', 'GROUP BY dùng để nhóm các dòng theo một hoặc nhiều cột.', 'Sắp xếp dữ liệu', 'Nhóm dữ liệu', 'Đổi tên bảng', 'Giới hạn số dòng', 'B'),
('db_sql', 5, 'HAVING khác WHERE ở điểm nào?', 'MEDIUM', 'HAVING lọc sau khi dữ liệu đã được nhóm.', 'HAVING lọc sau GROUP BY', 'HAVING chỉ dùng cho INSERT', 'HAVING luôn nhanh hơn WHERE', 'HAVING dùng để sort', 'A'),
('db_sql', 6, 'DISTINCT dùng để làm gì?', 'EASY', 'DISTINCT loại bỏ dòng trùng trong kết quả.', 'Nhân đôi kết quả', 'Loại bỏ giá trị trùng', 'Đổi kiểu dữ liệu', 'Xóa bảng', 'B'),
('db_sql', 7, 'LIKE ''A%'' có ý nghĩa gì?', 'EASY', 'Mẫu A% nghĩa là bắt đầu bằng A.', 'Kết thúc bằng A', 'Chứa đúng một ký tự A', 'Bắt đầu bằng A', 'Không chứa A', 'C'),
('db_sql', 8, 'Toán tử IN thường dùng khi nào?', 'EASY', 'IN kiểm tra giá trị có thuộc một tập giá trị hay không.', 'So sánh lớn hơn', 'Kiểm tra thuộc một tập giá trị', 'Sắp xếp giảm dần', 'Nối bảng', 'B'),
('db_sql', 9, 'BETWEEN thường dùng để làm gì?', 'EASY', 'BETWEEN kiểm tra giá trị nằm trong một khoảng.', 'So sánh khác nhau', 'Kiểm tra trong khoảng', 'Nhóm dữ liệu', 'Tạo khóa chính', 'B'),
('db_sql', 10, 'Phát biểu nào đúng về NULL trong SQL?', 'MEDIUM', 'NULL biểu thị giá trị chưa biết/không có.', 'NULL bằng 0', 'NULL bằng chuỗi rỗng', 'NULL biểu thị thiếu hoặc chưa biết giá trị', 'NULL luôn nhỏ nhất', 'C'),
('db_sql', 11, 'Muốn kiểm tra cột không có giá trị, nên dùng gì?', 'EASY', 'Dùng IS NULL thay vì = NULL.', '= NULL', 'IS NULL', '<> NULL', 'NOT = NULL', 'B'),
('db_sql', 12, 'Câu lệnh nào dùng để thêm bản ghi mới?', 'EASY', 'INSERT dùng để thêm dữ liệu mới.', 'UPDATE', 'DELETE', 'INSERT', 'ALTER', 'C'),
('db_sql', 13, 'Câu lệnh nào dùng để cập nhật dữ liệu đã có?', 'EASY', 'UPDATE dùng để cập nhật dữ liệu.', 'CREATE', 'UPDATE', 'DROP', 'TRUNCATE', 'B'),
('db_sql', 14, 'Câu lệnh nào dùng để xóa bản ghi theo điều kiện?', 'EASY', 'DELETE FROM ... WHERE ... dùng để xóa bản ghi.', 'DELETE', 'REMOVE', 'DROP COLUMN', 'CLEAR', 'A'),
('db_sql', 15, 'LIMIT trong MySQL thường dùng để làm gì?', 'EASY', 'LIMIT giới hạn số dòng trả về.', 'Đổi tên cột', 'Giới hạn số dòng trả về', 'Tạo chỉ mục', 'Khóa bảng', 'B'),
('db_sql', 16, 'Alias trong SQL thường được tạo bằng từ khóa nào?', 'EASY', 'Alias thường dùng AS.', 'ON', 'INTO', 'AS', 'BY', 'C');

INSERT INTO question (
    topic_id, content, difficulty_level, explanation, status, created_by, created_at, updated_at
)
SELECT tp.topic_id,
       q.content,
       q.difficulty_level,
       q.explanation,
       'APPROVED',
       @admin_id,
       '2026-03-22 08:00:00',
       '2026-03-22 08:00:00'
FROM tmp_questions q
         JOIN tmp_topics tt ON tt.topic_key = q.topic_key
         JOIN subject s ON s.subject_name = tt.subject_name
         JOIN topic tp ON tp.subject_id = s.subject_id AND tp.topic_name = tt.topic_name
WHERE NOT EXISTS (
    SELECT 1
    FROM question x
    WHERE x.topic_id = tp.topic_id
      AND x.content = q.content
);

INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT qq.question_id, 'A', tq.option_a, (tq.correct_label = 'A')
FROM tmp_questions tq
         JOIN tmp_topics tt ON tt.topic_key = tq.topic_key
         JOIN subject s ON s.subject_name = tt.subject_name
         JOIN topic tp ON tp.subject_id = s.subject_id AND tp.topic_name = tt.topic_name
         JOIN question qq ON qq.topic_id = tp.topic_id AND qq.content = tq.content
WHERE NOT EXISTS (
    SELECT 1 FROM answer_option ao WHERE ao.question_id = qq.question_id AND ao.option_label = 'A'
);

INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT qq.question_id, 'B', tq.option_b, (tq.correct_label = 'B')
FROM tmp_questions tq
         JOIN tmp_topics tt ON tt.topic_key = tq.topic_key
         JOIN subject s ON s.subject_name = tt.subject_name
         JOIN topic tp ON tp.subject_id = s.subject_id AND tp.topic_name = tt.topic_name
         JOIN question qq ON qq.topic_id = tp.topic_id AND qq.content = tq.content
WHERE NOT EXISTS (
    SELECT 1 FROM answer_option ao WHERE ao.question_id = qq.question_id AND ao.option_label = 'B'
);

INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT qq.question_id, 'C', tq.option_c, (tq.correct_label = 'C')
FROM tmp_questions tq
         JOIN tmp_topics tt ON tt.topic_key = tq.topic_key
         JOIN subject s ON s.subject_name = tt.subject_name
         JOIN topic tp ON tp.subject_id = s.subject_id AND tp.topic_name = tt.topic_name
         JOIN question qq ON qq.topic_id = tp.topic_id AND qq.content = tq.content
WHERE NOT EXISTS (
    SELECT 1 FROM answer_option ao WHERE ao.question_id = qq.question_id AND ao.option_label = 'C'
);

INSERT INTO answer_option (question_id, option_label, content, is_correct)
SELECT qq.question_id, 'D', tq.option_d, (tq.correct_label = 'D')
FROM tmp_questions tq
         JOIN tmp_topics tt ON tt.topic_key = tq.topic_key
         JOIN subject s ON s.subject_name = tt.subject_name
         JOIN topic tp ON tp.subject_id = s.subject_id AND tp.topic_name = tt.topic_name
         JOIN question qq ON qq.topic_id = tp.topic_id AND qq.content = tq.content
WHERE NOT EXISTS (
    SELECT 1 FROM answer_option ao WHERE ao.question_id = qq.question_id AND ao.option_label = 'D'
);

-- =========================================================
-- 4) QUIZ TỐI THIỂU
-- =========================================================

CREATE TEMPORARY TABLE tmp_quizzes (
    quiz_key VARCHAR(50),
    topic_key VARCHAR(50),
    title VARCHAR(255),
    description VARCHAR(1000),
    quiz_type VARCHAR(20),
    duration_minutes INT,
    total_questions INT,
    is_published BOOLEAN
);

INSERT INTO tmp_quizzes (quiz_key, topic_key, title, description, quiz_type, duration_minutes, total_questions, is_published) VALUES
                                                                                                                                  ('quiz_oop',         'java_oop',         'Java OOP cơ bản - Quiz 1',            'Quiz manual nền tảng OOP Java.', 'MANUAL', 15, 10, TRUE),
                                                                                                                                  ('quiz_collection',  'java_collections', 'Java Collections - Quiz 1',           'Quiz manual về List, Set, Map.', 'MANUAL', 15, 10, TRUE),
                                                                                                                                  ('quiz_sorting',     'dsa_sorting',      'DSA Sorting Foundations',             'Quiz manual về các thuật toán sắp xếp.', 'MANUAL', 20, 10, TRUE),
                                                                                                                                  ('quiz_searching',   'dsa_searching',    'DSA Searching Fundamentals',          'Quiz manual về tìm kiếm và Big-O.', 'MANUAL', 20, 10, TRUE),
                                                                                                                                  ('quiz_sql',         'db_sql',           'SQL Basics and Query Practice',       'Quiz manual về SQL cơ bản.', 'MANUAL', 20, 10, TRUE);

INSERT INTO quiz (
    subject_id, topic_id, title, description, quiz_type,
    duration_minutes, total_questions, created_by, is_published, created_at, updated_at
)
SELECT s.subject_id,
       tp.topic_id,
       qz.title,
       qz.description,
       qz.quiz_type,
       qz.duration_minutes,
       qz.total_questions,
       @admin_id,
       qz.is_published,
       '2026-03-23 09:00:00',
       '2026-03-23 09:00:00'
FROM tmp_quizzes qz
         JOIN tmp_topics tt ON tt.topic_key = qz.topic_key
         JOIN subject s ON s.subject_name = tt.subject_name
         JOIN topic tp ON tp.subject_id = s.subject_id AND tp.topic_name = tt.topic_name
WHERE NOT EXISTS (
    SELECT 1 FROM quiz x WHERE x.title = qz.title
);

INSERT INTO quiz_question (quiz_id, question_id, order_no, score_weight)
SELECT q.quiz_id,
       qu.question_id,
       tq.qno,
       1.00
FROM tmp_quizzes tquiz
         JOIN quiz q ON q.title = tquiz.title
         JOIN tmp_questions tq ON tq.topic_key = tquiz.topic_key AND tq.qno <= 10
         JOIN tmp_topics tt ON tt.topic_key = tq.topic_key
         JOIN subject s ON s.subject_name = tt.subject_name
         JOIN topic tp ON tp.subject_id = s.subject_id AND tp.topic_name = tt.topic_name
         JOIN question qu ON qu.topic_id = tp.topic_id AND qu.content = tq.content
WHERE NOT EXISTS (
    SELECT 1
    FROM quiz_question qq
    WHERE qq.quiz_id = q.quiz_id
      AND qq.question_id = qu.question_id
);

-- =========================================================
-- 5) COMMUNITY
-- =========================================================

INSERT INTO question_post (
    user_id, topic_id, title, content, status, view_count, like_count, comment_count, theme_color, created_at, updated_at
)
SELECT @student_id, tp.topic_id,
       'Phân biệt abstract class và interface trong Java như thế nào?',
       'Mình đang hơi rối giữa abstract class và interface. Trong bài toán thực tế thì khi nào nên chọn abstract class, khi nào nên chọn interface?',
       'VISIBLE', 125, 0, 0, '#E8F0FE', '2026-03-27 09:00:00', '2026-03-27 09:00:00'
FROM topic tp
         JOIN subject s ON s.subject_id = tp.subject_id
WHERE s.subject_name = 'Lập trình Java' AND tp.topic_name = 'OOP cơ bản'
  AND NOT EXISTS (SELECT 1 FROM question_post WHERE title = 'Phân biệt abstract class và interface trong Java như thế nào?');

INSERT INTO question_post (
    user_id, topic_id, title, content, status, view_count, like_count, comment_count, theme_color, created_at, updated_at
)
SELECT @minhanh_id, tp.topic_id,
       'Vì sao HashMap không đảm bảo thứ tự phần tử?',
       'Mình thấy duyệt HashMap mỗi lần có thể ra thứ tự khác nhau. Cơ chế bên trong của nó là gì và khi nào nên dùng LinkedHashMap?',
       'VISIBLE', 98, 0, 0, '#FFF4E5', '2026-03-27 10:00:00', '2026-03-27 10:00:00'
FROM topic tp
         JOIN subject s ON s.subject_id = tp.subject_id
WHERE s.subject_name = 'Lập trình Java' AND tp.topic_name = 'Collections Framework'
  AND NOT EXISTS (SELECT 1 FROM question_post WHERE title = 'Vì sao HashMap không đảm bảo thứ tự phần tử?');

INSERT INTO question_post (
    user_id, topic_id, title, content, status, view_count, like_count, comment_count, theme_color, created_at, updated_at
)
SELECT @hoangnam_id, tp.topic_id,
       'Insertion Sort có thật sự hợp hơn khi dữ liệu gần như có thứ tự không?',
       'Mọi người giải thích giúp mình tại sao với mảng gần như có thứ tự thì Insertion Sort thường được nhắc tới nhiều hơn các thuật toán đơn giản khác.',
       'VISIBLE', 76, 0, 0, '#EAFBF1', '2026-03-27 11:00:00', '2026-03-27 11:00:00'
FROM topic tp
         JOIN subject s ON s.subject_id = tp.subject_id
WHERE s.subject_name = 'Cấu trúc dữ liệu và giải thuật' AND tp.topic_name = 'Sắp xếp cơ bản'
  AND NOT EXISTS (SELECT 1 FROM question_post WHERE title = 'Insertion Sort có thật sự hợp hơn khi dữ liệu gần như có thứ tự không?');

INSERT INTO question_post (
    user_id, topic_id, title, content, status, view_count, like_count, comment_count, theme_color, created_at, updated_at
)
SELECT @thuha_id, tp.topic_id,
       'Binary Search bắt buộc phải có mảng tăng dần hay chỉ cần có thứ tự bất kỳ?',
       'Nếu dữ liệu được sắp xếp giảm dần thì Binary Search có dùng được không, hay bắt buộc phải là tăng dần?',
       'VISIBLE', 89, 0, 0, '#F5EFFF', '2026-03-27 12:00:00', '2026-03-27 12:00:00'
FROM topic tp
         JOIN subject s ON s.subject_id = tp.subject_id
WHERE s.subject_name = 'Cấu trúc dữ liệu và giải thuật' AND tp.topic_name = 'Tìm kiếm và độ phức tạp'
  AND NOT EXISTS (SELECT 1 FROM question_post WHERE title = 'Binary Search bắt buộc phải có mảng tăng dần hay chỉ cần có thứ tự bất kỳ?');

INSERT INTO question_post (
    user_id, topic_id, title, content, status, view_count, like_count, comment_count, theme_color, created_at, updated_at
)
SELECT @giabao_id, tp.topic_id,
       'HAVING khác WHERE ở ví dụ nào dễ nhớ nhất?',
       'Mình hay bị nhầm WHERE và HAVING. Mọi người cho mình một ví dụ ngắn gọn dễ nhớ với GROUP BY được không?',
       'VISIBLE', 143, 0, 0, '#E9F7FF', '2026-03-27 13:00:00', '2026-03-27 13:00:00'
FROM topic tp
         JOIN subject s ON s.subject_id = tp.subject_id
WHERE s.subject_name = 'Cơ sở dữ liệu' AND tp.topic_name = 'SQL cơ bản'
  AND NOT EXISTS (SELECT 1 FROM question_post WHERE title = 'HAVING khác WHERE ở ví dụ nào dễ nhớ nhất?');

INSERT INTO question_post (
    user_id, topic_id, title, content, status, view_count, like_count, comment_count, theme_color, created_at, updated_at
)
SELECT @student_id, tp.topic_id,
       'Post vi phạm để demo moderation',
       'Nội dung này được tạo ra chỉ để demo chức năng ẩn nội dung trong khu vực quản trị.',
       'HIDDEN', 12, 0, 0, '#FFECEC', '2026-03-27 14:00:00', '2026-03-27 14:15:00'
FROM topic tp
         JOIN subject s ON s.subject_id = tp.subject_id
WHERE s.subject_name = 'Lập trình Java' AND tp.topic_name = 'OOP cơ bản'
  AND NOT EXISTS (SELECT 1 FROM question_post WHERE title = 'Post vi phạm để demo moderation');

SET @post_1 = (SELECT question_post_id FROM question_post WHERE title = 'Phân biệt abstract class và interface trong Java như thế nào?' LIMIT 1);
SET @post_2 = (SELECT question_post_id FROM question_post WHERE title = 'Vì sao HashMap không đảm bảo thứ tự phần tử?' LIMIT 1);
SET @post_3 = (SELECT question_post_id FROM question_post WHERE title = 'Insertion Sort có thật sự hợp hơn khi dữ liệu gần như có thứ tự không?' LIMIT 1);
SET @post_4 = (SELECT question_post_id FROM question_post WHERE title = 'Binary Search bắt buộc phải có mảng tăng dần hay chỉ cần có thứ tự bất kỳ?' LIMIT 1);
SET @post_5 = (SELECT question_post_id FROM question_post WHERE title = 'HAVING khác WHERE ở ví dụ nào dễ nhớ nhất?' LIMIT 1);
SET @post_hidden = (SELECT question_post_id FROM question_post WHERE title = 'Post vi phạm để demo moderation' LIMIT 1);

INSERT INTO comment (question_post_id, user_id, parent_id, content, status, created_at, updated_at)
SELECT @post_1, @minhanh_id, NULL,
       'Interface phù hợp khi bạn muốn mô tả capability chung cho nhiều class không cùng hệ kế thừa.',
       'VISIBLE', '2026-03-27 09:15:00', '2026-03-27 09:15:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM comment
    WHERE question_post_id = @post_1 AND user_id = @minhanh_id
      AND content = 'Interface phù hợp khi bạn muốn mô tả capability chung cho nhiều class không cùng hệ kế thừa.'
);

INSERT INTO comment (question_post_id, user_id, parent_id, content, status, created_at, updated_at)
SELECT @post_1, @thuha_id, NULL,
       'Abstract class hợp khi bạn muốn tái sử dụng code chung và vẫn giữ một số phần bắt buộc subclass phải override.',
       'VISIBLE', '2026-03-27 09:20:00', '2026-03-27 09:20:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM comment
    WHERE question_post_id = @post_1 AND user_id = @thuha_id
      AND content = 'Abstract class hợp khi bạn muốn tái sử dụng code chung và vẫn giữ một số phần bắt buộc subclass phải override.'
);

SET @parent_comment_oop = (
    SELECT comment_id
    FROM comment
    WHERE question_post_id = @post_1
      AND content = 'Interface phù hợp khi bạn muốn mô tả capability chung cho nhiều class không cùng hệ kế thừa.'
    LIMIT 1
);

INSERT INTO comment (question_post_id, user_id, parent_id, content, status, created_at, updated_at)
SELECT @post_1, @student_id, @parent_comment_oop,
       'Ví dụ này dễ hiểu quá, cảm ơn bạn. Mình sẽ nhớ theo hướng capability và base implementation.',
       'VISIBLE', '2026-03-27 09:25:00', '2026-03-27 09:25:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM comment
    WHERE question_post_id = @post_1 AND user_id = @student_id
      AND content = 'Ví dụ này dễ hiểu quá, cảm ơn bạn. Mình sẽ nhớ theo hướng capability và base implementation.'
);

INSERT INTO comment (question_post_id, user_id, parent_id, content, status, created_at, updated_at)
SELECT @post_2, @student_id, NULL,
       'HashMap ưu tiên hiệu năng tra cứu theo hash, còn LinkedHashMap thêm cơ chế giữ thứ tự chèn.',
       'VISIBLE', '2026-03-27 10:10:00', '2026-03-27 10:10:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM comment
    WHERE question_post_id = @post_2 AND user_id = @student_id
      AND content = 'HashMap ưu tiên hiệu năng tra cứu theo hash, còn LinkedHashMap thêm cơ chế giữ thứ tự chèn.'
);

INSERT INTO comment (question_post_id, user_id, parent_id, content, status, created_at, updated_at)
SELECT @post_3, @thuha_id, NULL,
       'Đúng rồi, vì khi dữ liệu gần có thứ tự thì số lần dịch chuyển của Insertion Sort thấp hơn khá nhiều.',
       'VISIBLE', '2026-03-27 11:12:00', '2026-03-27 11:12:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM comment
    WHERE question_post_id = @post_3 AND user_id = @thuha_id
      AND content = 'Đúng rồi, vì khi dữ liệu gần có thứ tự thì số lần dịch chuyển của Insertion Sort thấp hơn khá nhiều.'
);

INSERT INTO comment (question_post_id, user_id, parent_id, content, status, created_at, updated_at)
SELECT @post_4, @hoangnam_id, NULL,
       'Chỉ cần dữ liệu có thứ tự nhất quán là được, tăng dần hay giảm dần thì đều có thể điều chỉnh điều kiện so sánh.',
       'VISIBLE', '2026-03-27 12:15:00', '2026-03-27 12:15:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM comment
    WHERE question_post_id = @post_4 AND user_id = @hoangnam_id
      AND content = 'Chỉ cần dữ liệu có thứ tự nhất quán là được, tăng dần hay giảm dần thì đều có thể điều chỉnh điều kiện so sánh.'
);

INSERT INTO comment (question_post_id, user_id, parent_id, content, status, created_at, updated_at)
SELECT @post_5, @minhanh_id, NULL,
       'WHERE lọc trước khi nhóm, còn HAVING lọc sau khi đã GROUP BY. Đây là cách nhớ ngắn nhất.',
       'VISIBLE', '2026-03-27 13:20:00', '2026-03-27 13:20:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM comment
    WHERE question_post_id = @post_5 AND user_id = @minhanh_id
      AND content = 'WHERE lọc trước khi nhóm, còn HAVING lọc sau khi đã GROUP BY. Đây là cách nhớ ngắn nhất.'
);

INSERT INTO comment (question_post_id, user_id, parent_id, content, status, created_at, updated_at)
SELECT @post_hidden, @hoangnam_id, NULL,
       'Comment này cũng dùng để demo moderation và hiện đang bị ẩn.',
       'HIDDEN', '2026-03-27 14:10:00', '2026-03-27 14:15:00'
    WHERE NOT EXISTS (
    SELECT 1 FROM comment
    WHERE question_post_id = @post_hidden AND user_id = @hoangnam_id
      AND content = 'Comment này cũng dùng để demo moderation và hiện đang bị ẩn.'
);

SET @hidden_comment_id = (
    SELECT comment_id
    FROM comment
    WHERE question_post_id = @post_hidden
      AND content = 'Comment này cũng dùng để demo moderation và hiện đang bị ẩn.'
    LIMIT 1
);

INSERT INTO moderation_record (moderator_id, target_type, target_id, action, reason, created_at)
SELECT @admin_id, 'QUESTION_POST', @post_hidden, 'HIDE',
       'Ẩn bài để demo kiểm duyệt nội dung cộng đồng.', '2026-03-27 14:15:00'
    WHERE NOT EXISTS (
    SELECT 1
    FROM moderation_record
    WHERE target_type = 'QUESTION_POST'
      AND target_id = @post_hidden
      AND action = 'HIDE'
);

INSERT INTO moderation_record (moderator_id, target_type, target_id, action, reason, created_at)
SELECT @admin_id, 'COMMENT', @hidden_comment_id, 'HIDE',
       'Ẩn comment để demo kiểm duyệt bình luận.', '2026-03-27 14:16:00'
    WHERE NOT EXISTS (
    SELECT 1
    FROM moderation_record
    WHERE target_type = 'COMMENT'
      AND target_id = @hidden_comment_id
      AND action = 'HIDE'
);

UPDATE question_post p
SET p.comment_count = (
    SELECT COUNT(*)
    FROM comment c
    WHERE c.question_post_id = p.question_post_id
      AND c.status = 'VISIBLE'
);

-- =========================================================
-- 6) CLEANUP TEMP
-- =========================================================
DROP TEMPORARY TABLE IF EXISTS tmp_quizzes;
DROP TEMPORARY TABLE IF EXISTS tmp_questions;
DROP TEMPORARY TABLE IF EXISTS tmp_topics;
DROP TEMPORARY TABLE IF EXISTS tmp_subjects;