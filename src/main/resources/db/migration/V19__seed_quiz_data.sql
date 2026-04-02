SET @admin_id = (SELECT user_id FROM users WHERE email='admin@quizptit.local' LIMIT 1);

-- Subject: An toàn bảo mật hệ thống thông tin
INSERT INTO subject (subject_name, description) VALUES ('An toàn bảo mật hệ thống thông tin', 'Ngân hàng câu hỏi trắc nghiệm môn An toàn bảo mật hệ thống thông tin');
SET @curr_subject_id = LAST_INSERT_ID();
INSERT INTO topic (subject_id, topic_name, description, order_no) VALUES (@curr_subject_id, 'Tổng hợp đại cương', 'Các câu hỏi ôn tập tổng hợp', 1);
SET @curr_topic_id = LAST_INSERT_ID();

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mô hình tổng quát đảm bảo an toàn thông tin và hệ thống thông tin thường gồm các lớp:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'An ninh tổ chức, An ninh mạng và Điều khiển truy cập', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'An ninh tổ chức, Tưởng lửa và Điều khiển truy cập', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'An ninh tổ chức, An ninh mạng và An toàn hệ điều hành và ứng dụng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'An ninh tổ chức, An ninh mạng và An ninh hệ thống', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'An toàn thông tin gồm hai lĩnh vực chính là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'An ninh mạng và An toàn hệ thống', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'An toàn máy tính và An toàn Internet', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'An toàn máy tính và An ninh mạng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'An toàn công nghệ thông tin và Đảm bảo thông tin', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tại sao cần phải đảm bảo an toàn cho thông tin?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Do có nhiều thiết bị kết nối mạng Internet với nhiều nguy cơ và đe dọa', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Do có quá nhiều phần mềm độc hại', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Do có quá nhiều nguy cơ tấn công mạng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Do có nhiều thiết bị kết nối mạng Internet', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'An toàn hệ thống thông tin là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Việc đảm bảo thông tin trong hệ thống không bị đánh cắp', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Việc đảm bảo cho hệ thống thông tin hoạt động trơn tru, ổn định', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Việc đảm bảo cho hệ thống thông tin không bị tấn công', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Việc đảm bảo các thuộc tính an ninh, an toàn của hệ thống thông tin', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Người sử dụng hệ thống thông tin quản lý trong mô hình 4 loại hệ thống thông tin là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Quản lý cao cấp', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Giám đốc điều hành', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Nhân viên', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Quản lý bộ phận', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Nguyên tắc cơ bản cho đảm bảo an toàn thông tin, hệ thống và mạng là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Phòng vệ nhiều lớp có chiều sâu', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Cần đầu tư trang thiết bị và chuyên gia đảm bảo an toàn', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Cần mua sắm và lắp đặt nhiều thiết bị an ninh chuyên dụng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Cân bằng giữa tính hữu dụng, chi phí và tính năng', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một trong các nội dung rất quan trọng của quản lý an toàn thông tin là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Quản lý các ứng dụng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Quản lý hệ thống', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Quản lý hệ điều hành', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Quản lý rủi ro', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một thông điệp có nội dung nhạy cảm truyền trên mạng bị sửa đổi. Các thuộc tính an toàn thông tin nào bị vi phạm?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Bí mật, Toàn vẹn và sẵn dùng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Bí mật và Toàn vẹn', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Bí mật', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Toàn vẹn', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Nguy cơ bị tấn công từ chối dịch vụ (DoS) và từ chối dịch vụ phân tán (DDoS) thường gặp ở vùng nào trong 7 vùng cơ sở hạ tầng CNTT?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Vùng máy trạm', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Vùng mạng WAN', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Vùng mạng LAN-to-WAN', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Vùng mạng LAN', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'An toàn thông tin (Information Security) là gì?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Là việc phòng chống đánh cắp thông tin', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Là việc bảo vệ chống truy nhập, sử dụng, tiết lộ, sửa đổi, hoặc phá hủy thông tin một cách trái phép', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Là việc bảo vệ chống sử dụng, tiết lộ, sửa đổi, vận chuyển hoặc phá hủy thông tin một cách trái phép', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Là việc phòng chống tấn công mạng', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tìm phát biểu đúng trong các phát biểu sau:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Mối đe dọa là bất kỳ một hành động tấn công nào vào hệ thống mạng.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Mối đe dọa là bất kỳ một hành động nào có thể gây hư hại đến các tài nguyên hệ thống.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Mối đe dọa là bất kỳ một hành động tấn công nào vào hệ thống máy tính.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Mối đe dọa là bất kỳ một hành động tấn công nào vào hệ thống máy tính và mạng.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Đây là một trong các biện pháp phòng chống tấn công khai thác lỗi tràn bộ đệm?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Sử dụng tường lửa', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Sử dụng công nghệ xác thực mạnh', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Sử dụng các kỹ thuật mật mã', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Sử dụng cơ chế cẩm thực hiện mã trong dữ liệu', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Trong tấn công khai thác lỗi tràn bộ đệm, tin tặc thường sử dụng một số lệnh NOP (No Operation) ở phần đầu của mã tấn công. Mục đích của việc này là để:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Tăng khả năng phá hoại của mã tấn công', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Tăng khả năng gây tràn bộ đệm', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Tăng khả năng mã tấn công được thực hiện', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tăng khả năng gây lỗi chương trình', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tìm phát biểu đúng trong các phát biểu sau:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Điểm yếu hệ thống chỉ xuất hiện trong các mô đun phần mềm', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Điểm yếu chỉ xuất hiện khi hệ thống bị tấn công', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Điểm yếu hệ thống có thể xuất hiện trong cả các mô đun phần cứng và phần mềm', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Điểm yếu hệ thống chỉ xuất hiện trong các mô đun phần cứng', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Các vùng bộ nhớ thường bị tràn gồm:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Ngăn xếp (Stack) và vùng nhớ cấp phát động (Heap)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Ngăn xếp (Stack) và Bộ nhớ đệm (Cache)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Hàng đợi (Queue) và vùng nhớ cấp phát động (Heap)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Hàng đợi (Queue) và Ngăn xếp (Stack)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Các thành phần chính của hệ thống máy tính gồm:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'CPU, Bộ nhớ, HDD, hệ điều hành và các ứng dụng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'CPU, hệ điều hành và các ứng dụng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Hệ thống phần cứng và Hệ thống phần mềm', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'CPU, Bộ nhớ, HDD và Hệ thống bus truyền dẫn', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Nguyên nhân của sự tồn tại các điểm yếu trong hệ thống có thể do:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Lỗi thiết kế, lỗi cài đặt và lập trình', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Tất cả các khâu trong quá trình phát triển và vận hành', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Lỗi quản trị', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Lỗi cấu hình hoạt động', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Trên thực tế, có thể giảm khả năng bị tấn công nếu có thể...', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Triệt tiêu được hết các nguy cơ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Triệt tiêu được hết các mối đe dọa', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Giảm thiểu các lỗ hổng bảo mật', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Kiểm soát chặt chẽ người dùng', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Sâu SQL Slammer tấn công khai thác lỗi tràn bộ đệm trong hệ quản trị cơ sở dữ liệu:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'SQL Server 2012', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'SQL Server 2000', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'SQL Server 2008', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'SQL Server 2003', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Các lỗ hổng bảo mật thường tồn tại nhiều nhất trong thành phần nào của hệ thống:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Hệ điều hành', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Các dịch vụ mạng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Các ứng dụng', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Các thành phần phần cứng', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Các kỹ thuật và công cụ thường được sử dụng trong an ninh mạng bao gồm:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'VPN, SSL/TLS, PGP', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Điều khiển truy nhập', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Điều khiển truy nhập, tường lửa, proxy và các giao thức bảo mật, ứng dụng dựa trên mật mã', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tường lửa, proxy', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Các thành phần của an toàn thông tin gồm:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'An toàn máy tính, An ninh mạng, Quản lý ATTT và Chính sách ATTT', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'An toàn máy tính và dữ liệu, An ninh mạng, Quản lý ATTT và Chính sách ATTT', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'An toàn máy tính, An ninh mạng, Quản lý rủi ro ATTT và Chính sách ATTT', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'An toàn máy tính, An toàn dữ liệu, An ninh mạng, Quản lý ATTT', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Trong tấn công khai thác lỗi tràn bộ đệm, tin tặc thường sử dụng shellcode. Shellcode đó là dạng:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Mã Java', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Mã C/C++', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Mã máy', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Mã Hợp ngữ', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Các yêu cầu cơ bản trong đảm bảo an toàn thông tin và an toàn hệ thống thông tin gồm:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Bảo mật, Toàn vẹn và Khả dụng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Bảo mật, Toàn vẹn và Sẵn dùng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Bí mật, Toàn vẹn và Sẵn dùng', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Bí mật, Toàn vẹn và không chối bỏ', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Việc thực thi quản lý ATTT cần được thực hiện theo chu trình lặp lại là do', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Các điều kiện bên trong và bên ngoài hệ thống thay đổi theo thời gian', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Trình độ cao của tin tặc và công cụ tấn công ngày càng phổ biến', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Số lượng và khả năng phá hoại của các phần mềm độc hại ngày càng tăng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Máy tính, hệ điều hành và các phần mềm được nâng cấp nhanh chóng', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Hệ thống thông tin là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Một hệ thống tích hợp các thành phần nhằm phục vụ việc thu thập, lưu trữ, xử lý thông tin, chuyển giao thông tin, tri thức và các sản phẩm số', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Một hệ thống gồm các thành phần phần cứng và phần mềm nhằm phục vụ việc thu thập, lưu trữ, xử lý thông tin, chuyển giao thông tin', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Một hệ thống gồm các thành phần phần cứng nhằm phục vụ việc thu thập, lưu trữ, xử lý thông tin, chuyển giao thông tin, tri thức và các sản phẩm số', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Một hệ thống gồm các thành phần phần mềm nhằm phục vụ việc thu thập, lưu trữ, xử lý thông tin, chuyển giao thông tin, tri thức và các sản phẩm số', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tính bí mật của thông tin có thể được đảm bảo bằng:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Bảo vệ vật lý', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Các kỹ thuật mã hóa', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'sử dụng VPN', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Bảo vệ vật lý, VPN, hoặc mã hóa', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Lỗ hổng bảo mật (Security vulnerability) là một điểm yếu tồn tại trong một hệ thống cho phép tin tặc:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Khai thác nhằm đánh cắp các thông tin trong hệ thống', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Khai thác gây tổn hại đến các thuộc tính an ninh của hệ thống đó', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Khai thác, tấn công phá hoại và gây tê liệt hệ thống', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Khai thác nhằm chiếm quyền điều khiển hệ thống', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Đảm bảo thông tin (Information assurance) thường được thực hiện bằng cách:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Sử dụng kỹ thuật tạo dự phòng ra đĩa cứng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Sử dụng kỹ thuật tạo dự phòng ra băng từ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Sử dụng kỹ thuật tạo dự phòng ngoại vi', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Sử dụng kỹ thuật tạo dự phòng cục bộ', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Lỗi tràn bộ đệm là lỗi trong khâu:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Kiểm thử phần mềm', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Thiết kế phần mềm', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Lập trình phần mềm', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Quản trị phần mềm', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Đâu là dạng lỗ hổng bảo mật thường gặp trong hệ điều hành và các phần mềm ứng dụng?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Lỗi tràn bộ đệm', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Lỗi quản trị', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Lỗi cấu hình', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Lỗi thiết kế', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Quản lý các bản vá và cập nhật phần mềm là phần việc thuộc lớp bảo vệ nào trong mô hình tổng thể đảm bảo an toàn hệ thống thông tin?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Lớp an ninh mạng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Lớp an ninh hệ thống', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Lớp an ninh cơ quan/tổ chức', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Lớp an ninh hệ điều hành và phần mềm', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Khi khai thác lỗi tràn bộ đệm, tin tặc thường chèn mã độc, gây tràn và ghi đè để sửa đổi thành phần nào sau đây của bộ nhớ Ngăn xếp để chuyển hướng nhằm thực hiện mã độc của mình:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Các biển đầu vào của hàm', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Bộ đệm hoặc biển cục bộ của hàm', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Con trỏ khung ngăn xếp (sfp)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Địa chỉ trở về của hàm', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Khác biệt cơ bản của vi rút và sâu là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Vi rút có khả năng tự lây lan mà không cần tương tác của người dùng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Sâu có khả năng tự lây lan mà không cần tương tác của người dùng', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Sâu Có khả năng phá hoại lớn lơn', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Vi rút có khả năng phá hoại lớn lớn', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Dạng tấn công gây ngắt quãng dịch vụ hoặc kênh truyền thông cho người dùng bình thường là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Interceptions', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Fabrications', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Interruptions', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Modifications', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tấn công nghe lén là kiểu tấn công:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Thụ động', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Chủ động', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Chiếm quyền điều khiển', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Chủ động và bị động', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Dạng tấn công chặn bắt thông tin truyền trên mạng để sửa đổi hoặc lạm dụng là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Fabrications', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Modifications', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Interruptions', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Interceptions', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Có thể phòng chống tấn công Smurf bằng cách cấu hình các máy và router không trả lời...', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Các yêu cầu ICMP hoặc các yêu cầu phát quảng bá', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Các yêu cầu TCP hoặc các yêu cầu phát quảng bá', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Các yêu cầu UPD hoặc các yêu cầu phát quảng bá', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Các yêu cầu HTTP hoặc các yêu cầu phát quảng bá', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Đâu là một kỹ thuật tấn công Dos?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'UDP Ping', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'DNS Cache Poisoning', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Smurf', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'DNS spoofing', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Dạng tấn công giả mạo thông tin thường để đánh lừa người dùng thông thường là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Modifications', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Fabrications', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Interruptions', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Interceptions', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Kỹ thuật tấn công Smurf sử dụng giao thức ICMP và Cơ chế gửi…', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Unicast', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Multicast', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Anycast', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Broadcast', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Trong tấn công DDoS phản chiếu hay gián tiếp, có sự tham gia của một số lượng lớn máy chủ trên mạng Internet không bị tin tặc chiếm quyền điều khiển. Các máy chủ này được gọi là…', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Reflectors', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Injectors', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Requesters', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Forwarders', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Pharming là kiểu tấn công vào…', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Máy chủ web', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Máy chủ cơ sở dữ liệu của trang web', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Máy chủ và máy khách web', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Máy khách/trình duyệt web', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Đây là một công cụ kiểm tra lỗ hổng tấn công chèn mã SQL trên các website:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'SQLCheck', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'SQL Server', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'SQLmap', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'SQLite', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Khác biệt cơ bản giữa tấn công DoS và DDoS là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Phạm vi tấn công', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Mức độ gây hại', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Kỹ thuật tấn công', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tần suất tấn công', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mục đích chính của tấn công giả mạo địa chỉ IP là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Để vượt qua các hệ thống IPS và IDS', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Để vượt qua các hàng rào kiểm soát an ninh', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Để đánh cắp các dữ liệu nhạy cảm trên máy trạm', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Để đánh cắp các dữ liệu nhạy cảm trên máy chủ', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Các máy tính ma/máy tính bị chiếm quyền điều khiển thường được tin tặc sử dụng để...', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Gửi các yêu cầu tấn công chèn mã', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Đánh cắp dữ liệu từ máy chủ cơ sở dữ liệu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Gửi thư rác, thư quảng cáo', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Thực hiện tấn công tràn bộ đệm.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Trong dạng tấn công vào mật khẩu dựa trên từ điển, tin tặc đánh cắp mật khẩu của người dùng bằng cách:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Tìm mật khẩu trong từ điển các mật khẩu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Thử các từ có tần suất sử dụng cao làm mật khẩu trong từ điển', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Vét cận các mật khẩu có thể có', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Lắng nghe trên đường truyền để đánh cắp mật khẩu', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một trong các phương thức lây lan thường gặp của sâu mạng là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Lây lan thông qua sao chép các file', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Lây lan thông qua dịch vụ POP', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Lây lan thông qua khả năng thực thi từ xa', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Lây lan thông qua Microsoft Office', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Đây là một kỹ thuật tấn công Dos?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'SYN requests', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'DNS spoofing', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'IP spoofing', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Ping of death', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tấn công từ chối dịch vụ (Dos - Denial of Service Attacks) là dạng tấn công có khả năng...', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Gây hư hỏng phần cứng máy chủ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Cản trở người dùng hợp pháp truy nhập các tài nguyên hệ thống', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Đánh cắp dữ liệu trong hệ thống', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Cản trở người dùng hợp pháp truy nhập các file dữ liệu của hệ thống', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mật khẩu an toàn trong thời điểm hiện tại là mật khẩu có:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Chứa các ký tự từ nhiều dạng ký tự', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Khả năng chống tấn công phát lại và chứa các ký tự từ nhiều dạng ký tự', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Độ dài từ 8 ký tự trở lên, gồm chữ cái hoa, thường, chữ số và ký tự đặc biệt', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Độ dài lớn hơn hoặc bằng 8 ký tự', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một trong các mối đe dọa an toàn thông tin thường gặp là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Phần mềm nghe lén', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Phần mềm quảng cáo', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Phần mềm phá mã', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Phần mềm độc hại', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Nguy cơ cao nhất mà một cuộc tấn công chèn mã SQL có thể gây ra cho một hệ thống là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Đánh cắp các thông tin trong cơ sở dữ liệu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Chèn, xóa hoặc sửa đổi dữ liệu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Vượt qua các khâu xác thực người dùng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Chiếm quyền điều khiển hệ thống', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một trong các biện pháp có thể sử dụng để phòng chống tấn công người đứng giữa là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Sử dụng các hệ thống IPS/IDS', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Sử dụng chứng chỉ số để xác thực thông tin nhận dạng các bên', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Sử dụng mã hóa để đảm bảo tính bí mật các thông điệp truyền', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Sử dụng tường lửa để ngăn chặn', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Macro viruses là loại viruses thường lây nhiễm vào…', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Các file tài liệu của bộ phần mềm Open Office', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Các file tài liệu của bộ phần mềm Microsoft Exchange', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Các file tài liệu của bộ phần mềm Microsoft SQL', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Các file tài liệu của bộ phần mềm Microsoft Office', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tấn công kiểu Social Engineering là dạng tấn công khai thác yếu tố nào sau đây trong hệ thống?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Máy trạm', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Người dùng', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Máy chủ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Hệ điều hành & ứng dụng', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Câu lệnh SQL nào tin tặc thường sử dụng trong tấn công chèn mã SQL để đánh cắp các thông tin trong cơ sở dữ liệu?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'UNION INSERT', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'UNION SELECT', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'SELECT UNION', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'INSERT SELECT', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Phishing là một dạng của loại tấn công sử dụng...', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Kỹ thuật chèn mã', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Kỹ thuật giả mạo địa chỉ IP', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Kỹ thuật gây tràn bộ đệm', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Kỹ thuật xã hội', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Các dạng phần mềm độc hại (malware) có khả năng tự nhân bản gồm:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Virus, zombie, spyware', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Virus, trojan, zombie', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Virus, worm, trojan', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Virus, worm, zombie', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một trong các cách virus thường sử dụng để lây nhiễm vào các chương trình khác là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Ẩn mã của virus', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Thay thế các chương trình', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Xáo trộn mã của virus', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Sửa đổi các chương trình', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Trong tấn công DDoS phản chiếu hay gián tiếp, có sự tham gia của một số lượng lớn máy chủ trên mạng Internet không bị tin tặc chiếm quyền điều khiển. Các máy chủ này được gọi là...', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Reflectors', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Requesters', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Forwarders', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Injectors', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mục đích chính của tấn công giả mạo địa chỉ IP là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Để vượt qua các hệ thống IPS và IDS', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Để vượt qua các hàng rào kiểm soát an ninh', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Để đánh cắp các dữ liệu nhạy cảm trên máy trạm', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Để đánh cắp các dữ liệu nhạy cảm trên máy chủ', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Trojan horses là dạng phần mềm độc hại thường giành quyền truy nhập vào các file của người dùng khai thác cơ chế điều khiển truy nhập...', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'МАС', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Role-Based', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Rule-Based', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'DAC', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'PGP đảm bảo tính bí mật thông điệp bằng cách sử dụng:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Mã hóa khóa bất đối xứng sử dụng khóa phiên', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Mã hóa khóa đối xứng sử dụng khóa phiên', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Mã hóa khóa bất đối xứng sử dụng khóa công khai', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Mã hóa khóa đối xứng sử dụng khóa công khai', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Số lượng thao tác trong mỗi vòng xử lý của hàm băm MD5 là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '14', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '16', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '18', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '12', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Giao thức SSL sử dụng giao thức con SSL Handshake để khởi tạo phiên làm việc. SSL Handshake thực hiện việc trao đổi các khóa phiên dùng cho phiên làm việc dựa trên:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Chữ ký số', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Mã hóa khóa bí mật', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Mã hóa khóa công khai', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Chứng chỉ số', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Các thuộc tính cơ bản của chứng chỉ số khóa công khai (Public key digital certificate) gồm:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Số nhận dạng, khóa riêng của chủ thể, chữ ký của nhà cung cấp CA', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Khóa công khai của chủ thể, thông tin địa chỉ chủ thể, thuật toán chữ ký sử dụng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Số nhận dạng, khóa riêng của chủ thể, thông tin định danh chủ thể', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Khóa công khai của chủ thể, thông tin định danh chủ thể, chữ ký của nhà cung cấp (CA)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một hệ mã hóa (cryptosystem) được cấu thành từ hai thành phần chính gồm:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Phương pháp mã hóa và chia khối', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Giải thuật mã hóa và ký số', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Phương pháp mã hóa và không gian khóa', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Giải thuật mã hóa và giải mã', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Đây là một phương pháp mã hóa', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'OR', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'AND', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'NOT', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'XOR', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Kích thước khối dữ liệu xử lý của giải thuật mã hóa AES là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '160 bit', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '64 bit', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '192 bít', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '128 bit', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Điểm khác nhau chính giữa hai loại hàm băm MDC và MAC là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'MDC là loại hàm băm không khóa, còn MAC là loại hàm băm có khóa', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'MDC có khả năng chống đụng độ cao hơn MAC', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'MDC an toàn hơn MAC', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'MAC an toàn hơn MDC', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Chữ ký số (sử dụng riêng) thường được sử dụng để đảm bảo thuộc tính nào sau đây của thông điệp truyền đưa:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Tính bí mật', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Tính không chối bỏ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Tính sẵn dùng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tính toàn vẹn', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Trong hệ chữ ký số RSA, việc tạo chữ ký số cho một thông điệp cần sử dụng một khóa. Khóa đó là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Khóa riêng của người nhận', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Khóa công khai của người nhận', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Khóa công khai của người gửi', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Khóa riêng của người gửi', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một trong các điểm yếu của các hệ mã hóa khóa công khai là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Khó cài đặt trên thực tế', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Khó khăn trong quản lý và phân phối khóa', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Tốc độ chậm', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Độ an toàn thấp', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Phát biểu nào sau đây về chữ ký số là chính xác:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Chữ ký số là một chuỗi dữ liệu được tạo ra bằng cách mã hóa thông điệp sử dụng khóa bí mật', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Chữ ký số là một chuỗi dữ liệu liên kết với một thông điệp và thực thể tạo ra thông điệp', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Chữ ký số được sử dụng để đảm bảo tính bí mật và toàn vẹn thông điệp', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Chữ ký số được sử dụng để đảm bảo tính bí mật, toàn vẹn và xác thực thông điệp', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Hai thuộc tính cơ bản quan trọng nhất của một hàm băm là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Nén và một chiều', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dễ tính toán và có đầu ra cố định', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Một chiều và đầu ra cố định', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Nén và dễ tính toán', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Độ an toàn của hệ mật mã RSA dựa trên...', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Độ phức tạp cao của giải thuật RSA', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Chi phí tính toán lớn', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Tính khó của việc phân tích số nguyên rất lớn', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Khóa có kích thước lớn', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Khi sinh cặp khóa RSA, các số nguyên tố p và q nên được chọn với kích thước…', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'p càng lớn càng tốt', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Bằng khoảng một nửa kích thước của modulo n', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Không có yêu cầu về kích thước của p và q', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'q càng lớn càng tốt', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tìm phát biểu đúng về mã hóa khóa bất đối xứng (Asymmetric key cryptography):', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'An toàn hơn mã hóa khóa bí mật', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Sử dụng một khóa quá trình mã hóa và một khóa khác cho giải mã', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Chỉ sử dụng kỹ thuật mã hóa khối', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Sử dụng một khóa chung cho cả quá trình mã hóa và giải mã', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tìm phát biểu đúng về mã hóa khóa đối xứng (Symmetric key cryptography):', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Sử dụng một khóa chung cho cả quá trình mã hóa và giải mã', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Sử dụng một khóa quá trình mã hóa và một khóa khác cho giải mã', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'An toàn hơn mã hóa khóa công khai', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Chỉ sử dụng kỹ thuật mã hóa khối', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Sử dụng kết hợp chứng chỉ số khóa công khai và chữ ký số có thể đảm bảo:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Xác thực thực thể và toàn vẹn thông tin truyền', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Xác thực thực thể và bí mật thông tin truyền', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Bí mật và xác thực nguồn gốc thông tin truyền', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Bí mật và toàn vẹn thông tin truyền', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Số lượng vòng lặp chính thực hiện xáo trộn dữ liệu theo hàm Feistel (F) trong giải thuật DES là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '14', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '16', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '18', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '20', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Các hộp thay thế s-box trong giải thuật DES có số bít đầu vào và đầu ra tương ứng là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Vào 4 bít và ra 4 bít', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Vào 6 bít và ra 6 bít', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Vào 8 bít và ra 6 bít', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Vào 6 bít và ra 4 bít', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một trong các ứng dụng phổ biến của các hàm băm là để tạo chuỗi...', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'CheckError', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'CheckTotal', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'CheckNum', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Checksum', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'PGP đảm bảo tính bí mật thông điệp bằng cách sử dụng:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Mã hóa khóa bất đối xứng sử dụng khóa công khai', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Mã hóa khóa đối xứng sử dụng khóa phiên', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Mã hóa khóa đối xứng sử dụng khóa công khai', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Mã hóa khóa bất đối xứng sử dụng khóa phiên', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Trong quá trình xử lý thông điệp đầu vào tạo chuỗi băm, số lượng vòng xử lý của hàm băm SHA1 là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '80', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '90', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '60', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '70', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Giải thuật mã hóa AES được thiết kế dựa trên…', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'mạng hoán vị-vernam', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'mạng xor-thay thế', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'mạng hoán vị-thay thế', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'mạng hoán vị-xor', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một trong các điểm yếu của các hệ mã hóa khóa đối xứng là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Chi phí tính toán lớn', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Khó khăn trong quản lý và phân phối khóa', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Độ an toàn thấp', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Khó khăn trong cài đặt và triển khai hệ thống', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Số vòng lặp chuyển đổi cần thực hiện để chuyển bản rõ thành bản mã của giải thuật mã hóa AES với khóa 192 bít là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '10', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '12', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '16', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '14', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Phát biểu nào sau đây về chữ ký số là chính xác:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Chữ ký số là một chuỗi dữ liệu được tạo ra bằng cách mã hóa thông điệp sử dụng khóa bí mật', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Chữ ký số là một chuỗi dữ liệu liên kết với một thông điệp và thực thể tạo ra thông điệp', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Chữ ký số được sử dụng để đảm bảo tính bí mật, toàn vẹn và xác thực thông điệp', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Chữ ký số được sử dụng để đảm bảo tính bí mật và toàn vẹn thông điệp', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một trong các ứng dụng phổ biến của các hàm băm một chiều là để...', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Mã hóa thẻ tín dụng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Mã hóa địa chỉ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Mã hóa mật khẩu', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Mã hóa tên tài khoản', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Giao thức SSL sử dụng giao thức con SSL Handshake để khởi tạo phiên làm việc. SSL Handshake thực hiện việc xác thực thực thể dựa trên:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Chứng chỉ số khóa công khai', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Mã hóa khóa bí mật', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Mã hóa khóa công khai', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Chữ ký số', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'PGP đảm bảo tính xác thực thông điệp bằng cách:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Mã hóa/giải mã thông điệp', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Sử dụng hàm băm có khóa MAC', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Sử dụng hàm băm không khóa MDC', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tạo và kiểm tra chữ ký số', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Nguyên tắc bảo mật tài nguyên của mô hình Bell-La Padula là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Đọc lên và ghi lên', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Đọc xuống và ghi xuống', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Đọc xuống và ghi lên', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Đọc lên và ghi xuống', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tính bảo mật của kỹ thuật điều khiển truy nhập sử dụng mật khẩu dựa trên:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Tần suất sử dụng mật khẩu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Kích thước của mật khẩu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Độ khó đoán và tuổi thọ của mật khẩu', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Số loại ký tự dùng trong mật khẩu', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Phát hiện tấn công, xâm nhập dựa trên bất thường có tiềm năng phát hiện các loại tấn công, xâm nhập mới là do:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Không yêu cầu biết trước thông tin về chúng', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Đã có chữ ký của các tấn công, xâm nhập mới', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Các tấn công, xâm nhập mới thường dễ nhận biết', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Không yêu cầu xây dựng cơ sở dữ liệu các chữ ký', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một trong các điểm yếu làm giảm hiệu quả của phát hiện tấn công, xâm nhập dựa trên bất thường là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Không có khả năng ngăn chặn tấn công, đột nhập', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Không có khả năng phát hiện các cuộc tấn công Dos', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Tỷ lệ cảnh báo sai cao', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Không có khả năng phát hiện tấn công, xâm nhập mới', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Phát hiện tấn công, xâm nhập dựa trên bất thường dựa trên giá thiết:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Các hành vi tấn công, xâm nhập thường có quan hệ chặt chẽ với các hành vi bất thường', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Các hành vi tấn công, xâm nhập gây ngắt quãng dịch vụ cung cấp cho người dùng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Các hành vi tấn công, xâm nhập có quan hệ chặt chẽ với các dịch vụ được cung cấp', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Các hành vi tấn công, xâm nhập gây tổn hại nghiêm trọng cho hệ thống', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Ưu điểm của điều khiển truy nhập dựa trên các đặc điểm sinh trắc học là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Bảo mật cao và độ ổn định cao', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Bảo mật cao và chi phí thấp', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Bảo mật cao và luôn đi cùng với chủ thể', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Bảo mật cao và được hỗ trợ rộng rãi', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một ưu điểm của tường lửa có trạng thái so với tường lửa không trạng thái là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Lọc nội dung gói tốt hơn', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Nhận dạng được các dạng tấn công và các phần mềm độc hại', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Chạy nhanh hơn', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Phân biệt được các gói tin thuộc về các kết nối mạng khác nhau', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Các phương pháp xử lý, phân tích dữ liệu và mô hình hoá trong phát hiện tấn công, xâm nhập dựa trên bất thường, gồm:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Thống kê, học máy, khai phá dữ liệu', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Học máy, khai phá dữ liệu, agents', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Thống kê, học máy, đồ thị', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Thống kê, đối sánh chuỗi, đồ thị', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Phát biểu nào sau đây đúng với cơ chế điều khiển truy nhập dựa trên vai trò - RBAC:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'RBAC cho phép người tạo ra đối tượng có thể cấp quyền truy nhập cho người dùng khác', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'RBAC là cơ chế điều khiển truy nhập được sử dụng rộng rãi nhất', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'RBAC cấp quyền truy nhập dựa trên vai trò của người dùng trong tổ chức', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'RBAC cấp quyền truy nhập dựa trên tính nhạy cảm của thông tin và chính sách quản trị', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Phát biểu nào sau đây đúng với cơ chế điều khiển truy nhập DAC:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'DAC cho phép người tạo ra đối tượng có thể cấp quyền truy nhập cho người dùng khác', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'DAC cấp quyền truy nhập dựa trên tính nhạy cảm của thông tin và chính sách quản trị', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'DAC là cơ chế điều khiển truy nhập được sử dụng rộng rãi nhất', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'DAC quản lý quyền truy nhập chặt chẽ hơn các cơ chế khác', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Đâu là một công cụ có khả năng rà quét các lỗ hổng chèn mã SQL cho các trang web?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'nmap', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Microsoft Baseline Security Analyzer', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Nessus vulnerability scanner', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Acunetix Web Vulnerability Scanner', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Danh sách điều khiển truy nhập ACL thực hiện việc quản lý quyền truy nhập đến các đối tượng cho người dùng bằng cách:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Các quyền truy nhập vào đối tượng cho mỗi người dùng được quản lý trong một ma trận', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Các quyền truy nhập vào đối tượng cho mỗi người dùng được quản lý riêng rẽ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Mỗi người dùng được gán một danh sách các đối tượng kèm theo quyền truy nhập', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Mỗi đối tượng được gán một danh sách người dùng kèm theo quyền truy nhập', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tường lửa không thể chống lại...', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Các hiểm họa từ bên trong', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Các hiểm họa từ bên ngoài', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Tấn công giả mạo địa chỉ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tấn công từ mạng Internet', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Sự khác biệt chính giữa hệ thống ngăn chặn xâm nhập (IPS) và hệ thống phát hiện xâm nhập (IDS) là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'IPS phát hiện xâm nhập hiệu quả hơn', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'IPS có khả năng chủ động ngăn chặn xâm nhập', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'IDS phát hiện xâm nhập hiệu quả hơn', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'IDS có khả năng chủ động ngăn chặn xâm nhập', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tường lửa lọc gói có thể lọc các thông tin nào trong gói tin?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Chỉ các thông tin trong header của gói tin', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Chỉ các thông tin trong payload của gói tin', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Chỉ lọc địa chỉ IP trong gói tin', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Cả thông tin trong header và payload của gói tin', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Không nên sử dụng nhiều hơn 1 phần mềm quét virus chạy ở chế độ quét theo thời gian thực trên một máy tính vì:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Các phần mềm quét virus xung đột với nhau', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Các phần mềm quét virus không thể hoạt động', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Các phần mềm quét virus chiếm nhiều tài nguyên', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Các phần mềm quét virus tấn công lẫn nhau', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Phát biểu nào sau đây đúng với cơ chế điều khiển truy nhập bắt buộc MAC:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'MAC cho phép người tạo ra đối tượng có thể cấp quyền truy nhập cho người dùng khác', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'MAC quản lý quyền truy nhập chặt chẽ hơn các cơ chế khác', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'MAC cấp quyền truy nhập dựa trên tính nhạy cảm của thông tin và chính sách quản trị', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'MAC là cơ chế điều khiển truy nhập được sử dụng rộng rãi nhất', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Đâu là một loại tường lửa?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Server gateway', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Application server', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Application-level gateway', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Gateway server', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Ví điện tử Paypal là một dạng...', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Khóa mã (encrypted key)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'The ATM', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Thẻ bài (token)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Thẻ thông minh (smart card)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Dạng xác thực sử dụng các thông tin nào dưới đây đảm bảo độ an toàn cao hơn?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Thẻ ATM và tên truy nhập', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Tên truy nhập và số PIN', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Thẻ ATM và số PIN', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tên truy nhập và mật khẩu', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một trong các dạng khóa mã (encrypted keys) được sử dụng rộng rãi trong điều khiển truy nhập là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'E-token', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Chứng chỉ số khóa công khai', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'The ATM', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Mobile-token', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tại sao một hệ thống phát hiện xâm nhập dựa trên chữ ký không thể phát hiện các tấn công, xâm nhập mới?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Do chữ ký của chúng chưa tồn tại trong hệ thống', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Do các tấn công, xâm nhập mới không có chữ ký', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Do các tấn công, xâm nhập mới không gây ra bất thường', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Do các tấn công, xâm nhập mới chỉ gây thiệt hại nhỏ', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Ưu điểm của thẻ bài (token) so với thẻ thông minh (smart card) trong điều khiển truy nhập là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Có cơ chế xác thực mạnh hơn', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Có cơ chế xác thực đa dạng hơn', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Được sử dụng rộng rãi hơn', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Có chi phí rẻ hơn', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Phương pháp xác thực nào dưới đây có thể cung cấp khả năng xác thực có độ an toàn cao nhất?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Sử dụng Smartcard', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Sử dụng vân tay', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Sử dụng chứng chỉ số', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Sử dụng mật khẩu', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Đâu là các tính năng của kiểm soát truy nhập sử dụng tường lửa?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Kiểm soát dịch vụ và các phần mềm', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Kiểm soát người dùng và tin tặc', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Kiểm soát dịch vụ và hướng', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Kiểm soát virus và các malware khác', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Ba cơ chế điều khiển truy nhập thông dụng gồm:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'DAC, MAC và RRAC', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'DAC, BAC và RBAC', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'DAC, MAC và BAC', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'DAC, MAC và RBAC', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mục đích chính của điều khiển truy nhập là để đảm bảo các thuộc tính an ninh của thông tin, hệ thống và các tài nguyên, gồm:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Tính bảo mật, tính toàn vẹn và tính xác thực', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Tính bí mật, tính toàn vẹn và tính xác thực', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Tính bảo mật, tính toàn vẹn và tính sẵn dùng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tính bí mật, tính toàn vẹn và tính sẵn dùng', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Số lượng nhân tố (factor) xác thực sử dụng trong điều khiển truy nhập dựa trên thẻ thông minh là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '1', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '3', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '2', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '4', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một nhiệm vụ chính của các hệ thống IDS/IPS là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Truy tìm và tấn công ngược lại hệ thống của tin tặc', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Giám sát lưu lượng mạng hoặc các hành vi trên một hệ thống để nhận dạng các dấu hiệu của tấn công, xâm nhập', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Giám sát lưu lượng mạng nhận dạng các dấu hiệu của tấn công, xâm nhập', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Giám sát các hành vi trên một hệ thống để nhận dạng các dấu hiệu của tấn công, xâm nhập', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Hai dịch vụ quan trọng nhất của một hệ thống điều khiển truy nhập là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Authentication và Authorization', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Authenticator và Administrator', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Administrator và Authorization', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Authentication và Administrator', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tìm phát biểu đúng về phát hiện xâm nhập dựa trên chữ ký và phát hiện xâm nhập dựa trên bất thường:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Phát hiện xâm nhập dựa trên chữ ký thường có tỷ lệ phát hiện đúng cao hơn', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Tính bảo mật, tính toàn vẹn và tính xác thực', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Tính bảo mật, tính toàn vẹn và tính sẵn dùng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tính bí mật, tính toàn vẹn và tính sẵn dùng', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tìm phát biểu đúng về dịch vụ xác thực trong điều khiển truy nhập:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Là quá trình xác minh tính chân thực của thông tin nhận dạng người dùng cung cấp', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Là quá trình xác minh nhận dạng của chủ thể', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Là quá trình xác minh các thông tin nhận dạng của chủ thể yêu cầu truy nhập đối tượng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Là quá trình xác minh nhận dạng của người dùng', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Loại tấn công nào sau đây chiếm quyền truy nhập đến tài nguyên lợi dụng cơ chế điều khiển truy nhập DAC?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Spoofing', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Trojan horse', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Man in the middle', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Phishing', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Đâu là tên viết đúng của Hệ thống phát hiện đột nhập/xâm nhập?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Intrusion Detector System', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Intrusion Detecting System', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Intrusion Detection System', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Instruction Detection System', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một trong các nhược điểm chính của điều khiển truy nhập dựa trên các đặc điểm sinh trắc học là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Không được hỗ trợ rộng rãi', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Chi phí đắt', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Khó sử dụng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Công nghệ phức tạp', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Ưu điểm của mật khẩu một lần (OTP-One Time Password) so với mật khẩu truyền thống là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Chống được tấn công từ điển', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Chống được tấn công vét cạn', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Chống được tấn công phá mã', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Chống được tấn công phát lại', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Kỹ thuật tấn công SYN Floods khai thác điểm yếu trong khâu nào trong bộ giao thức TCP/IP?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Bắt tay 3 bước', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Bắt tay 2 bước', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Xác thực người dùng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Truyền dữ liệu', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tấn công từ chối dịch vụ (Dos - Denial of Service Attacks) là dạng tấn công có khả năng…', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'a. Cản trở người dùng hợp pháp truy nhập các file dữ liệu của hệthống', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'b. Cản trở người dùng hợp pháp truy nhập các tài nguyên hệ thống', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'c. Đánh cắp dữ liệu trong hệ thống', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'd. Gây hư hỏng phần cứng máy chủ', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một trong các mối đe dọa an toàn thông tin thường gặp là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'a.Phần mềm độc hại', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'b. Phần mềm quảng cáo', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'c. Phần mềm nghe lén', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'd Phần mềm phá mã', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Các dạng phần mềm độc hại (malware) có khả năng tự nhân bản gồm:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'a. Virus, zombie, spyware', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'b. Virus, trojan, zombie', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'c. virus, worm, zombie', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'd. Virus, worm, trojan', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Pharming là kiểu tấn công vào...', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'a. Máy khách/trình duyệt web', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'b. Máy chủ và máy khách web', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'c. Máy chủ web.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'd.  Máy chủ cơ sở dữ liệu của trang web', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Các máy tính ma/máy tính bị chiếm quyền điều khiển thường được tin tặc sử dụng để...', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'a. Gửi các yêu cầu tấn công chèn mã', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'b. Đánh cấp dữ liệu từ máy chủ cơ sở dữ liệu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'c. Thực hiện tấn công tràn bộ đệm', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'd. Gửi thư rác, thư quảng cáo', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Đâu là một kỹ thuật tấn công DoS?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'a. DNS spoofing', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'b. UDP Ping', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'c. Smurf', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'd. DNS Cache Poisoning', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Đâu là một biện pháp phòng chống tấn công SYN Floods?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'a. SYN Firewall', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'b. SYN IDS', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'c. SYN Proxy', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'd. SYN Cache', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Kỹ thuật tấn công Smurf sử dụng giao thức ICMP và cơ chế gửi…', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'a. Multicast', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'b. Anycast', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'c. Broadcast', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'd. Unicast', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tấn công nghe lén là kiểu tấn công:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'a. Chủ động và bị động', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'b. Thụ động', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'c. Chủ động', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'd. Chiếm quyền điều khiến', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Trong dạng tấn công vào mật khẩu dựa trên từ điển, tin tặc đánh cấp mật khẩu của người dùng bằng cách:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'a. vét cạn các mật khẩu có thể có', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'b. Tìm mật khẩu trong từ điển các mật khẩu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'c. Lắng nghe trên đường truyền để đánh cấp mật khẩu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'd. Thử các từ có tần suất sử dụng cao làm mật khẩu trong từ điển', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Dạng tấn công chặn bắt thông tin truyền trên mạng để sửa đổi hoặc lạm dụng là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'a. Fabrications', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'b. Modifications', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'c. Interruptions', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'd. Interceptions', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mật khẩu an toàn trong thời điểm hiện tại là mật khẩu có :', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'a. Khả năng chống tấn công phát lại và chứa các ký tự từ nhiều dạng kýtự', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'b. Chứa các ký tự từ nhiều dạng ký tự', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'c.  Độ dài lớn hơn hoặc bằng 8 ký tự', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'd. Độ dài từ 8 ký tự trở lên , gồm chữ cái hoa , thường , chữ số và kýtự đặc biệt', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tấn công bằng mã độc có thể gồm:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'a. Chèn mã XSS, CSRF', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'b. Chèn mã SQL', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'c. Tràn bộ đệm', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'd.SQLi , XSS , CSRF và Buffer overflow', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tấn công kiểu Social Engineering có thể cho phép tin tặc :', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'a Phá hỏng máy chủ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'b. Đánh cắp toàn bộ cơ sở dữ liệu trên máy chủ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'c. Đánh cắp thông tin nhạy cảm của người dùng', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'd.  Đánh cắp thông tin nhạy cảm trong cơ sở dữ liệu trên máy chủ', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Khác biệt cơ bản giữa tấn công DoS và DDoS là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'a.  Phạm vi tấn công', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'b. Tần suất tấn công', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'c. Mức độ gây hại', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'd.  Kỹ thuật tấn công', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một trong các cách virus thường sử dụng để lây nhiễm vào các chương trình khác là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'a. Thay thế các chương trình', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'b. Xáo trộn mã của virus', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'c. Sửa đổi các chương trình', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'd.  Ăn mã của virus', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Trojan horses là dạng phần mềm độc hại thường giành quyền truy nhập vào các file của người dùng khai thác Cơ chỉ điều khiển truy nhập.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'a. Rule - Based', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'b. DAC', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'c. MAC', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'd. Role - Based', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tại sao việc sử dụng thủ tục cơ sở dữ liệu (Stored procedure ) là một trong các biện pháp hiệu quả để ngăn chặn triệt để tấn công chèn mã SQL ?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'a. Thủ tục cơ sở dữ liệu có khả năng cẩm chèn mã', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'b. Thủ tục cơ sở dữ liệu độc lập với các ứng dụng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'c. Thủ tục cơ sở dữ liệu cho phép tách mã lệnh SQL khỏi dữ liệu ngườidùng', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'd. Thủ tục cơ sở dữ liệu lưu trong cơ sở dữ liệu và chạy nhanh hơn câulệnh trực tiếp', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Có thể phòng chống tấn công Smurf bằng cách cấu hình các máy và router không trả lời.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'a. các yêu cầu UPD hoặc các yêu cầu phát quảng bá', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'b. các yêu cầu TCP hoặc các yêu cầu phát quảng bá', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'c. các yêu cầu HTTP hoặc các yêu cầu phát quảng bá', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'd. các yêu cầu ICMP hoặc các yêu cầu phát quảng bá', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Đây là một công cụ kiểm tra lỗ hổng tấn công chèn mã SQL trên các website:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'a. SQLmap', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'b. SQLite', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'c. SQLCheck', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'd. SQL Server', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một trong các biện pháp hiệu quả để phòng chống macro viruses là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'a. Sử dụng IPS/IDS.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'b. Sử dụng tường lửa', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'c.Cấm tự động thực hiện macro trong Microsoft Office', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'd.Cấm tự động thực hiện macro trong Microsoft Exchange', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Đâu là một kỹ thuật tấn công DoS?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'a. SYN requests', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'b. IP spoofing', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'c.DNS spoofing', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'd.Ping of death', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Đâu là một trong các biện pháp chống tấn công khai thác lỗi tràn bộ đệm?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'a. Sử dụng công nghệ xác minh mạnh', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'b. Sử dụng cơ chế cấm thực hiện mã trong dữ liệu', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'c.Sử dụng tường lửa', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'd.Sử dụng các kỹ thuật mật mã', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tấn công chặn bắt thường liên quan đến việc nghe lén trên đường truyền và chuyển hướng thông tin để sử dụng trái phép?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Fabrications', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Interceptions', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Interruptions', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Modifications', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tấn công gây ngắt quãng làm ngắt, hoặc chậm kênh truyền thông, hoặc làm quá tải hệ thống, ngăn cản việc truy nhập dịch vụ của người dùng hợp pháp:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Fabrications', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Interceptions', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Interruptions', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Modifications', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Trong các vùng hạ tầng CNTT, vùng nào có các lỗ hổng trong quản lý phần mềm ứng dụng của máy chủ?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'vùng máy trạm', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'vùng mạng LAN-to-WAN', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'vùng truy nhập từ xa', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'vùng hệ thống và ứng dụng', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Trong các vùng hạ tầng CNTT, vùng nào có nhiều mối đe dọa nguy cơ nhất?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'vùng người dùng', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'vùng máy trạm', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'vùng mạng LAN', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'vùng mạng LAN-to-WAN', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Trong các vùng hạ tầng CNTT, vùng nào dễ bị tấn công DoS, DDoS nhất?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'vùng người dùng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'vùng mạng LAN', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'vùng mạng WAN', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'vùng mạng LAN-to-WAN', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'An toàn thông tin được chia làm những thành phần nào?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'an toàn máy tính và dữ liệu, an toàn mạng, quản lý an toàn thông tin', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'an toàn mạng, quản lý an toàn thông tin, chính sách an toàn thông tin', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'an toàn mạng, an toàn máy tính và dữ liệu, chính sách an toàn thông tin', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'an toàn máy tính và dữ liệu, quản lý an toàn thông tin, chính sách an toàn thông tin', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Nếu dữ liệu bị sửa đổi thì đã vi phạm yêu cầu gì?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'toàn vẹn, sẵn dùng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'bí mật, sẵn dùng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'toàn vẹn, bí mật', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'an toàn. bí mật', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'An toàn thông tin gồm các lĩnh vực nào?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'an toàn cntt, đảm bảo thông tin', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'đảm bảo thông tin, an toàn mạng', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Trong tấn công khai thác lỗi tràn bộ đệm tin tắc thường sử dụng một số lệnh NOP (No Operation) ở phần đầu của mã tấn công. Mục đích của việc này là gì:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'tăng khả năng gây tràn bộ đệm', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Tăng khả năng gây lỗi chương trình', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Tăng khả năng phá hoại của mã tấn công', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tăng khả năng mã tấn công được thực hiện', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Sâu SQL Slammer được phát hiện vào năm nào?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '2002', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '1997', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '2007', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '2003', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Dạng tấn công chèn mã được tin tặc sử dụng phổ biến trên các trang web nhắm đến các cơ sở dữ liệu là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Tấn công chèn mã SQL', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Tấn công chèn mã XSS', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Tấn công chèn mã CSRF', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tấn công chèn mã HTML', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Các lỗ hổng bảo mật thường tồn tại nhiều nhất trong thành phần nào của hệ thống:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Các thành phần phần cứng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Các ứng dụng', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Hệ điều hành', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Các dịch vụ mạng', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Lỗi tràn bộ đệm là lỗi trong khâu:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Quản trị phần mềm', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Lập trình phần mềm', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Thiết kế phần mềm', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Kiểm thử phần mềm', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Đâu là một trong các biện pháp phòng chống tấn công khai thác lỗi tràn bộ đệm?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Sử dụng các thư viện lập trình an toàn //or sử dụng cơ chế cấm thựchiện mã trong dữ liệu (DEP)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Sử dụng tường lửa', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Sử dụng các kỹ thuật mật mã', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Sử dụng công nghệ xác thực mạnh', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một điểm yếu điển hình trong hệ thống điều khiển truy cập là việc sử dụng mật khẩu dễ đoán hoặc mật khẩu được lưu ở dạng rõ. Đây là điểm yếu thuộc khâu:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Quản trị', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Xác thực', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Trao quyền', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Xác thực và Trao quyền', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Lỗ hổng bảo mật (Security vulnerability) là một điểm yếu tồn tại trong một hệ thống cho phép tin tặc:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Khai thác nhằm đánh cắp các thông tin trong hệ thống', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Khai thác nhằm chiếm quyền điều khiển hệ thống', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Khai thác, tấn công phá hoại và gây tê liệt hệ thống', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Khai thác gây tổn hại đến các thuộc tính an ninh của hệ thống đó', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Trong tấn công khai thác lỗi tràn bộ đệm, tin tặc thường sử dụng shellcode. Shellcode đó là dạng:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Mã Java', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Mã Hợp ngữ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Mã C/C++', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Mã máy', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tấn công kiểu Social Engineering có thể cho phép tin tặc:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Đánh cắp thông tin nhạy cảm trong cơ sở dữ liệu trên máychủ', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Đánh cắp toàn bộ cơ sở dữ liệu trên máy chủ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Đánh cắp thông tin nhạy cảm của người dùng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Phá hỏng máy chủ', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một trong các mối đe dọa an toàn thông tin thường gặp là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Phần mềm nghe lén', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Phần mềm phá mã', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Phần mềm quảng cáo', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Phần mềm độc hại', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tấn công kiểu Social Engineering là dạng tấn công khai thác yếu tố nào sau đây trong hệ thống?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Người dùng', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Hệ điều hành & ứng dụng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Máy trạm', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Máy chủ', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Dạng tấn công giả mạo thông tin thường để đánh lừa người dùng thông thường là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Interruptions', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Interceptions', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Fabrications', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Modifications', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Trong tấn công DDoS phản chiếu hay gián tiếp, có sự tham gia của một số lượng lớn máy chủ trên mạng Internet không bị tin tặc chiếm quyền điều khiển. Các máy chủ này được gọi là…', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Requesters', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Reflectors', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Injectors', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Forwarders', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Các vùng bộ nhớ thường bị tràn gồm:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Ngăn xếp (Stack) và Bộ nhớ đệm (Cache)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Hàng đợi (Queue) và Vùng nhớ cấp phát động (Heap)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Ngăn xếp (Stack) và Vùng nhớ cấp phát động (Heap)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Hàng đợi (Queue) và Ngăn xếp (Stack)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Để đảm bảo an toàn cho hệ thống điều khiển truy cập, một trong các biện pháp phòng chống hiệu quả là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Không mở các email của người lạ hoặc email quảng cáo', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Không cho phép chạy các chương trình điều khiển từ xa', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Không cài đặt và chạy các chương trình tải từ các nguồn khôngtin cậy', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Không dùng tài khoản có quyền quản trị để chạy các chương trình ứngdụng', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Để thực hiện tấn công Smurf, tin tặc phải giả mạo địa chỉ gói tin ICMP trong yêu cầu tấn công. Tin tặc sử dụng…', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Địa chỉ máy nạn nhân làm địa đích của gói tin', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Địa chỉ router làm địa đích của gói tin', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Địa chỉ máy nạn nhân làm địa nguồn của gói tin', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Địa chỉ router làm địa nguồn của gói tin', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Macro viruses là loại viruses thường lây nhiễm vào…', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Các file tài liệu của bộ phần mềm Open Office', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Các file tài liệu của bộ phần mềm Microsoft SQL', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Các file tài liệu của bộ phần mềm Microsoft Office', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Các file tài liệu của bộ phần mềm Microsoft Exchange', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Khác biệt cơ bản của vi rút và sâu là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Vi rút có khả năng phá hoại lớn hơn', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Sâu có khả năng phá hoại lớn hơn', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Vi rút có khả năng tự lây lan mà không cần tương tác của ngườidùng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Sâu có khả năng tự lây lan mà không cần tương tác của người dùng', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mục đích chính của tấn công giả mạo địa chỉ IP là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Để đánh cắp các dữ liệu nhạy cảm trên máy trạm', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Để vượt qua các hệ thống IPS và IDS', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Để vượt qua các hàng rào kiểm soát an ninh', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Để đánh cắp các dữ liệu nhạy cảm trên máy chủ', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Việc quản lý, khắc phục các lỗ hổng bảo mật và tăng cường khả năng đề kháng cho hệ thống cần được thực hiện theo nguyên tắc chung là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Cân bằng giữa An toàn, Hữu dụng và Tin cậy', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Cân bằng giữa An toàn, Rẻ tiền và Chất lượng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Cân bằng giữa An toàn, Hữu dụng và Rẻ tiền', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Cân bằng giữa An toàn, Tin cậy và Rẻ tiền', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một trong các biện pháp cụ thể cho quản lý, khắc phục các lỗ hổng bảo mật và tăng cường khả năng đề kháng cho hệ thống là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Định kỳ cập nhật thông tin về các lỗ hổng từ các trang web chínhthức', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Định kỳ cập nhật các bản vá và nâng cấp hệ điều hành', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Định kỳ nâng cấp hệ thống phần mềm', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Định kỳ nâng cấp hệ thống phần cứng', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Có thể phòng chống tấn công Smurf bằng cách cấu hình các máy và router không trả lời…', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'các yêu cầu UPD hoặc các yêu cầu phát quảng bá', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'các yêu cầu ICMP hoặc các yêu cầu phát quảng bá', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'các yêu cầu TCP hoặc các yêu cầu phát quảng bá', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'các yêu cầu HTTP hoặc các yêu cầu phát quảng bá', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Các thành phần chính của hệ thống máy tính gồm:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Hệ thống phần cứng và Hệ thống phần mềm', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'CPU, Bộ nhớ, HDD, hệ điều hành và các ứng dụng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'CPU, Bộ nhớ, HDD và Hệ thống bus truyền dẫn', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'CPU, hệ điều hành và các ứng dụng', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Đâu là dạng lỗ hổng bảo mật thường gặp trong hệ điều hành và các phần mềm ứng dụng', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Lỗi tràn bộ đệm', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Lỗi quản trị', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Lỗi thiết kế', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Lỗi cấu hình', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Đâu là một công cụ có khả năng rà quét các lỗ hổng chèn mã SQL cho các trang web?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Microsoft Baseline Security Analyzer', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Acunetix Web Vulnerability Scanner', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'nmap', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Nessus vulnerability scanner', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Điều khiển truy nhập dựa trên luật (Rule-based access control) được sử dụng phổ biến trong:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'VPN', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Firewall', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'SSL/TLS', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Kerberos', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Phát hiện tấn công, xâm nhập dựa trên bất thường dựa trên giả thiết:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Các hành vi tấn công, xâm nhập gây tổn hại nghiêm trọng cho hệthống', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Các hành vi tấn công, xâm nhập thường có quan hệ chặt chẽ với các hànhvi bất thường', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Các hành vi tấn công, xâm nhập có quan hệ chặt chẽ với các dịch vụ đượccung cấp', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Các hành vi tấn công, xâm nhập gây ngắt quãng dịch vụ cung cấp chongười dùng', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một trong các nhược điểm chính của điều khiển truy nhập dựa trên các đặc điểm sinh trắc học là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Không được hỗ trợ rộng rãi', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Công nghệ phức tạp', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Chi phí đắt', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Khó sử dụng', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Phát biểu nào sau đây đúng với cơ chế điều khiển truy nhập DAC:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'DAC cho phép người tạo ra đối tượng có thể cấp quyền truy nhập chongười dùng khác', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'DAC quản lý quyền truy nhập chặt chẽ hơn các cơ chế khác', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'DAC cấp quyền truy nhập dựa trên tính nhạy cảm của thông tin và chínhsách quản trị', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'DAC là cơ chế điều khiển truy nhập được sử dụng rộng rãi nhất', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Phát biểu nào sau đây đúng với cơ chế điều khiển truy nhập bắt buộc MAC:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'MAC quản lý quyền truy nhập chặt chẽ hơn các cơ chế khác', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'MAC cấp quyền truy nhập dựa trên tính nhạy cảm của thông tin và chínhsách quản trị', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'MAC là cơ chế điều khiển truy nhập được sử dụng rộng rãi nhất', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'MAC cho phép người tạo ra đối tượng có thể cấp quyền truy nhập chongười dùng khác', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tìm phát biểu đúng về dịch vụ xác thực trong điều khiển truy nhập:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Là quá trình xác minh nhận dạng của chủ thể', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Là quá trình xác minh nhận dạng của người dùng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Là quá trình xác minh các thông tin nhận dạng của chủ thể yêu cầu truynhập đối tượng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Là quá trình xác minh tính chân thực của thông tin nhận dạng người dùngcung cấp', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Hai dịch vụ quan trọng nhất của một hệ thống điều khiển truy nhập là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Authenticator và Administrator', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Authentication và Authorization', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Authentication và Administrator', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Administrator và Authorization', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mục đích chính của điều khiển truy nhập là để đảm bảo các thuộc tính an ninh của thông tin, hệ thống và các tài nguyên, gồm:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Tính bí mật, tính toàn vẹn và tính sẵn dùng', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Tính bảo mật, tính toàn vẹn và tính xác thực', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Tính bí mật, tính toàn vẹn và tính xác thực', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tính bảo mật, tính toàn vẹn và tính sẵn dùng', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tại sao một hệ thống phát hiện xâm nhập dựa trên chữ ký không thể phát hiện các tấn công, xâm nhập mới?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Do chữ ký của chúng chưa tồn tại trong hệ thống', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Do các tấn công, xâm nhập mới chỉ gây thiệt hại nhỏ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Do các tấn công, xâm nhập mới không có chữ ký', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Do các tấn công, xâm nhập mới không gây ra bất thường', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Ưu điểm của điều khiển truy nhập dựa trên các đặc điểm sinh trắc học là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Bảo mật cao và được hỗ trợ rộng rãi', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Bảo mật cao và độ ổn định cao', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Bảo mật cao và chi phí thấp', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Bảo mật cao và luôn đi cùng với chủ thể', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Các hệ thống phát hiện xâm nhập có thể thu thập dữ liệu đầu vào từ…', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Các host', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Mạng và các host', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Mạng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Các router', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Dạng xác thực sử dụng các thông tin nào dưới đây đảm bảo độ an toàn cao hơn?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Thẻ ATM và số PIN', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Tên truy nhập và mật khẩu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Tên truy nhập và số PIN', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Thẻ ATM và tên truy nhập', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Phương pháp xác thực nào dưới đây có thể cung cấp khả năng xác thực có độ an toàn cao nhất?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Sử dụng Smartcard', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Sử dụng chứng chỉ số', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Sử dụng mật khẩu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Sử dụng vân tay', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tìm phát biểu đúng về phát hiện xâm nhập dựa trên chữ ký và phát hiện xâm nhập dựa trên bất thường:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Phát hiện xâm nhập dựa trên bất thường không thể phát hiện các tấncông, xâm nhập mới', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Phát hiện xâm nhập dựa trên chữ ký có thể phát hiện các tấn công, xâmnhập mới', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Phát hiện xâm nhập dựa trên chữ ký thường có tỷ lệ phát hiện đúng caohơn', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Phát hiện xâm nhập dựa trên bất thường thường có tỷ lệ phát hiện đúngcao hơn', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Đâu là một loại tường lửa?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Gateway server', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Application server', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Server gateway', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Application-level gateway', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Loại tấn công nào sau đây chiếm quyền truy nhập đến tài nguyên lợi dụng cơ chế điều khiển truy nhập DAC?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Man in the middle', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Phishing', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Trojan horse', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Spoofing', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Số lượng nhân tố (factor) xác thực sử dụng trong điều khiển truy nhập dựa trên thẻ thông minh là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '3', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '4', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '1', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '2', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Ưu điểm của thẻ bài (token) so với thẻ thông minh (smart card) trong điều khiển truy nhập là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Được sử dụng rộng rãi hơn', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Có chi phí rẻ hơn', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Có cơ chế xác thực mạnh hơn', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Có cơ chế xác thực đa dạng hơn', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Danh sách điều khiển truy nhập ACL thực hiện việc quản lý quyền truy nhập đến các đối tượng cho người dùng bằng cách:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Các quyền truy nhập vào đối tượng cho mỗi người dùng được quản lý riêngrẽ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Mỗi người dùng được gán một danh sách các đối tượng kèm theo quyền truynhập', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Mỗi đối tượng được gán một danh sách người dùng kèm theo quyền truynhập', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Các quyền truy nhập vào đối tượng cho mỗi người dùng được quản lý trongmột ma trận', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tìm phát biểu đúng về mã hóa khóa bất đối xứng (Asymmetric key cryptography):', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Sử dụng một khóa quá trình mã hóa và một khóa khác cho giải mã', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'An toàn hơn mã hóa khóa bí mật', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Sử dụng một khóa chung cho cả quá trình mã hóa và giải mã', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Chỉ sử dụng kỹ thuật mã hóa khối', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Độ an toàn của hệ mật mã RSA dựa trên...', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Khóa có kích thước lớn', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Độ phức tạp cao của giải thuật RSA', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Tính khó của việc phân tích số nguyên rất lớn', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Chi phí tính toán lớn', FALSE);

-- Subject: Cơ sở dữ liệu
INSERT INTO subject (subject_name, description) VALUES ('Cơ sở dữ liệu', 'Ngân hàng câu hỏi trắc nghiệm môn Cơ sở dữ liệu');
SET @curr_subject_id = LAST_INSERT_ID();
INSERT INTO topic (subject_id, topic_name, description, order_no) VALUES (@curr_subject_id, 'Tổng hợp', 'Các câu hỏi ôn tập tổng hợp', 1);
SET @curr_topic_id = LAST_INSERT_ID();

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ Cơ Sở Dữ liệu sau: NhanVien ( MaNV, HoNV, TenNV, DiaChi, ThanhPho ) KhachHang( MaKH, TenKH, DiaChi, ThanhPho, SoDu, GioiHanTinDung) HoaDon( MaHD, NgayLapHoaDon, MaKH, MaNV) ChiTietHoaDon (MaHD, MaSP, SoLuong,GiaBan ) SanPham(MaSP,MoTa, NhomHang, KhoHang,GiaGoc) Dựa vào lược đồ Cơ Sở Dữ liệu trên, Tạo câu truy vấn để liệt kê danh sách các sản phẩm có giá từ 50000 đến 100000?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select * From SanPham Where GiaGoc>=50000', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Select * From SanPham Where GiaGoc<=100000', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Select * From SanPham Where GiaGoc between 50000 and 100000', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Select * From SanPham Where GiaGoc in(50000,100000)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ Cơ sở dữ liệu sau: SINHVIEN(MaSV, HoSV, TenSV, Phai, NgaySinh, DiaChi, DienThoai, MaLop) LOP(MaLop, TenLop, MaKhoa, GVCN) KETQUA(MaSV, MaMH, LanThi, Diem) MONHOC(MaMH, TenMH, SoTinChi) Liệt kê danh sách các sinh viên gồm (MaSV, HoSV, TenSV) có điểm thi môn CSDL cao nhất?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select K.MaSV, HoSV, TenSV From SinhVien S, KetQua K Where S.MASV=K.MASV And MaMH=''CSDL'' And Diem>=ALL (Select Diem From KetQua where MaMH =''CSDL'')', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Select K.MaSV, HoSV, TenSV From SinhVien S, ketqua K Where S.MASV=K.MASV And MaMH=''CSDL'' And Diem= (Select max(Diem)From ketqua where MaMH =''CSDL'')', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Select top 1 with ties K.MaSV, HoSV, TenSV From SinhVien S, KetQua K Where S.MASV=K.MASV And MaMH=''CSDL'' order by diem desc', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả các phương án trên.', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ CSDL sau: NhanVien (MaNV, HoNV, TenNV, DiaChi, ThanhPho) KhachHang (MaKH, TenKH, DiaChi, ThanhPho, SoDu, GioiHanTinDung) HoaDon (MaHD, NgayLapHoaDon, MaKH, MaNV) ChiTietHoaDon (MaHD, MaSP, SoLuong,GiaBan) SanPham(MaSP,MoTa, NhomHang, KhoHang,GiaGoc) Dựa vào lược đồ Cơ Sở Dữ liệu trên, Liệt kê ra sản phẩm có giá lớn hơn giá trung bình cuả các sản phẩm?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select * From SanPham Where GiaGoc>(Select Avg(GiaGoc) From SanPham)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Select * From SanPham Where GiaGoc>(Select Avg(GiaGoc) From SanPham Group by MaSP)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Select * From SanPham Where GiaGoc> Avg(GiaGoc)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Select * From SanPham Group by MaSP Having GiaGoc> Avg(GiaGoc)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho mô hình thực thể kết hợp (Mô hình ER) như hình bên. Hãy chuyển từ mô hình ER sang lược đồ Cơ sở dữ liệu?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Học Viên (Mã học viên, tên học viên, điạ chỉ, ngày sinh, số điện thoại, ngày nhập học, mã môn học) Môn học(Mã môn học, tên môn học, thời lượng) Khoá chính là Mã môn học Với: khoá chính cuả bảng học viên là Mã học viên và khoá chính cuả bảng môn học là Mã môn học.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Học Viên (Mã học viên, tên học viên, điạ chỉ, ngày sinh, số điện thoại, ngày nhập học,Mã môn học) Môn học(Mã môn học, tên môn học, thời lượng, Mã học viên) Với: khoá chính cuả bảng học viên là Mã học viên, Mã môn học và khoá chính của bảng môn học là Mã môn học, Mã học viên', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Học Viên (Mã học viên, tên học viên, điạ chỉ, ngày sinh, số điện thoại) Môn học(Mã môn học, tên môn học, thời lượng) Học Viên Mon Hoc(Mã học viên, Mã môn học) Với: khoá chính cuả bảng "Học Viên" là Mã học viên Khoá chính cuả bảng "Môn học" là Mã môn học. Khoá chính cuả bảng "Học Viên Mon Hoc" là Mã học viên, Mã môn học.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Học Viên (Mã học viên, tên học viên, điạ chỉ, ngày sinh, số điện thoại) Môn học(Mã môn học, tên môn học, thời lượng, Mã học viên) Với: khoá chính cuả bảng học viên là Mã học viên và khoá chính cuả bảng môn học là Mã môn học.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, '_____ của một thực thể trở thành các cột trong một bảng cơ sở dữ liệu', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Các thuộc tính', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Các bộ (tuple)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Các file dữ liệu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Các biểu đồ E-R', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, '_____ là sự ngăn chặn người dùng không có quyền được truy cập cơ sở dữ liệu.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Tính độc lập của dữ liệu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Ràng buộc về tính nguyên vẹn', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Tình trạng dư thừa', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Bảo mật', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, '_____ phổ biến bao gồm Access, Oracle, DB2, và SQL Server.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Các biểu đồ E-R', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Các DBA', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Các file dữ liệu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Các DBMS', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Ba loại quan hệ 2 ngôi là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '1:1, 1:N, N:M', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Entity, class, instance.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Unique, non-unique, associated.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả đều sai.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Bạn đang thiết kế một mô hình cơ sở dữ liệu để quản lý sinh viên. Mỗi sinh viên có thể học nhiều hơn một lớp, mỗi lớp có nhiều sinh viên nhưng chỉ được 1 giáo viên dạy. Bạn có 3 thực thể Lớp, Sinh viên, giáo viên trong cơ sở dữ liệu. Dạng quan hệ nào sau đây phải có trong quan hệ giữa Sinh viên và lớp học?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Một - Nhiều', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Nhiều - Nhiều', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Một - Một', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Không - Nhiều', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Các bảng tính, tài liệu, và trang Web được lưu trong _____.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Cơ sở dữ liệu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Các file', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Các thực thể', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Các thuộc tính', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Các bộ dữ liệu trong một quan hệ phải có tính chất:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Tất cả các bộ dữ liệu phải khác nhau', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Với hai bộ dữ liệu bất kỳ, chúng phải khác nhau trên một hoặc nhiều cột', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Mỗi quan hệ phải có khóa', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả các phương án trên.', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Các mối kết hợp có trong mô hình là (Hình bên)?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'NH N VIÊN, QUẢN LÝ TRỰC TIẾP, QUẢN LÝ, THAM GIA, THUỘC', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'NH N VIÊN, LĨNH VỰC,QUẢN LÝ, THAM GIA, THUỘC', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'QUẢN LÝ, QUẢN LÝ TRỰC TIẾP, THAM GIA, THUỘC', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả đều sai', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Các yếu tố cơ bản nào được sử dụng trong mô hình E-R?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Thực thể', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Các thuộc tính tương ứng của thực thể', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Các mối kết hợp giữa các thực thể', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả các phương án trên.', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Các yếu tố liên quan đến thuộc tính của đối tượng là?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Tên gọi của thuộc tính', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Miền giá trị của thuộc tính', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Kiểu dữ liệu của thuộc tính', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả các phương án trên', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cách nhanh nhất để xác định số dòng trong một bảng là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Tạo một kịch bản đưa ra danh sách và hiển thị mỗi dòng.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dựa vào số lớn nhất của ID có trong bảng.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Sử dụng hàm count để đếm trong câu truy vấn.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dựa vào thuộc tính trong bảng.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Câu lệnh nào sau đây sẽ tước quyền của người dùng đối với cơ sở dữ liệu?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'SELECT', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'INDEX', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'GRANT', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'REVOKE', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Câu lệnh SQL sau đây làm gì? Select * From Customer Where Cust_Type = "Best"', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Danh sách gồm tất cả các cột trong bảng Customer mà mỗi dòng đều có nhãn khách hàng(Cust_Type) là "best".', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Danh sách gồm cột có cột tên là "*" trong bảng Customer mà mỗi dòng đều có nhãn khách hàng là "best".', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Danh sách gồm tất cả các cột có một dấu "*" trong bảng Customer.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Danh sách gồm tất cả các cột trong bảng Customer mà mỗi dòng đều có nhãn khách hàng là "*".', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Câu lệnh truy vấn nào sau đây cho kết quả là cột ProductID trong Table Oder_detail, mỗi ProductID chỉ hiễn thị một lần?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'SELECT DISTINCT ProductID FROM order_details', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'SELECT UNIQUE ProductID FROM order_details', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'SELECT ProductID FROM order_details', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'SELECT ProductID FROM order_details ONLY ONCE', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Câu lệnh truy vấn nào sau đây dùng để xác định các Productname có ProductID là 10, 11 hoặc 42?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'SELECT ProductName FROM products WHERE ProductID IN (10,11,42)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'SELECT ProductName FROM products WHERE ProductID = (10,11,42)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'SELECT ProductName FROM products WHERE ProductID IS (10,11,42)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'SELECT ProductName FROM products WHERE ProductID IN 10 OR 11 OR 42', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Câu lệnh truy vấn nào sau đây dùng để xác định standard prices nhỏ nhất trong table product_v', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'select standard_price from min(product_v)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'select standard_price from product_v where standard_price = min', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'select min(standard_price) from product_v', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'select min(standard_price) from product_v where standard_price = min(standard_price)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Câu lệnh truy vấn nào sau đây là sai cú pháp?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'SELECT ProductName FROM products WHERE (UnitPrice < 10) , (UnitsInStock > 5)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'SELECT ProductName FROM products WHERE (UnitPrice < 10) OR NOT (UnitsInStock > 5)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'SELECT ProductName FROM products WHERE UnitPrice < 10 OR UnitsInStock > 5', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'SELECT ProductName FROM products WHERE UnitPrice < 10 AND UnitsInStock > 5', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Câu lệnh truy vấn nào sau đây là sai?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'SELECT * FROM emp WHERE empid = 493945', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'SELECT empid FROM emp', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'SELECT empid FROM emp WHERE empid= 493945', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'SELECT empid WHERE empid = 56949 AND lastname = ''SMITH''', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Câu nào dưới đây đúng?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Trong một môi trường hướng file, phi cơ sở dữ liệu, dữ liệu thường bị tách thành một vài hệ thống rời rạc, mỗi hệ thống có một tập hợp các file riêng.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dữ liệu người dùng không thể được kết hợp và chia sẻ giữa những người dùng có quyền.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Những người dùng cơ sở dữ liệu không nên truy cập cùng thông tin.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Thường có thể loại bỏ tình trạng dư thừa.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Câu nào sau đây dùng để xoá bảng KhachHang ra khỏi một lược đồ cơ sở dữ liệu?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Delete table Khachhang', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Drop table Khachhang', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Cả 2 phương án: 1 và 2', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Remove table KhachHang', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cấu trúc của một mô hình quan hệ được định nghĩa bởi:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Quan hệ, bộ và thuộc tính', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Bảng, dòng và cột', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Tập tin, mẫu tin và trường', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả đều đúng', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Câu truy vấn nào sau đây chứa một lỗi?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'SELECT * FROM emp WHERE empid = 493945;', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'SELECT empid FROM emp WHERE empid= 493945;', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'SELECT empid WHERE empid = 56949 AND lastname = ''SMITH'';', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'SELECT empid FROM emp;', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ D(H, K, I, Y, Z) và tập phụ thuộc hàm C={H K->I Z, K->Y , Y->H }. Phụ thuộc hàm nào sau đây không được suy diễn từ C:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'H Y->I Z', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'K Z->H I', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'H K->Y H', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'K->H', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho 1 bảng với cấu trúc sau: NhanVien(MaNV, TenNV, Luong, NgayBatDauVaoLam), Tạo câu truy vấn SQL để tìm nhân viên có lương cao nhất', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'SELECT * FROM NhanVien ORDER BY Luong DESC;', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'SELECT top 1 * FROM NhanVien ORDER BY Luong;', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'SELECT top 1 * FROM NhanVien ORDER BY Luong DESC;', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'SELECT top 1 * FROM NhanVien;', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho 1 bảng với cấu trúc sau: NhanVien(MaNV, TenNV, Luong, NgayBatDauVaoLam), Tạo câu truy vấn SQL để tìm tất cả các nhân viên bắt đầu vào làm việc trong năm 2005?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'SELECT * FROM NhanVien WHERE NgayBatDauVaoLam=2005;', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'SELECT * FROM NhanVien WHERE NgayBatDauVaoLam>=''01/01/2005'';', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'SELECT * FROM NhanVien WHERE year(NgayBatDauVaoLam)=2005;', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'SELECT * FROM NhanVien WHERE NgayBatDauVaoLam< ''01/01/2006'';', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho 1 bảng với cấu trúc sau: NhanVien(MaNV, TenNV, Luong, NgayBatDauVaoLam). Tạo câu truy vấn SQL để tìm tất cả các nhân viên mà có ký tự đầu cuả tên là ''S''?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'SELECT * FROM NhanVien WHERE TenNV IN [''S''];', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'SELECT * FROM NhanVien WHERE TenNV LIKE ''S%'';', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'SELECT * FROM TenNV WHERE NhanVien LIKE ''S*'';', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'SELECT EmpNo FROM NhanVien WHERE TenNV LIKE ''S'';', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho 2 bảng sau: PhongBan(MaPB,TenPB,TruongPhong,DonVi, ViTri) NhanVien(MaNV, HoTen, MaPB,CongViec, NamSinh,Luong) Tạo truy vấn để liệt kê danh sách các phòng ban và họ tên trưởng phòng cuả phòng ban đó. Danh sách gồm MaPB, MaNV, HoTen.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select n.MaPB, MaNV, Tennv From nhanvien n,phongban p Where n.manv=p.truongphong', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Select n.MaPB, MaNV, Tennv From nhanvien n,phongban p Where n.mapb=p.mapb', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Select n.MaPB, MaNV, Tennv From nhanvien n,phongban p Where n.mapb=p.mapb Group by n.MaPB, MaNV, Tennv', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Select n.MaPB, MaNV, Tennv From nhanvien n,phongban p Where n.mapb=p.mapb Order by n.MaPB', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho bảng SanPham(MaSP, TenSP, DonGia) có khóa chính là [MaSP]. Tạo câu truy vấn để xem giá thấp nhất trong bảng SanPham là bao nhiêu?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select DonGia from SanPham where DonGia = min;', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Select min(DonGia) from SanPham;', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Select min(DonGia) from SanPham where DonGia = min(DonGia);', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Select DonGia from SanPham where DonGia = min(DonGia);', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho bảng sau: DonHang(MaDH,MaSP,SoLuong,GiaBan) Để tạo khoá chính cho bảng Donhang (khoá chính gồm 2 Field là MaDH và MaSP). Câu nào sau đây là đúng?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Alter table DonHang Add Primary Key (MaDH,MaSP)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Alter table DonHang Add Primary Key (DonHang,MaDH,MaSP)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Alter table DonHang Add Primary (MaDH,MaSP)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Alter table DonHang Add Key (MaDH,MaSP)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho bảng sau: SanPham(MaSP,MoTa, NhomHang, KhoHang,GiaGoc, SoLuongTon) Cho biết có bao nhiêu sản phẩm thuộc nhóm hàng ''HW''?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select sum(MaSP) From SanPham Where NhomHang=''HW''', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Select Count(*) From SanPham Where NhomHang=''HW''', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Select Count From SanPham Where NhomHang=''HW''', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Select Count * From SanPham Where NhomHang=''HW''', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho bảng sau: SanPham(MaSP,MoTa, NhomHang, KhoHang,GiaGoc, SoLuongTon) Liệt kê danh sách các sản phẩm chưá trong kho số 3 và có Số Lượng Tồn lớn hơn 30?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select * From SanPham', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Select * From SanPham Where KhoHang=3 and SoLuongTon>30', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Select * From SanPham Where KhoHang=3 or SoLuongTon>30', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Select sum(MaSP) as SLTon From SanPham Where KhoHang=3 Group by MaSP Having SLTon>30', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho bảng sau: SanPham(MaSP,MoTa, NhomHang, KhoHang,GiaGoc, SoLuongTon) Liệt kê danh sách các sản phẩm không chưá trong kho số 3?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select * From SanPham Where KhoHang<>3', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Select * From SanPham Where KhoHang!=3', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Cả 2 phương án: 1 và 2', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Select * From SanPham here KhoHang not in 3', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho bảng sau: SinhVien(MaSV,MaKhoaHoc,SoDu) Liệt kê danh sách các sinh viên có số dư trong tài khoản lớn hơn bằng 100000 và nhỏ hơn bằng 500000?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select * From SinhVien Where SoDu like 100000 and 500000', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Select * From SinhVien Where SoDu Between 100000 and 500000', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Select * From SinhVien Where SoDu in 100000 and 500000', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Select * From SinhVien Where SoDu Having 100000 and 500000', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho bảng SinhVien(MaSV,TenSV,ChuyenNganh) với khóa chính là [Masv, ChuyenNganh]. Các sinh viên có thể học nhiều chuyên ngành khác nhau. Tạo câu truy vấn liệt kê danh sách các sinh viên không thuộc chuyên ngành CNTT.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'SELECT * FROM SinhVien HAVING ChuyenNganh <> ''CNTT"', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'SELECT * FROM SinhVien GROUP BY ChuyenNganh HAVING ChuyenNganh <> ''CNTT"', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'SELECT * FROM SinhVien WHERE MaSV NOT IN (SELECT MaSV FROM SinhVien WHERE ChuyenNganh = ''CNTT'')', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'SELECT * FROM SinhVien WHERE MaSV NOT IN (SELECT MaSV FROM SinhVien Having ChuyenNganh = ''CNTT'')', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho bảng SinhVien(MaSV,TenSV,ThanhPho,ChuyenNganh) với khóa chính là [Masv, ChuyenNganh]. Các sinh viên có thể học nhiều chuyên ngành khác nhau. Cho câu lệnh SELECT của SQL sau: Select MaSV, ChuyenNganh From SinhVien GROUP BY MaSV, ChuyenNganh HAVING ThanhPho=''VungTau'' Chọn câu trả lời đúng?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Câu lệnh trên bị lỗi.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Trả về danh sách gồm MaSV, ChuyenNganh của các sinh viên có thành phố là VungTau.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Trả về một bảng gồm các chuyên ngành của từng sinh viên.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Trả về 1 dòng gồm MaSV, ChuyenNganh của sinh viên có thành phố là VungTau.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho bảng T(P,O,C) và các phụ thuộc hàm sau: P->O, P->C, C->O. Loại phụ thuộc hàm tồn tại trong lược đồ CSDL trên:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Phụ thuộc bắc cầu.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Phụ thuộc riêng phần.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Phụ thuộc đầy đủ.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Phụ thuộc hàm hiển nhiên.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho bảng TT {Q , I , C , E , B } và tập phụ thuộc hàm sau:Q -> E,B; E -> I,C; Q,C -> I; Bao đóng của {I E B} là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '{I C E B}', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '{B E C Q}', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '{Q E I C}', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '{Q I C E}', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho bảng TT {Q , K , J , U , H } và tập phụ thuộc hàm sau: Q -> U,H; U -> K,J; Q,J -> K; Bao đóng của {Q U} là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '{Q K J U H}', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '{K J U H}', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '{Q K U H}', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '{Q K J U}', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho bảng TT {V , S , J , A , E , D , N } và tập phụ thuộc hàm sau: V, S -> D, N; E -> V , S, J; J, D -> A, N; A, N,J -> D; V, N, S -> E; Bao đóng của {V S} là', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '{V S J A N E D}', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '{V S J N E D}', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '{V S J A N E}', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '{V J A N E D}', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho bảng Z(U, B, Q, T, A) và tập phụ thuộc hàm sau: H={ U->B Q; Q T->A; U Q-A; B->T; A->U B } Có 4 khóa dự tuyển trong Z là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'U; BQ; Q T; A', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'T; Q U; T U; Q', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Q; U B; Q T ; A', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'T; B Q U; Q T ; U A', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho bảng: NhanVien MaNV TenNV 1 An 2 Hoa Cho câu truy vấn sau SELECT * FROM NhanVien, thứ tự các dòng trả về sẽ dựa trên?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Không có thứ tự.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Thứ tự dựa trên khóa chính.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Theo giá trị của cột MaNV, rồi đến cột TenNV', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dựa vào thứ tự của các dòng khi chèn vào bảng, dòng nào chèn trước sẽ xếp trước.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho biết kết quả của câu truy vấn bằng SQL sau? Select customer_name, telephone from customers where city in (‘Boston’,’New York’,’Denver’);', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Danh sách các customer_name và telephone của tất cả các khách hàng có trong bảng customers.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Danh sách các customer_name và telephone của tất cả các khách hàng đang sống ở Boston, New York hoặc Denver.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Danh sách các customer_name của tất cả các khách hàng đang sống ở Boston, New York hoặc Denver.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Danh sách các customer_name và telephone của tất cả các khách hàng đang sống ở Boston và New York và Denver.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho biết kết quả của câu truy vấn bằng SQL sau? Select item_no, description from item where weight > 100 and weight < 200;', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Danh sách các item_no và description của tất cả các món mà có trọng lượng (weight) nhỏ hơn 100.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Danh sách các item_no của tất cả các món mà có trọng lượng từ 101 đến 199..', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Danh sách của tất cả các món mà có trọng lượng lớn hơn 200.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Danh sách các item_no và description của tất cả các món mà có trọng lượng từ 101 đến 199..', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho biết kết quả của câu truy vấn bằng SQL sau? Select min(MoTaSanPham) from SanPham;', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Trả về giá trị nhỏ nhất của cột MoTaSanPham.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Câu lệnh trên bị lỗi.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Không có câu nào đúng.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Trả về dòng có ký tự chữ cái đầu tiên theo thứ tự abc của cột MoTaSanPham trong bảng SanPham.', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho biết kết quả của câu truy vấn bằng SQL sau? Select sum(DonGia) as TongDonGia from SanPham where LoaiSanPham = ‘Cotton’;', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Trả về tổng đơn giá của tất cả các sản phẩm mà có lọai sản phẩm là Cotton.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Trả về tổng đơn giá của tất cả các sản phẩm.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Trả về đơn giá của bất kỳ sản phẩm nào có trong bảng SanPham.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Trả về đơn giá của sản phẩm đầu tiên mà có lọai sản phẩm là "Cotton" trong bảng SanPham.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho các bảng sau: SinhVien(MaSV,TenSV,DiaChi,MaKhoaHoc) KetQua(MaSV,MaMH,Diem) MonHoc(MaMH,TenMH) Cho câu truy vấn SQL sau: SELECT TenSV, AVG(Diem) FROM SinhVien s,KetQua k WHERE s.MaSV=k.MaSV GROUP BY TenSV HAVING avg(Diem) >70 Kết quả nào sau đây là đúng cho câu truy vấn trên?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Câu truy vấn trên không đúng cú pháp.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Câu truy vấn trên trả về tên sinh viên và điểm trung bình cuả sinh viên đó.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Câu truy vấn trên trả về Tên của những sinh viên có điểm trung bình lớn hơn 70.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả đều sai.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho các bảng sau: KhachHang (MaKH, TenKH, ThanhPho) SanPham(MaSP, TenSP, SoLuong, DonGia) DaiLy (MaDL, TenDL, ThanhPho, HueHong) DatHang (MaDH, NgayDH, MaKH, MaDL, MaSP, SoLuong, ThanhTien). Chọn câu lệnh SQL để giải quyết câu truy vấn sau: Tăng giá cuả mỗi sản phẩm trong bảng SanPham lên 10% cho tất cả các sản phẩm mà khách hàng ''C01'' đặt mua.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Update SanPham set DonGia= DonGia * 1.1 where DatHang.MaKH = ''C01'';', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Update SanPham, DatHang set SanPham.DonGia = SanPham.DonGia * 10% where DatHang.MaKH = ''C01'';', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Update SanPham set DonGia = 1.1 * DonGia where MaSP in (select MaSP from DatHang where MaKH = ''C01'');', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Update SanPham set DonGia = 0.1 * DonGia where MaSP in (select MaSP from DatHang where MaKH = ''C01'');', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho các bảng sau: KhachHang (MaKH, TenKH, ThanhPho) SanPham(MaSP, TenSP, SoLuong, DonGia) DaiLy (MaDL, TenDL, ThanhPho, HueHong) DatHang (MaDH, NgayDH, MaKH, MaDL, MaSP, SoLuong, ThanhTien) Chọn câu lệnh SQL để giải quyết câu query sau. Liệt kê danh sách tên các khách hàng đặt mua sản phẩm ''P02'' hoặc đặt mua thông qua đaị lý ''A04''.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select TenKH from KhachHang where MaKH in (select MaKH from DatHang where MaSP = ''P02'' OR MaDL = ''A04'')', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Select TenKH from KhachHang where MaKH in (select o1.MaKH from DatHang o1, DatHang o2 Where o1.MaSP = ''P02'' and o2.MaDL = ''A04'' and o1.MaSP = o2.MaSP);', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Select TenKH from KhachHang c, DatHang o1, DatHang o2 where c.MaKH = o1.MaKH and c.MaKH = o2.MaKH and MaSP = ''P02'' and MaDL = ''A04'';', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Select TenKH from KhachHang c, DatHang o1, DatHang o2 where MaSP = ''P02'' and MaDL = ''A04'';', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho các lựơc đồ quan hệ sau: NhaCungCap(MaNCC,TenNCC,ThanhPho) SanPham(MaSP,TenSP,Mau) CungCap(MaNCC,MaSP,SoLuong) Hãy cho biết ý nghĩa của lệnh truy vấn sau: Select TenNCC From NhaCungCap X Where Not Exists (Select * From CungCap Y Where X.MaNCC = Y.MaNCC)', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Trả về tên cuả nhà cung cấp mà không tồn tại trong cơ sở dữ liệu.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Trả về tên cuả nhà cung cấp mà không cung cấp bất kỳ sản phẩm nào.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Trả về tên cuả nhà cung cấp mà không cung cấp tất cả các sản phẩm.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Không có phương án nào.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho các phụ thuộc hàm (H I -> D, D -> P) của lược đồ quan hệ N(H I D P), phụ thuộc hàm H -> P có thể được suy ra nhờ vào:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Luật phản xạ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Luật thêm vào', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Luật bắc cầu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả điều sai.', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho các phụ thuộc hàm sau F= (Z Q -> A N C, Z -> C), của lược đồ quan hệ B = (Z,Q,A,N,C) ta có thể suy ra:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Z là khóa của lược đồ quan hệ B', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Không có câu nào đúng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Q C là khóa của lược đồ quan hệ B ồ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Z Q là khóa của lược đồ quan hệ B', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho các phụ thuộc hàm{B Q -> L, L -> H} của lược đồ quan hệ S(B Q L H), phụ thuộc hàm B -> H có thể được suy ra nhờ vào:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Luật phản xạ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Luật thêm vào', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Luật bắc cầu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả điều sai', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho CSDL gồm các bảng sau: SinhVien(MaSV,TenSV,DiaChi,MaKhoaHoc) KetQua(MaSV,MaMH,Diem) MonHoc(MaMH,TenMH) Cho câu truy vấn SQL sau: SELECT TenMH FROM MonHoc s,KetQua k WHERE s.MaMH=k.MaMH GROUP BY TenMH HAVING Diem >70 Chọn câu trả lời đúng?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Câu truy vấn trên bị lỗi.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Câu truy vấn trên trả về danh sách tất cả các tên môn học.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Câu truy vấn trên trả về danh sách tất cả các tên môn học mà sinh viên học có điểm lớn hơn 70.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Câu truy vấn trên trả về danh sách tất cả các tên môn học mà sinh viên học có điểm trung bình lớn hơn 70.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho CSDL gồm các bảng sau: KhachHang(MaKH, TenKH, ThanhPho) SanPham(MaSP, TenSP, SoLuong, DonGia) DaiLy (MaDL, TenDL, ThanhPho, HueHong) DatHang (MaDH, NgayDH, MaKH, MaDL, MaSP, SoLuong, ThanhTien) Chọn câu lệnh SQL để giải quyết câu truy vấn sau: Liệt kê danh sách tên các khách hàng mua sản phẩm ''P02''', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select TenKH from KhachHang c, DatHang o where o.MaSP = ''P02'';', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Select TenKH from KhachHang c where DatHang.MaSP = ''P02'';', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Select TenKH from KhachHang c, DatHang o where c.MaKH = o.MaKH and o.MaSP = ''P02'';', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Select TenKH from SanPham where MaSP = ''P02'';', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho CSDL gồm các bảng sau: SinhVien(MaSV,TenSV,DiaChi,MaKhoaHoc) KetQua(MaSV,MaMH,Diem) MonHoc(MaMH,TenMH) Cho 2 câu truy vấn SQL sau: SELECT MaSV FROM SinhVien WHERE MaSV not in (Select MaSV from KetQua where MaMH=''CSDL'') SELECT MaSV FROM SinhVien s WHERE not exists (Select MaSV from KetQua d where MaMH=''CSDL'' and s.masv=d.masv) Chọn câu trả lời đúng?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Câu truy vấn thứ nhất sẽ trả về số bộ nhiều hơn câu truy vấn thứ hai.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Câu truy vấn thứ nhất sẽ trả về số bộ ít hơn câu truy vấn thứ hai.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Cả hai câu truy vấn trên cho cùng một kết quả.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Câu truy vấn thứ hai bị lỗi.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho CSDL gồm các bảng sau: SinhVien(MaSV,TenSV,DiaChi,MaKhoaHoc) KetQua(MaSV,MaMH,Diem) MonHoc(MaMH,TenMH) Cho câu truy vấn SQL sau: SELECT TenSV FROM SinhVien s,KetQua k WHERE s.MaSV =k.MaSV and Diem is null Chọn câu trả lời đúng?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Câu truy vấn trên không hợp lệ.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Nếu sinh viên nào bị trùng tên thì không in ra được kết quả.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Câu truy vấn trên trả về danh sách các tên sinh viên mà chưa có cho điểm của một hoặc vài môn học nào đó.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Câu truy vấn trên trả về danh sách các tên sinh viên mà chưa có cho điểm tất cả các môn học nào đó.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho CSDL gồm các bảng sau: SinhVien(MaSV,TenSV,DiaChi,MaKhoaHoc) KetQua(MaSV,MaMH,Diem) MonHoc(MaMH,TenMH) Cho câu truy vấn SQL sau: SELECT TenSV,Avg(Diem) FROM SinhVien s,KetQua k WHERE s.MaSV =k.MaSV Chọn câu trả lời đúng?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Câu truy vấn trên bị lỗi, không thể thực hiện được.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Câu truy vấn trên trả về danh sách các tên sinh viên và điểm trung bình của từng sinh viên đó.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Câu truy vấn trên trả về danh sách các tên sinh viên và điểm của từng môn học.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả đều sai.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho CSDL gồm các bảng: SinhVien(MaSV,TenSV,DiaChi,MaKhoaHoc) KetQua(MaSV,MaMH,Diem) MonHoc(MaMH,TenMH) Cho 2 câu truy vấn SQL sau: SELECT MaSV FROM SinhVien WHERE MaSV not in (Select MaSV from KetQua where MaMH=''CSDL'') SELECT MaSV FROM SinhVien WHERE not exists (Select MaSV from KetQua where MaMH=''CSDL'' ) Chọn câu trả lời đúng?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Câu truy vấn thứ nhất sẽ trả về số bộ nhiều hơn câu truy vấn thứ hai.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Câu truy vấn thứ nhất sẽ trả về số bộ ít hơn câu truy vấn thứ hai.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Cả hai câu truy vấn trên cho cùng một kết quả.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Câu truy vấn thứ hai bị lỗi, không thể thực thi được.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho CSDL gồm các bảng: SinhVien(MaSV,TenSV,DiaChi,MaKhoaHoc) KetQua(MaSV,MaMH,Diem) MonHoc(MaMH,TenMH) Cho câu truy vấn SQL sau: SELECT TenMH, count(*) FROM MonHoc s,KetQua k WHERE s.MaMH=k.MaMH And Diem>40 And k.MaMH in(Select MaMH From KetQua Group by MaMH Having count(*)>5) GROUP BY TenMH Chọn câu trả lời đúng?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Danh sách các tên môn học có trên 5 sinh viên học.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Trả về tên môn học và số sinh viên tham gia học. Mỗi môn học có nhiều hơn 5 sinh viên học và có điểm lớn hơn 40.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Câu truy vấn trên bị lỗi.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Danh sách các tên môn học có trên 5 sinh viên học mà có điểm lớn hơn 40.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'cho hai quan hệ C (N, W) và A (W, D) và các câu query sau: P: SELECT N FROM C, A WHERE C.W=A.W; và T: SELECT N FROM C WHERE W in (SELECT W From A); Câu nào sau đây là đúng?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'P và T trả về kết quả như nhau.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'P và T trả về kết quả khác nhau.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Kết quả cuả P luôn luôn chứa kết quả cuả T.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Kết quả cuả T luôn luôn chứa kết quả cuả P.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ B(P, Z, X, E) đạt BCNF, có khóa chính là P. Phụ thuộc hàm nào sau đây không là của B?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '{P} -->{Z, X, E}', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '{Z} -->{Z}', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '{E}-->{Z}', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '{P} --> {P}', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ Cơ Sở Dữ liệu sau: NhanVien ( MaNV, HoNV, TenNV, DiaChi, ThanhPho ) KhachHang( MaKH, TenKH, DiaChi, ThanhPho, SoDu, GioiHanTinDung) HoaDon( MaHD, NgayLapHoaDon, MaKH, MaNV) ChiTietHoaDon (MaHD, MaSP, SoLuong,GiaBan ) SanPham(MaSP,MoTa, NhomHang, KhoHang,GiaGoc) Dựa vào lược đồ Cơ Sở Dữ liệu trên,Hãy liệt kê tất cả các thông tin Khách hàng có giới hạn tín dụng là 7500.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'SELECT MaNV WHERE GioiHanTinDung=7500', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'SELECT KhachHang WHERE GioiHanTinDung=’7500’', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'SELECT * From KhachHang WHERE GioiHanTinDung=7500', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'SELECT MaKH WHERE GioiHanTinDung=7500', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ Cơ sở dữ liệu sau: SinhVien(MaSV, HoSV, TenSV, Phai, NgaySinh, DiaChi, DienThoai, MaLop) Lop(MaLop, TenLop, MaKhoa, GVCN) KetQua(MaSV, MaMH, LanThi, Diem) MonHoc(MaMH, TenMH, SoTinChi) Liệt kê danh sách các sinh viên có điểm điểm trung bình cao nhất. Danh sách gồm (MaSV, HoSV, TenSV,DiemTrungBinh)?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select Top 1 K.MaSV, HoSV, TenSV,DiemTrungBinh=Avg(Diem) From SinhVien S, KetQua K Where S.MASV=K.MASV Group by K.MaSV, HoSV, TenSV', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Select K.MaSV, HoSV, TenSV,DiemTrungBinh=Avg(Diem) From SinhVien S, KetQua K Where S.MASV=K.MASV And DiemTrungBinh>=ALL(Select Avg(Diem) From KetQua Group by MaSV )', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Select K.MaSV, HoSV, TenSV,DiemTrungBinh=Avg(Diem) From SinhVien S, KetQua K Where S.MASV=K.MASV And DiemTrungBinh>=ALL(Select Avg(Diem) From KetQua Group by MaSV ) Group by K.MaSV, HoSV, TenSV', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Select K.MaSV, HoSV, TenSV,DiemTrungBinh=Avg(Diem) From SinhVien S, KetQua K Where S.MASV=K.MASV Group by K.MaSV, HoSV, TenSV Having avg(diem)>=ALL(Select Avg(Diem) From KetQua Group by MaSV )', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ Cơ sở dữ liệu sau: SinhVien(MaSV, HoSV, TenSV, Phai, NgaySinh, DiaChi, DienThoai, MaLop) Lop(MaLop, TenLop, MaKhoa, GVCN) KetQua(MaSV, MaMH, LanThi, Diem) MonHoc(MaMH, TenMH, SoTinChi) Tạo query để tính sỉ số thực trên từng lớp. Danh sách bao gồm: MaLop, TenLop và SiSo ?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select S.Malop,TenLop,SiSo=Sum(MaSV) From Lop L, SinhVien S Group by S.Malop,TenLop', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Select S.Malop,TenLop,SiSo=Sum(MaSV) From Lop L, SinhVien S Where L.Malop=S.MaLop Group by S.Malop,TenLop', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Select S.Malop,TenLop,SiSo=Count(MaSV) From Lop L, SinhVien S Where L.Malop=S.MaLop Group by S.Malop,TenLop', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Select S.Malop,TenLop,SiSo=Count(SinhVien) From Lop L, SinhVien S Where L.Malop=S.MaLop Group by S.Malop,TenLop', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ Cơ sở dữ liệu sau: SinhVien(MaSV, HoSV, TenSV, Phai, NgaySinh, DiaChi, DienThoai, MaLop) Lop(MaLop, TenLop, MaKhoa, GVCN) KetQua(MaSV, MaMH, LanThi, Diem) MonHoc(MaMH, TenMH, SoTinChi) Liệt kê danh sách các sinh viên gồm (MaSV, HoSV, TenSV) đăng ký ít nhất là 3 môn học.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select K.MaSV, HoSV, TenSV From SinhVien S, KetQua K Where S.MASV=K.MASV And count(MaMH)>=3', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Select K.MaSV, HoSV, TenSV From SinhVien S, KetQua K Where S.MaSV=K.MaSV Having count(MaMH)>=3', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Select K.MaSV, HoSV, TenSV From SinhVien S, KetQua K Where S.MaSV=K.MaSV Group by K.MaSV, HoSV, TenSV Having count(MaMH)>=3', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Select K.MaSV, HoSV, TenSV From SinhVien S, KetQua K Where S.MASV=K.MASV And count(MaMH)>=3 Group by K.MaSV, HoSV, TenSV', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ CSDL gồm các bảng sau: KhachHang(MaKH, TenKH, ThanhPho) SanPham(MaSP, TenSP, SoLuong, DonGia) DaiLy (MaDL, TenDL, ThanhPho, HueHong) DatHang(MaDH, NgayDH, MaKH, MaDL, MaSP, SoLuong, ThanhTien) Chọn câu lệnh SQL để giải quyết câu truy vấn sau. Liệt kê tên các sản phẩm mà có từ hai khách hàng trở lên đặt hàng.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select TenSP from SanPham where MaSP in (select MaSP from DatHang where MaKH = ''c01'' and MaKH = ''c02'');', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Select TenSP from SanPham where MaSP in (select o1.MaSP from DatHang o1, DatHang o2 where o1.MaKH = ''c01'' and o2.MaKH = ''c02'' and o1.MaSP =o2.MaSP);', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Select TenSP from SanPham p, DatHang o1, DatHang o2 where p.MaSP =o1.MaSP and p.MaSP = o2.MaSP;', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Select distinct TenSP from SanPham p, DatHang o1, DatHang o2 where p.MaSP = o1.MaSP and p.MaSP = o2.MaSP and o1.MaKH <> o2.MaKH;', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ CSDL sau: NhanVien ( MaNV, HoNV, TenNV, DiaChi, ThanhPho ) KhachHang( MaKH, TenKH, DiaChi, ThanhPho, SoDu, GioiHanTinDung) HoaDon( MaHD, NgayLapHoaDon, MaKH, MaNV) ChiTietHoaDon (MaHD, MaSP, SoLuong,GiaBan ) SanPham(MaSP,MoTa, NhomHang, KhoHang,GiaGoc) Dựa vào lược đồ Cơ Sở Dữ liệu trên, Liệt kê ra sản phẩm có giá lớn nhất?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select * From SanPham Where GiaGoc=Max(GiaGoc)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Select * From SanPham Where GiaGoc=(Select Max(GiaGoc) From SanPham)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Select Top 1 * From SanPham Order by GiaGoc', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả các phương án trên là đúng.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ R(patient, consultant, hospital, address, date, time) với Khoa chính: (patient, consultant). Xác định dạng chuẩn cao nhất của R?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 3 (3NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 1(1NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dạng chuẩn Boyee-Codd (BCNF)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ gồm: NhaCungCap(MaNCC,TenNCC,ThanhPho) HangHoa(MaHang,TenHang,MauSac) CungUng(MaNCC,MaHang,SoLuong) Dùng SQL để tạo câu truy vấn sau: Liệt kê danh sách gồm MaHang,TenHang và số nhà cung cấp đến từ Atlanta mà cung cấp các sản phẩm có số lượng >100?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select Y.MaHang, Y.TenHang, Count(*) From NhaCungCap X, HangHoa Y, CungUng Z Where X.MaNCC = Z.MaNCC and Z.MaHang = Y.MaHang and X.ThanhPho= ''Atlanta'' and Z.SoLuong > 100;', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Select Y.MaHang, Y.TenHang, Count(*) From NhaCungCap X, HangHoa Y, CungUng Z Where X.MaNCC = Z.MaNCC and Z.MaHang = Y.MaHang and X.ThanhPho= ''Atlanta'' Group by Y.MaHang, Y.TenHang Having Count(*) > 100 Order by Y.MaHang ;', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Select Y.MaHang, Y.TenHang, Count(*) From NhaCungCap X, HangHoa Y, CungUng Z Where X.MaNCC = Z.MaNCC and Z.MaHang = Y.MaHang and X.ThanhPho= ''Atlanta'' and Z.SoLuong > 100 Group by Y.MaHang, Y.TenHang Order by Y.MaHang ;', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Select Y.MaHang, Y.TenHang, Count(*) From NhaCungCap X, HangHoa Y, CungUng Z Where X.MaNCC = Z.MaNCC and Z.MaHang = Y.MaHang and X.ThanhPho= ''Atlanta'' and Z.SoLuong > 100 Order by Y.MaHang ;', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ gồm: NhaCungCap(MaNCC,TenNCC,ThanhPho) HangHoa(MaHang,TenHang,MauSac) CungUng(MaNCC,MaHang,SoLuong) Tạo câu truy vấn SQL để tìm các sản phẩm được cung ứng bởi tất cả các nhà cung cấp.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select MaHang From CungUng Group By MaHang Having Count(*) = (Select Max(Count(*)) From CungUng Group By MaHang)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Select Max(X.MaHang) From CungUng X, NhaCungCap Y Where X.MaNCC = Y.MaNCC', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Select P.MaHang From HangHoa P, CungUng S Where P.MaHang = S.MaHang', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Select MaHang From CungUng Group By MaHang Having Count(*) = (Select Count(*) From NhaCungCap)', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ gồm: NhaCungCap(MaNCC,TenNCC,ThanhPho) HangHoa(MaHang,TenHang,MauSac) CungUng(MaNCC,MaHang,SoLuong) Tạo câu truy vấn SQL để tính tổng số lượng của từng sản phẩm đã cung ứng?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select MaHang,sum(SoLuong) From CungUng Group By MaHang;', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Select MaNCC, MaHang, sum(SoLuong) From HangHoa H, CungUng C Where H.MaHang = C.MaHang Group by MaNCC, MaHang;', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Select MaHang,SoLuong From CungUng;', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Select sum(SoLuong) From CungUng;', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ gồm: PhongBan(MaPB,TenPB,NganSach) NhanVien(MaNV,TenNV,ThanhPho,Luong,MaPB) Dùng SQL để tạo câu truy vấn sau: Liệt kê tên các phòng ban có ngân sách ít hơn tổng tiền lương của các nhân viên làm việc trong phòng ban đó?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select TenPB From PhongBan P, NhanVien N Where N.MaPB=P.MaPB AND NganSach <Luong', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Select TenPB From PhongBan P Where NganSach< (Select sum(Luong) From NhanVien N Where N.MaPB = P.MaPB)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Select TenPB From PhongBan Where NganSach< (Select sum(Luong) From NhanVien)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Select TenPB From PhongBan P, NhanVien N Where N.MaPB=P.MaPB AND NganSach <(Select sum(Luong) From NhanVien Group By MaPB)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ Q(A,B,C,D) và tập phụ thuộc hàm F={AB->C, B->D,BC->A}. Hỏi Q đạt dạng chuẩn nào?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 3 (3NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dạng chuẩn Boyee-Codd (BCNF)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ Q(A,B,C,D) và tập phụ thuộc hàm F={AB->C, D->B,C->ABD}. Hỏi Q đạt dạng chuẩn nào?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 3 (3NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dạng chuẩn Boyee-Codd (BCNF)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ Q(A,B,C,D) và tập phụ thuộc hàm F={AB->CD, B->C,C->D}. Phụ thuộc hàm nào là dư thừa?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'AB->CD', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'B->C', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'C->D', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Không có phụ thuộc hàm dư thừa', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ Q(A,B,C,D,E,G) và tập phụ thuộc hàm F={A->BC, C->DE,E- >G}. Hỏi Q đạt dạng chuẩn nào?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 3 (3NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dạng chuẩn Boyee-Codd (BCNF)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ Q(A,B,C,D,E,G,H) và tập phụ thuộc hàm F={A->BC,D->E,H- >G}. Hỏi Q đạt dạng chuẩn nào?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 3 (3NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dạng chuẩn Boyee-Codd (BCNF)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ Q(A,B,C,D,E,G,H) và tập phụ thuộc hàm F={C->AB,D->E,B- >G}. Hỏi Q đạt dạng chuẩn nào?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 3 (3NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dạng chuẩn Boyee-Codd (BCNF)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ Q(A,B,C,D,E,I) và tập phụ thuộc hàm F={ACD->EBI, CE->AD}. Hỏi Q đạt dạng chuẩn nào?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 3 (3NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dạng chuẩn Boyee-Codd (BCNF)', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ Q(C,S,Z) và tập phụ thuộc hàm F={CS->Z,Z->C}. Hỏi Q đạt dạng chuẩn nào?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 3 (3NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dạng chuẩn Boyee-Codd (BCNF)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ R và tập các phụ thuộc hàm F={AB->E, AG->I, BE->I, E->G, GI->H}. Phụ thuộc hàm nào sau đây được suy ra từ F?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'AB->GH', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'A->G', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'B->I', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'A->I', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ R(A,B,C,D) và tập phụ thuộc hàm F={A->BC, B->D,AB->D}. Phụ thuộc hàm nào là dư thưà?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'A->BC', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'B->D', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'AB->D', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Không có phụ thuộc hàm dư thừa', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ R(B,K,Q,A,O) với tập phụ thuộc hàm F={BK->QO, K->A, A- >B}. Phụ thuộc hàm nào sau đây không được dẫn xuất ra từ F?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'K->AQO', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'B->KQO', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'A->QO', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'K->B', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ R(Emp#,Dept#,City) và khóa K(Emp#,Dept#), tập phụ thuộc hàm F: F = {Emp# -> City, Emp# -> Dept#, Dept# -> City, Emp#,Dept# -> City}, Tập phụ thuộc hàm nào sau đây là phủ tối thiểu của F?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '{Emp#, Dept# -> City, Emp# -> Dept}', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '{Emp# -> Dept#, Dept# -> City}', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '{Emp# -> City, Dept# -> City}', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '{Emp# -> City, Emp# -> Dept#}', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ R(I,V,H,P,O,F,M) với tập phụ thuộc hàm F={IV->FM, O->IVH, HF->PM, HPM->F, IVM->O}. Bao đóng của {I V} là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '{I H P M O F}', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '{I V H P M O F}', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '{I V H M O F}', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '{I V H P M O}', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ R(J, F, Z, G) với tập phụ thuộc hàm F={J F->Z G, F Z->J G}. Bao đóng của {J F} là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '{J F Z}', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '{G J Z}', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '{J F G}', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '{F Z J G}', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ R(N,W,R,B,C) với tập phụ thuộc hàm F={N->W, W->R, N->B, C->N, B->C}. Tập thuộc tính nào sau đây không phải là khóa?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'B', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'W, R', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'N', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'C', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ R(P, G, I, F, O) với tập phụ thuộc hàm F={P->G, G->I, GI->P, P->F, O->P, F->O}. Tập thuộc tính nào sau đây không phải là khóa?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'G, I', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'F', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'P', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'O', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ R(V,Z,W,Y,F) với tập phụ thuộc hàm F={UX->VB, X->N, N->U}. Phụ thuộc hàm nào sau đây không được suy diễn từ F:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'VZ->V', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'VY->WZ', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'ZW->YF', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Z->F', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ R(W,B,F,K,A) với tập phụ thuộc hàm F={WB->F, FK->A, F->W, A->K}. Bao đóng của tập thuộc tính {W, B, A} đối với F là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '{W B A}', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '{W B A K}', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '{W B F K A}', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '{W B A F}', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ sau: Sach(TenSach,TacGia,NamXB,NhaXB) Chúng ta có thể suy ra phụ thuộc hàm:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'TacGia,NhaXB -> NhaXB', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'TacGia -> NhaXB', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'TenSach-> TacGia', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'NamXB -> NhaXB', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho mô hình thực thể kết hợp (Mô hình ER) như hình bên. Hãy chuyển từ mô hình ER sang lược đồ Cơ sở dữ liệu?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Học Viên (Mã học viên, tên học viên, địa chỉ, ngày sinh, số điện thoại, ngày nhập học, mã môn học) Môn học(Mã môn học, tên môn học, thời lượng) Khóa chính là Mã môn học Với: khoá chính của bảng học viên là Mã học viên và khoá chính của bảng môn học là Mã môn học.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Học Viên (Mã học viên, tên học viên, địa chỉ, ngày sinh, số điện thoại, ngày nhập học,Mã môn học) Môn học(Mã môn học, tên môn học, thời lượng, Mã học viên) Với: khóa chính của bảng học viên là Mã học viên, Mã môn học và khóa chính của bảng môn học là Mã môn học, Mã học viên.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Học Viên (Mã học viên, tên học viên, địa chỉ, ngày sinh, số điện thoại, ngày nhập học) Môn học(Mã môn học, tên môn học, thời lượng) GhiDanh(Mã học viên, Mã môn học) Với: khoá chính của bảng học viên là Mã học viên và khoá chính của bảng môn học là Mã môn học.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Học Viên (Mã học viên, tên học viên, địa chỉ, ngày sinh, số điện thoại, ngày nhập học) Môn học(Mã học viên, tên môn học, thời lượng, Mã học viên) Với: khóa chính của bảng học viên là Mã học viên và khoá chính của bảng môn học là Mã môn học.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho quan hệ student(sno, sname, cname, cno) với tập các khóa của student K={ (sno, cno),(sname, cname)}. Xác định dạng chuẩn cao nhất của student:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'BCNF', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '3NF', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho quan hệ (A,B,C), nếu A -> B, A -> C, và B -> C , câu nào sau đây đúng?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Quan hệ không ở dạng chuẩn 2NF', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'B là 1 khóa chính', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'C là 1 định danh', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Quan hệ giữa A và B là 1 khóa chính', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho quan hệ CungUng(MaNCC,MaHang,SoLuong) câu truy vấn SQL nào sao đây tương đương với phép chiếu (project) trong đại số quan hệ dựa trên cột MaNCC?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select MaNCC From CungUng;', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Select MaNCC From CungUng Order by MaNCC;', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Select * From CungUng;', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Select Distinct MaNCC From CungUng;', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho quan hệ CungUng(MaNCC,MaHang,SoLuong) Câu truy vấn SQL nào sao đây tương ứng với phép chiếu (project) và phép chọn (selection) trong đại số quan hệ?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select MaNCC From CungUng;', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Select * From CungUng;', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Select Distinct S1.MaNCC From CungUng S1, CungUng S2 Where S1.SoLuong > S2.SoLuong;', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Select Distinct MaNCC From CungUng Where SoLuong> 35;', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho quan hệ R([F,Z],C,K,S) ít nhất là đạt dạng chuẩn 3. Phụ thuộc hàm nào sau đây bị vi phạm?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'FC->S', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'CK->S', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'FZ->C', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'FZ->K', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Để giới hạn số dòng bị trùng trong câu truy vấn, Từ khóa nào nào sao đây được sử dụng trong câu lệnh Select?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Check', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Alter', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Distinct', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Specific', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Để lấy tất cả các dòng trong hai Table A và B ta dùng toán tử?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'product', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'intersection', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'union', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'difference', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Để sửa đổi cấu trúc của bảng ta sử dụng lệnh:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'ALTER DATABASE', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'ALTER TABLE', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'ALTER COLUMN', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Lựa chọn khác', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Để tạo bảng CSDL ta sử dụng lệnh:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'CREATE DATABASE', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'CREATE TABLE', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'ALTER TABLE', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Lựa chọn khác', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Để thay đổi dữ liệu hiện thời trong một bảng, bạn sẽ sử dụng lệnh _____.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'DELETE', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'CHANGE', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'SELECT', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'UPDATE', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Đếm (Count), Tổng (Sum), Trung bình (Avg), Tối đa (Max), và Tối thiểu (Min) là một số trong các hàm thống kê (statistics) sẵn có hoặc các hàm _____ có thể được sử dụng trong một truy vấn.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Accumulated (tổng)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Allowed (được phép)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Primary (chính)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Aggregate (gộp nhóm)', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Điều kiện nào sau đây trong một quan hệ luôn luôn đạt dạng chuẩn 2 (2NF)', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Nếu có phụ thuộc bắc cầu.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Nếu tất cả các khóa của quan hệ này chỉ gồm một thuộc tính.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Nếu chỉ có một khóa.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Nếu tất cả các phụ thuộc hàm là riêng phần.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Điều kiện để 2 bảng có thể kết (join) với nhau là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Hai bảng phải có cùng số cột.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Hai bảng phải có chung giá trị trong các dòng.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Hai bảng phải có chung ít nhất một cột.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Hai bảng phải có khóa chính.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Dữ liệu mô tả đầy đủ về một đối tượng gọi là?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Quan hệ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Bộ dữ liệu', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Lược đồ quan hệ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Lựa chọn khác', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Giả sử bảng Employee có n dòng dữ liệu (n>1). Hãy cho biết kết quả lệnh truy vấn sau có bao nhiêu dòng? SELECT e1.name, e2.name FROM employee e1, employee e2', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '0', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '>n', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'n', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '< n', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Giả sử lược đồ quan hệ R(A,B,C,D) đạt 3NF. Phụ thuộc hàm nào sau đây là không thuộc tâp phụ thuộc hàm F của R?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'BC->D', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'C->D', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'C->C', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Cả 3 lựa chọn trên', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Giả sử quan hệ R([K, W], U ,I, Z) đạt 3NF. Phụ thuộc hàm nào sau đây là sai?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'K, W->U', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'U, I->Z', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Lựa chọn khác', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'K, W->I', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Hai thực thể kết hợp với nhau theo mối kết hợp 1-n (không có phát sinh thuộc tính trong mối kết hợp) thì khi chuyển sang quan hệ số quan hệ sẽ là?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '2', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '3', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '1', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả đều sai', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Hai thực thể kết hợp với nhau theo mối kết hợp n-n thì khi chuyển sang quan hệ số quan hệ sẽ là?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '2', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '3', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '1', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả đều sai', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Hàm dùng để tính tổng các giá trị của cột kiểu number là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'ADD', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'TOTAL', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'AVERAGE', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'SUM', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Hàm nào sau đây dùng để tính tổng các giá trị của cột thuộc kiểu number?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'TOTAL', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'SUM', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'ADD', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'AVERAGE', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Hãy chuyển từ mô hình ER sang lược đồ Cơ sở dữ liệu? Với mô hình thực thể kết hợp (Mô hình ER) như hình bên.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Học Viên (Mã học viên, tên học viên, địa chỉ, ngày sinh, số điện thoại, ngày nhập học, mã môn học) Môn học(Mã môn học, tên môn học, thời lượng) Với: khoá chính của bảng học viên là Mã học viên Khoá chính của bảng "Môn học" là Mã môn học Khoá chính của bảng "Phiếu Ghi Danh" là Mã học viên, Mã môn học', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Học Viên (Mã học viên, tên học viên, điạ chỉ, ngày sinh, số điện thoại) Môn học(Mã môn học, tên môn học, thời lượng) Phiếu Ghi Danh(Mã học viên,Mã môn học,Ngày nhập học ) Với: khoá chính của bảng "Học Viên" là Mã học viên Khoá chính của bảng "Môn học" là Mã môn học Khoá chính của bảng "Phiếu Ghi Danh" là Mã học viên, Mã môn học', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Học Viên (Mã học viên, tên học viên, địa chỉ, ngày sinh, số điện thoại, ngày nhập học, Mã môn học) Môn học(Mã môn học, tên môn học, thời lượng) GhiDanh(Mã học viên, Mã môn học) Với: khoá chính của bảng học viên là Mã học viên Khoá chính của bảng "Môn học" là Mã môn học Khoá chính của bảng "Phiếu Ghi Danh" là Mã học viên, Mã môn học', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Học Viên (Mã học viên, tên học viên, địa chỉ, ngày sinh, số điện thoại, ngày nhập học) Môn học(Mã môn học, tên môn học, thời lượng, Mã học viên) Với: khóa chính của bảng học viên là Mã học viên Khoá chính của bảng "Môn học" là Mã môn học Khoá chính của bảng "Phiếu Ghi Danh" là Mã học viên, Mã môn học', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Họ tên, ngày sinh, số CMND của một người là ví dụ cho:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Thực thể', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Thuộc tính', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Quan hệ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Lựa chọn khác', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Khi chuyển mô hình ERD ở trên sang mô hình quan hệ thì số quan hệ là? (hình bên)', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '5', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '6', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '7', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '4', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Khi chuyển sang mô hình quan hệ mối kết hợp giữa NH N VIÊN và DỰ ÁN thì sẽ có số quan hệ là? (Hình bên)', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '3', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '2', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '4', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '5', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Khi chuyển sang mô hình quan hệ toàn bộ mô hình ERD ở trên thì sẽ có số quan hệ là (Hình bên)?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '3', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '6', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '4', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '5', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Khi hai hoặc nhiều bảng kết với nhau thì có bao nhiêu lần từ khóa WHERE được dùng?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Mỗi bảng 1 lần. n bảng sẽ có n từ khóa WHERE được sử dụng.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Hai.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Một.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả đều sai.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Khi mỗi một thuộc tính không khoá đều được xác định bởi cả khoá chính, thì quan hệ này ít nhất cũng thuộc dạng chuẩn sau:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 3 (3NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dạng chuẩn Boyee-Codd (BCNF)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Khi ta nói đến một quan hệ gồm có n-bộ (tuple), n ở đây có nghĩa là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Số bộ trong quan hệ.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Số byte trong một bộ.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Số thuộc tính trong quan hệ.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Số quan hệ trong Cơ sở dữ liệu.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Khi tạo một khóa ngoại, chúng ta cũng tạo một?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Ràng buộc tham chiếu khóa ngoại', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Ràng buộc kiểu con', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Ràng buộc khóa ngoại', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'ràng buộc khóa chính', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Khi thực hiện câu lệnh SQL để xóa cấu trúc của một bảng, điều gì xảy ra đối với dữ liệu chứa trong bảng đó?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Nếu bảng bị xóa là bảng cha, thì dữ liệu sẽ được đưa vào bảng con tương ứng.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Nếu bảng bị xóa là bảng con, thì dữ liệu sẽ đưa vào bảng cha tương ứng.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Không thể xóa được. Chỉ xóa được cấu trúc của bảng khi tất cả dữ liệu trong bảng đó đã bị xóa.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dữ liệu trong bảng đó cũng bị xóa theo.', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Khoá _____ của một bảng là cột hoặc một tập hợp các cột mà các cột này chỉ xác định một dòng đã cho trong bảng đó.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Primary (chính)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Secondary (phụ)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Foreign (ngoại)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Minor (nhỏ)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Khoá được định nghiã trên một thuộc tính hoặc một tập thuộc tính như sau:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Là một tập hợp nhỏ nhất các thuộc tính', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Bao đóng chưá tất cả các thuộc tính cuả bảng đó', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Là tập hợp nhỏ nhất các thuộc tính mà nó xác định được tất cả các thuộc tính còn lại trong bảng đó.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Nó xác định giá trị cuả tất cả các thuộc tính còn lại trong bảng.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Không có mệnh đề Where trong một câu lệnh Delete có ảnh hưởng gì?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Câu lệnh Delete sẽ lỗi do không có dòng nào được xóa.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Câu lệnh Delete sẽ thông báo cho người sử dụng nhập điều kiện để xóa.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Câu lệnh Delete sẽ xóa tất cả các mẩu tin trong bảng.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Câu lệnh Delete sẽ lỗi do sai cú pháp.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Ký hiệu X->Y được đọc là?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'X xác định Y', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Y phụ thuộc X', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Cả 2 phương án: 1 và 2', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Lựa chọn khác', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Ký tự nào sau đây được dùng để thay thế cho tất cả các cột trong mệnh đề SELECT:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '&', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '@', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '#', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '*', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Lệnh nào sau đây được dùng để thiết lập khóa ngoại:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Add foreign key MaPB to table NhanVien', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Insert MaPB into table NhanVien', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Create foreign key (MaPB) references NhanVien', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Alter table NhanVien add foreign key (MaPB) references PhongBan(MaPB)', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho bảng NhanVien(MaNV, HoTenNV, MaPB, Luong). Liệt kê danh sách tất cả các nhân viên và được sắp xếp giảm dần theo lương?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'SELECT * FROM NhanVien SORT BY Luong DESCENDING;', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'SELECT * FROM NhanVien IN ORDER OF Luong;', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'SELECT * FROM NhanVien ORDER BY Luong DESC;', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'SELECT * FROM NhanVien ORDER BY Luong;', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Lược đồ ER giúp chúng ta trong việc?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Thiết kế hàm', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Thiết kế cơ sở dữ liệu', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Thiết kế modul', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Thiết kế thủ tục', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Lược đồ quan hệ (Relation Schema) là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Một tập hợp các bộ.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Tập hợp tất cả các thuộc tính cần quản lý cuả một đối tượng cùng với mối quan hệ giữa chúng.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Một tập hợp giá trị dữ liệu.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Mô hình thực thể kết hợp.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Lược đồ quan hệ R đạt dạng chuẩn 3 nếu:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'R đạt dạng chuẩn 2 và mọi thuộc tính không khoá cuả R đều không phụ thuộc bắc cầu vào khoá chính.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Mỗi thuộc tính không khoá cuả R đều phụ thuộc đầy đủ vào khoá', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Tất cuả các thuộc tính cuả R có miền giá trị.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'R chứa chỉ 3 khoá.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mệnh đề FROM trong ngôn ngữ truy vấn dữ liệu SQL có tác dụng:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Giới hạn số dòng trong kết quả', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Thiết lập điều kiện', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Xác định nguồn dữ liệu trong truy vấn', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Lựa chọn khác', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mệnh đề gì để giới hạn giá trị đã thống kê của một cột nào đó cho lớn hơn một giá trị cho trước? Kết quả thống kê là các giá trị có thuộc tính là số.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'SELECT', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'GROUP BY', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'HAVING', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'WHERE', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mệnh đề nào sau đây được dùng để đặt điều kiện chọn nhóm trong câu lệnh truy vấn dữ liệu:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Where', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Find', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Having', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mệnh đề nào sau đây được dùng để nhập dữ liệu vào bảng publishers', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'insert into publishers data (''0010'', ''Pragmatics'', ''4 4th ln.'', ''Chicago'', ''IL'')', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'insert into publishers entities (''0010'', ''Pragmatics'', ''4 4th ln.'', ''Chicago'', ''IL'')', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'insert into publishers values (''0010'', ''Pragmatics'', ''4 4th ln.'', ''Chicago'', ''IL'')', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'insert into publishers tuples (''0010'', ''Pragmatics'', ''4 4th ln.'', ''Chicago'', ''IL'')', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mệnh đề nào trong câu truy vấn giới hạn số cột sẽ trả về?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'SELECT', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'ORDER BY', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'FROM', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'WHERE', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mệnh đề Order By trong câu lệnh SQL dùng để sắp sếp dữ liệu kết quả truy vấn. Ta có những phương pháp sắp xếp nào?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'ACS/DECS', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'ASC/DESC', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'ABS/DESC', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Lựa chọn khác', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mệnh đề SELECT trong ngôn ngữ truy vấn dữ liệu SQL có tác dụng:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Giới hạn số dòng trong kết quả', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Giới hạn số cột trong kết quả', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Thiết lập điều kiện', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Lựa chọn khác', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mệnh đề WHERE trong ngôn ngữ truy vấn dữ liệu SQL có tác dụng:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Giới hạn số cột trong kết quả', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Thiết lập điều kiện', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Xác định nguồn dữ liệu trong truy vấn', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Lựa chọn khác', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mô hình chuẩn để thiết kế hệ thống thông tin là mô hình nào sau đây?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Mô hình E-R', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Mô hình dữ liệu quan hệ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Lựa chọn khác', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả lựa chọn trên', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mô hình dữ liệu sử dụng trong các hệ quản trị cơ sở dữ liệu là mô hình nào?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Mô hình thực thể mối kết hợp', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Mô hình dữ liệu quan hệ', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Cả hai mô hình trên', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Lựa chọn khác', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mối kết hợp “Quản lý trực tiếp” được gọi là (Hình bên)?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Mối kết hợp được sinh ra từ một mối kết hợp khác', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Nhiều mối kết hợp khác nhau trên một cặp thực thể', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Mối kết hợp đệ qui', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả đều sai', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mối kết hợp “Quản lý trực tiếp” là mối kết hợp (Hình bên)', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '1-0', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '0-n', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '1-1', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '1-n', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mối kết hợp “Quản lý” là mối kết hợp (Hình bên)?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '0-1', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '0-n', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '1-1', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '1-n', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mối kết hợp “Tham gia” là mối kết hợp (Hình bên)?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '1-n', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'n-1', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '1-1', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'n-n', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mối kết hợp “Thuộc” là mối kết hợp (Hình bên)?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '1-1', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '1-n', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'n-n', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'n-1', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mối kết hợp giữa hai thực thể NH N VIÊN và LĨNH VỰC là mối kết hợp(Hình bên)', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '1-1', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '1-n', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'n-n', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả đều sai', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mối kết hợp giữa hai thực thể SINH VIÊN và MÔN HỌC được diễn giải như sau: mỗi sinh viên phải đăng ký ít nhất một môn học và có thể đăng ký nhiều môn. Mỗi môn học có thể có nhiều sinh viên đăng ký, nhưng có thể không có sinh viên nào đăng ký. Như vậy mối kết hợp giữa SINH VIÊN và MÔN HỌC là ?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '1-1', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '1-n', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'n-n', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '0-n', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Mối kết hợp giữa SÁCH và TÁC GIẢ là mối kết hợp? (hình bên)', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '1-n', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '1-1', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'n-1', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'n-n', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một lược đồ quan hệ đạt BCNF thì sẽ đạt chuẩn:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 3 (3NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn Boyce-Codd (BCNF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Cả 2 phương án: 1 và 2', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Lựa chọn khác', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một _____ có thể gán các mật khẩu cho những người dùng có quyền, và chỉ những người dùng đó mới có thể truy cập cơ sở dữ liệu khi nhập mật khẩu được chấp nhận.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'DBA', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'người thiết kế cơ sở dữ liệu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Switchboard (bảng mạch chuyển đổi)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'biểu đồ E-R', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một bảng có một khoá duy nhất (unique key). Một câu truy vấn thực hiện một phép kết bằng trên bảng này với chính nó thông qua khoá này. Bảng này có n dòng. Một dòng có giá trị khoá là rỗng (null). Kết quả cuả câu truy vấn trả về bao nhiêu dòng?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'ít hơn n dòng.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Nhiều hơn n dòng.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Không có dòng nào cả.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'n dòng', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một bảng có một khoá duy nhất. Một câu truy vấn thực hiện thao tác kết trên bảng sử dụng khoá này. Bảng có n hàng. Một hàng có 1 giá trị cuả khoá là rỗng (''null'') . Query trả về kết quả là bao nhiêu dòng?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Ít hơn n dòng.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Không có dòng nào', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'n dòng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Nhiều hơn n dòng.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một bảng đạt dạng chuẩn 1 (1NF):', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Không có sự lặp lại các thuộc tính và các nhóm trị.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Không rỗng.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Không rỗng và toàn bộ các thuộc tính cuả mọi bộ đều mang giá trị đơn.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Không rỗng và chỉ chứa các trị nguyên tố.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một bảng đạt dạng chuẩn 3 (3NF):', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Toàn bộ các thuộc tính cuả mọi bộ đều mang giá trị đơn.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Không phụ thuộc bắc cầu.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'tất cả các lựa chọn trên.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả các thuộc tính không khoá đều phụ thuộc đầy đủ vào khoá chính', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một bảng đạt dạng chuẩn BC (BCNF) nếu:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Không có phụ thuộc hàm bắc cầu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Bảng này đạt dạng chuẩn 3', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Bảng này đạt dạng chuẩn 2', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Mỗi phụ thuộc hàm đều có phiá bên trái cuả phụ thuộc hàm là siêu khoá', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một bảng đạt dạng chuẩn thứ nhất (1NF) nếu _____. 1. Nó không chứa các nhóm lặ', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Nó không chứa các nhóm lặp', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Nó không chứa một khoá ngoại', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Nó không chứa một khoá chính', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Nó không chứa các khoá dự tuyển.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một bảng mà không có sự lặp lại ở một nhóm trị, với khoá chính chỉ có một thuộc tính, và có một phụ thuộc bắc cầu vi phạm. Vậy bảng này ở dạng chuẩn nào?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 3 (3NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dạng chuẩn Boyce-Codd (BCNF)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một cơ sở dữ liệu có _____ nếu dữ liệu trong nó thoả mãn tất cả các ràng buộc về tính nguyên vẹn nhất định.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Tình trạng dư thừa', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Tính nguyên vẹn', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Tính độc lập của dữ liệu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Thiết kế cơ sở dữ liệu', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một cột không là khóa chính trong lược đồ quan hệ này mà là khóa chính trong lược đồ quan hệ khác gọi là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'quan hệ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'khóa', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'khóa ngoại', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'khóa dự tuyển', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một cột không phải là cột khoá nếu nó _____.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Không phải là một phần của khoá chính.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Là một phần của khoá chính.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Nằm trong dạng chuẩn 1 (1NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Nằm trong dạng chuẩn 2 (2NF)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một field dùng để định danh 1 dòng dữ liệu trong bảng gọi là?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Định danh query', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Khóa chính', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dòng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tiêu đề', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một giá trị ''null'' được gán vào một thuộc tính nào đó hàm ý là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Thuộc tính đó là khoá chính hoặc khoá ngoại.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Thuộc tính giới hạn ràng buộc cơ sở dữ liệu.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Giá trị thực không quan trọng ở thời điểm hiện tại.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Giá trị cuả thuộc tính này chỉ có người thiết kế CSDL mới biết.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một hệ quản trị cơ sở dữ liệu là phần mềm:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Phải quy định những đặc điểm nổi bậc cuả một từ điển dữ liệu.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Cung cấp các dịch vụ phục hồi và xử lý dữ liệu.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Tất cả điều đúng', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Cung cấp miền giá trị để lưu trữ dữ liệu.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một kết hợp giữa các thực thể được gọi là một _____.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'mối quan hệ', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Ràng buộc về tính nguyên vẹn', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Cơ sở dữ liệu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'File dữ liệu', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một khoá tối tiểu mà có thể thay thế cho khoá chính của một bảng được gọi là gì?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Khoá chính', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Khoá dự tuyển', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Khoá ngoại', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Thuộc tính khoá', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một loại query được đặc trong mệnh đề WHERE hoặc HAVING cuả một câu Query khác được gọi là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'master query.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'subquery.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'multi-query.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'superquery.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một lược đồ quan hệ có khóa là một thuộc tính thì ít nhất là đạt chuẩn:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 3 (3NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dạng chuẩn Boyce-Codd (BCNF)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một lược đồ quan hệ đạt 2NF thì sẽ đạt chuẩn:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 3 (3NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'BCNF', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Các lựa chọn trên đều đúng', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một lược đồ quan hệ đạt 3NF thì sẽ đạt chuẩn:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'BCNF', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Cả 2 phương án: 1 và 2', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Lựa chọn khác', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một lược đồ quan hệ gồm:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Tập hợp các giá trị', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Tập hợp các bộ dữ liệu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Tên lược đồ và các thuộc tính của nó', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Lựa chọn khác', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một lược đồ quan hệ mà các thuôc tính đều mang giá trị đơn thì sẽ đạt chuẩn:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 3 (3NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dạng chuẩn Boyce-Codd (BCNF)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một lược đồ quan hệ mà các thuộc tính không khóa đều phụ thuộc đầy đủ vào khóa thì sẽ đạt chuẩn:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 3 (3NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dạng chuẩn Boyce-Codd (BCNF)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một lược đồ quan hệ mà các thuộc tính không khóa không phụ thuộc bắc cầu vào khóa thì sẽ đạt chuẩn:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 3 (3NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dạng chuẩn Boyce-Codd (BCNF)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một nhân viên quản lý một nhân viên khác là ví dụ tốt nhất của?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Thực thể phụ thuộc', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Quan hệ ba ngôi', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Quan hệ một ngôi', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Quan hệ hai ngôi', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một nhược điểm của một hệ thống cơ sở dữ liệu là _____.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'một cỡ file lớn hơn', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Khiến cho dữ liệu bị phụ thuộc', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Tính nguyên vẹn bị giảm', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Năng suất giảm', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một số mô hình dữ liệu sử dụng cho hệ thống cơ sở dữ liệu là?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Mô hình E-R', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Mô hình dữ liệu quan hệ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Mô hình dữ liệu mạng, phân cấp, hướng đối tượng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả các phương án trên.', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một thuộc tính nguyên tố là một thuộc tính mà:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Là thành phần cuả một khoá ngoại', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Là một giá trị đơn', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Là thành phần cuả ít nhất một khoá dự tuyển.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Là thành phần cuả khoá chính.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Một truy vấn làm thay đổi dữ liệu là một truy vấn _____.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Addition (thêm)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Update (cập nhật)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Select (lựa chọn)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Nếu có các phụ thuộc hàm sau (A->B, B->C) trong lược đồ CSDL R(A,B) và S(B,C) thì phép kết giữa R và S sẽ:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Không bảo toàn thông tin.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Mất dữ liệu.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Bảo toàn thông tin.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả đều sai.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Nếu không có thuộc tính không khóa nào là không phụ thuộc vào một phần của khóa chính, thì quan hệ đó phải ở dạng chuẩn:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 3 (3NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả các câu đều sai.', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Nếu lược đồ R(A,B,C), có phụ thuộc hàm A->B và B->C. Thuộc tính nào mang ý nghĩa quyết định?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'B, C', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'A, B', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'A', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'A, B, C', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Nếu một lược đồ quan hệ có 5 thuộc tính, khóa của lược đồ gồm 3 thuộc tính. Khi đó ta sẽ có bao nhiêu siêu khóa:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '2', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '5', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '4', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '3', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Nếu NK->ME là một phụ thuộc hàm của lược đồ quan hệ H(N,K,M,E), thì:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'NK là khóa của H', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'NK là khóa chính của H', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Không thể tồn tại 2 bộ trong H mà có cùng giá trị của N và K', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả các câu đều đúng', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Nếu quan hệ R được phân rã thành {R1, R2, R3, …,Rn} và sự phân rã này bảo toàn thông tin thì:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Phép kết tự nhiên giữa R1, R2, ..., Rn sẽ trả về số bộ bằng với số bộ của quan hệ R ban đầu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Mỗi quan hệ R1, R2, ...,Rn đều đạt dạng chuẩn 3NF', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Phép kết tự nhiên giữa R1, R2, ..., Rn sẽ trả về số bộ nhiều hơn số bộ của quan hệ R ban đầu', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Không có câu nào đúng', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Người sử dụng có thể hiểu được một cơ sở dữ liệu thông qua một tập hợp các bảng, đó gọi là mô hình gì?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Quan hệ', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Phân cấp', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Mạng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Hướng đối tượng', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Nguyên tắc chỉ đạo trong thiết kế CSDL là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Giảm thiểu sự bất thường khi thêm hoặc xoá dữ liệu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Giảm thiểu sự bất thường khi cập nhật dữ liệu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Giảm thiểu dư thừa dữ liệu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả điều đúng', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Nguyên tắc chỉ đạo trong việc chuẩn hoá CSDL:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Giảm thiểu sự bất thường khi thêm hoặc xoá dữ liệu.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Giảm thiểu sự bất thường khi cập nhật dữ liệu.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Giảm thiểu dư thừa dữ liệu.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả điều đúng.', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Những đặc tính cơ bản để phân biệt DBMS với các hệ thống lập trình khác?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Khả năng quản lý dữ liệu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Khả năng truy xuất dữ liệu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Quản lý giao tác', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả các phương án trên', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Nơi có thể lưu trữ dữ liệu của các ứng dụng. Trong hệ thống CSDL gọi là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'DBMS', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Database', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'CPU', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Hard drive', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Phát biểu nào sau đây không phải là một lược đồ quan hệ?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Y(D, E, F)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Z(J, K(L, M))', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'X(B, C)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'W(A)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Phép toán nào sau đây trong đại số quan hệ yêu cầu tất cả các bảng phải có cùng tập thuộc tính?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Phép kết (Join), Phép chiếu (Projection), Phép kết tự nhiên (natural join)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Phép chia (Division), Phép giao (Intersection), Phép nhân(Multiplication)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Phép chia (Division), Phép giao (Intersection), Phép trừ (Minus)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Phép hợp (Union), Phép giao (Intersection), Phép trừ (Minus)', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Phép toán nào trong đại số học (algebra) bao gồm từ OVER, tiếp đó là một danh sách các cột?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'DELETE (Phép Xoá)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'PROJECT (Phép chiếu)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'INTERSECT (Phép giao)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Union (Phép hợp)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Phép toán nào trong đại số học quan hệ lấy một tập hợp con dọc của một bảng?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'SELECT', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'DELETE', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'PROGRAM', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'PROJECT (Phép chiếu)', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Phép toán nào trong đại số quan hệ được sử dụng để lấy một tập kết hợp gồm mọi dòng trong bảng thứ nhất với mọi dòng trong bảng thứ hai.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Union (Phép hợp)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Difference (Phép trừ)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Product (Phép tích Descartes)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Intersection (Phép giao)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Quan hệ (Relation), bộ (Tuple), thuộc tính (Attribute) thì đồng nghĩa tương ứng theo thứ tự sau:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Bảng (Table), cột(column), dòng(row)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Mẫu tin (Record), tập tin (File), trường(Field)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Tập tin (File), mẫu tin (record), trường (field)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dòng(row), cột(column) và giá trị (Value).', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Quan hệ nhiều-nhiều (n-n) trong lược đồ ERD có thể được trình bày trong mô hình quan hệ bởi:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Một khoá chính', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Một thuộc tính duy nhất', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Một miền giá trị', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Một quan hệ với hai khoá ngoại', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Ràng buộc CHECK có thể được cài đặt trong câu lệnh nào sau đây?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Create table', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Alter table', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Cả 2 phương án: 1 và 2', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Drop table', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Ràng buộc tòan vẹn nào sao đây sẽ tự động tạo ra một chỉ mục (index) khi được định nghĩa?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Ràng buộc khóa ngoại (Foreign keys)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Ràng buộc miền giá trị (Check Constraint)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Ràng buộc khóa chính (Primary keys)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Ràng buộc NOT NULL', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'SinhVien (MaSV, HoSV, TenSV, DiaChi, ThanhPho,MaVung) Dựa vào lược đồ quan hệ trên, Liệt kê danh sách các sinh viên có tên bắt đầu là N?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select * From SinhVien Where TenSV like ''N%''', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Select * From SinhVien Where left(TenSV,1)= ''N', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Select * From SinhVien Where TenSV in (select tensv from SinhVien Where tensv like ''N%'' )', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả các phương án trên', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'SinhVien (MaSV, HoSV, TenSV, DiaChi, ThanhPho,MaVung) Dựa vào lược đồ quan hệ trên, Liệt kê tất cả các thông tin cuả sinh viên mà có mã sinh viên từ 1100 đến 1200?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select * From SinhVien', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Select * From SinhVien Where MaSV between 1100 and 1200', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Select SinhVien Where MaSV between 1100 and 1200', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Select Masv From SinhVien Where MaSV >=1100', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'SinhVien (MaSV, HoSV, TenSV, DiaChi, ThanhPho,MaVung) Dựa vào lược đồ quan hệ trên, thay đổi mã vùng cuả của sinh viên ở Tp.HCM thành 08?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Update SinhVien Set MaVung=''08'' Where ThanhPho=''Tp.HCM''', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Update MaVung=''08'' Where ThanhPho=''Tp.HCM''', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Update SinhVien Where ThanhPho=''Tp.HCM'' And MaVung=''08''', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả các phương án trên', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Sự phân biệt giữa dữ liệu và thông tin nào sau đây là chính xác nhất?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dữ liệu và thông tin về bản chất là hoàn toàn giống nhau', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dữ liệu được lưu trữ ở mức thô, thông tin là đã được qua xử lý', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Không có sự phân biệt giữa dữ liệu và thông tin', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Lựa chọn khác', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Sự thể hiện (Bảng hai chiều) của lược đồ quan hệ Q tại thời điểm bất kỳ gọi là?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Quan hệ', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Bộ dữ liệu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Lược đồ quan hệ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Lựa chọn khác', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tạo lập một Cơ Sở dữ liệu là quá trình:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Cấu trúc Cơ Sở dữ liệu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Xử lý Cơ Sở dữ liệu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Thiết kế Cơ Sở dữ liệu', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Truy vấn Cơ Sở dữ liệu', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tập tất cả các thuộc tính của đối tượng cùng với các mối liên hệ giữa chúng gọi là?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Quan hệ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Bộ dữ liệu', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Lược đồ quan hệ', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Lựa chọn khác', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Tất cả các hàm sau đây được xây dựng sẳn trong SQL, ngoại trừ:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'COUNT', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'TOTAL', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'AVG', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'MIN', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Phép toán nào sau đây, chỉ có hiệu lực khi thực hiện trên các quan hệ trong cùng lược đồ CSDL', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Intersection (Phép giao)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Không có phương án nào', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Equi-Join (Phép kết bằng)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Cartesian product (Tích Descartes)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Thuộc tính mà xác định duy nhất một bộ trong một quan hệ được gọi là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Khoá ngoại.', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Khoá dự tuyển và khoá chính.', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Khoá chính', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Khoá dự tuyển', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Phép toán nào sau đây dùng để lấy các dòng dữ liệu có trong cả hai Table A và B', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'union (Phép hợp)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Intersection (Phép giao)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'product (Phép tích)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'difference (Phép trừ)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Trong câu lệnh truy vấn dữ liệu, để đặt bí danh (alias) cho bảng, cột ta sử dụng từ khóa gì?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '=', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'as', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '&', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '->', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Trong câu lệnh truy vấn dữ liệu, mệnh đề nào dùng để giới hạn số cột?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Select', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'From', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Where', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Having', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Trong lệnh cập nhật dữ liệu, nếu ta không dùng mệnh đề WHERE thì:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Sẽ không thực hiện lệnh cập nhật', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Chỉ một số dòng được cập nhật', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Không có dòng nào được cập nhật', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả các dòng sẽ được cập nhật', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Trong mô hình dữ liệu quan hệ, các đặc trưng riêng của đối tượng được gọi là?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Thuộc tính', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'đặc trưng riêng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'quan hệ', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Lựa chọn khác', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Trong SQL để định nghĩa một số DECIMAL có tối đa 7 số, có 4 chữ số thập phân. Ta khai báo:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'DECIMAL (7,3)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'DECIMAL (4,3)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'DECIMAL (7,4)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'DECIMAL (8,3)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Trong SQL, tên bảng (Table Name) phải duy nhất', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'cho tất cả các người sử dụng', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'trong phạm vi của một database', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'cho tất cả các database', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'trong tất cả các bảng mà được tạo ra bởi một người sử dụng nào đó', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Xét hai quan hệ R và S. Hãy cho biết kết quả của lệnh truy vấn sau: Select A From R Where B = ANY (Select B From S) R A B C ----------- a1 b1 c1 a1 b2 c2 a2 b1 c1 a2 b3 c2 a2 b3 c3 a4 b3 c3 S B C --------- b1 c1 b2 c2 b4 c3 b5 c2', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Một bảng gồm 1 cột A có 3 dòng (a1), (a1) và (a2) ồ', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Một bảng gồm 1 cột B và 2 dòng (b1) và (b2)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Một bảng gồm 1 cột A có 3 dòng (a1), (a1) và (a4)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Một bảng gồm 1 cột A có 5 dòng (a1), (a1), (a2), (a2) và (a2)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Xét lược đồ quan hệ R(T,V,X,P,K) với tập phụ hàm F={T V - >X, X P - >K, X - >T, K ->P} .Bao đóng của tậpf {T, V, K} là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '{T V K P}', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '{T V X P K}', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '{T V K X}', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '{T V K}', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Xét lược đồ quan hệ R = (I ,A,N,G,X) với tập phụ thuộc hàm F= {I A -> N G X , I -> X} .Khóa của R là:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'I', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'A X', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'I A', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'lựa chọn khác', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Xét lược đồ quan hệ R(A,B,C,D) với tập phụ hàm F={A->BC, B->D}. Gỉa sử tập khóa K={A}. R sẽ đạt thấp nhất là dạng chuẩn nào?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 3 (3NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dạng chuẩn Boyce-Codd (BCNF)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Xét lược đồ quan hệ R(A,B,C,D) với tập phụ hàm F={A->BCD}. Gỉa sử tập khóa K={A}. R sẽ đạt thấp nhất là dạng chuẩn nào?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 3 (3NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dạng chuẩn Boyce-Codd (BCNF)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Xét quan hệ R với tâp thuộc tính B C V K M. Với tập phụ thuộc hàm: B->C, C V->M và M K->B. Hãy xác định tất cả các khóa của R', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'B V K, C V K và V K M', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'B V M, C V K và V K M', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'V K, B Kvà V K M', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'B V, C K và V M', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Xét quan hệ R(A B C D E F H) với tập phụ thuộc hàm: A -> D, AE -> H, DF -> BC, E -> C, H -> E Phân rã R thành 3 quan hệ: (AD) (EC) (ABEFH). Phép phân rã đạt chuẩn:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn Boyce-Codd (BCNF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 3 (3NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Lựa chọn khác', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dạng chuẩn 1 (1NF)', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Xét quan hệ student(sno, sname, cname, cno). Gỉa sử các khóa của Student là (sno, cno) , (sname, cname) . Xác định dạng chuẩn của student:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn Boyce-Codd (BCNF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 3 (3NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dạng chuẩn 2 (2NF)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Xét R(A,B,C) với tập phụ thuộc hàm F={A->BC; A->C; B->C}. Phụ thuộc hàm nào trrong F là dư thừa?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'A->BC', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'A->C', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'B->C', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Lựa chọn khác', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Xét R(A,B,C,D) có khóa chính là A, là 2NF nhưng không đạt 3NF. Phụ thuộc hàm nào sau đây là không đúng:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'B->C', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'A->B', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'C->A', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'A->C', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Xét R(E,J,C,Q,G). Phụ thuộc hàm sau đây trong tập F= {E -> J; E Q -> C; Q J -> G; J -> C} là dư thừa:', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'J -> C', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Q J -> G', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'E Q-> C', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'E -> J', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Xét R(K,G,B,H,Z,C) Với tập phụ thuộc hàm F={K -> G, K -> B, B H -> Z, B H -> C, G -> Z}. Phụ thuộc hàm nào sau đây không được suy ra từ F?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'K -> Z', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'B H -> Z C', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'K H -> C', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'G -> B H', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Xét R{K , O , U , F , T } với tập phụ thuộc hàm F={ K -> F,T ;F-> O,U; K,U -> O }. Xác định dạng chuẩn của R?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 3 (3NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dạng chuẩn Boyce-Codd (BCNF)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ NhanVien(MaNV, HoTenNV, Luong, MaPB, NguoiQL, NgaySinh) và tập phụ thuộc hàm {MaNV->HoTenNV, Luong, MaPB, MaTruongPhong, NgaySinh; MaPB->MaTruongPhong}. Xác định dạng chuẩn cao nhất cuả bảng nhân viên.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 3 (3NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dạng chuẩn Boyce-Codd (BCNF)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ R(A,B,C,D) và tập phụ thuộc hàm F={AB->C,D->B,C->ABD}. Xác định dạng chuẩn cao nhất cuả lược đồ quan hệ R.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 3 (3NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dạng chuẩn Boyce-Codd (BCNF)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ R(A,B,C,D,E,H) và tập phụ thuộc hàm F={A->E,C->D,E- >DH}. Xác định dạng chuẩn cao nhất cuả lược đồ quan hệ R.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 3 (3NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dạng chuẩn Boyce-Codd (BCNF)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ R(A,B,C,D,E,I) và tập phụ thuộc hàm F={ACD->EBI,CE- >AD}. Xác định dạng chuẩn cao nhất cuả lược đồ quan hệ R.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 3 (3NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dạng chuẩn Boyce-Codd (BCNF)', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ R(B,F,D,H,I) và tập phụ thuộc hàm T={B->HI,H->FD,BD->F}. Tìm bao đóng cuả tập thuộc tính {BH}.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '{FDHI}', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '{BFDH}', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '{BFDHI}', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '{BFHI}', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ R(B,P,V,L,H) và tập phụ thuộc hàm F={B->P, P->V, PV->B,B- >L,H->B, L->H}. Tập thuộc tính nào sau đây không phải là khoá?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'L', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'B', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'H', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Tất cả các phương án trên đều là khoá', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ R(C,A,M,I,Z) và tập phụ thuộc hàm T={C->IZ,I->AM,CM->A}. Tìm bao đóng cuả tập thuộc tính {AIZ}.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', '{CAMI}', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', '{AMIZ}', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', '{CIAM}', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '{ZIMC}', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ R(C,F,O,A,K) và tập phụ thuộc hàm T={C->AK,A->FO,CO- >F}. Xác định dạng chuẩn cao nhất cuả lược đồ quan hệ R.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 3 (3NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dạng chuẩn Boyce-Codd (BCNF)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ R(E,S,J,W,N) và tập phụ thuộc hàm F={ES->JN, S->W, W- >E}. Phụ thuộc hàm nào sau đây không được suy diễn ra từ tập F?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'SJ->WN', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'S->N', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'ES->E', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'EW->JN', TRUE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ R(F,B,K,C,I) và tập phụ thuộc hàm T={FB->KI, B->C, C->F}. Phụ thuộc hàm nào sau đây không được suy diễn ra từ tập T?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'FC->KI', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'B->I', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'BK->CI', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'FB->F', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ R(G,M,V,N,H,P) và tập phụ thuộc hàm F={G->M,G->N, G->H, G->P , M->V, NHP->M}. Xác định dạng chuẩn cao nhất cuả lược đồ quan hệ R.', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 3 (3NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Dạng chuẩn Boyce-Codd (BCNF)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ R(I,Q,N,C,H) và tập phụ thuộc hàm F={IQ->NH, Q->C, C->I}. Phụ thuộc hàm nào sau đây không được suy diễn ra từ tập F?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'QN->CH', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'IC->NH', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'IQ->I', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Q->H', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ R(N,G,P,M) và tập phụ thuộc hàm F={NGP->M, M->P}. Xác định dạng chuẩn cao nhất cuả lược đồ quan hệ R', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'Dạng chuẩn 1 (1NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'Dạng chuẩn 2 (2NF)', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Dạng chuẩn 3 (3NF)', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', '4. Dạng chuẩn Boyce-Codd (BCNF)', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'Cho lược đồ quan hệ R(S,G,F,Y,N) và tập phụ thuộc hàm T={S->G, G->F, GF->S,S- >Y,S->N,N->S}. Tập thuộc tính nào sau đây không phải là khoá?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'N', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'GF', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'Y', TRUE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'S', FALSE);

INSERT INTO question (topic_id, content, difficulty_level, status, created_by) VALUES (@curr_topic_id, 'SQL cung cấp một số các hàm thống kê theo nhóm. Hàm nào sau đây không có trong SQL?', 'MEDIUM', 'APPROVED', @admin_id);
SET @curr_question_id = LAST_INSERT_ID();
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'A', 'MIN', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'B', 'MAX', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'C', 'COUNT', FALSE);
INSERT INTO answer_option (question_id, option_label, content, is_correct) VALUES (@curr_question_id, 'D', 'Average', TRUE);

