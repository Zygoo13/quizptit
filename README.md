# QuizPTIT

## Tech Stack

* Java: 21
* Spring Boot: 3.5.13
* Build Tool: Maven
* Database: MySQL 8
* ORM: Spring Data JPA (Hibernate)
* Migration: Flyway
* Security: Spring Security (Session-based, RBAC)
* Template Engine: Thymeleaf
* Validation: Jakarta Validation
* Boilerplate: Lombok

---

## Project Structure

```
com.quizptit
├── common
├── auth
├── user
├── content
├── quiz
├── attempt
├── progress
├── review
└── community
```

---

## Prerequisites

* Java 21
* Maven (hoặc sử dụng `mvnw`)
* MySQL 8

---

## Setup and Run (Local Environment)

### 1. Clone repository

```bash
git clone <repo-url>
cd quizptit
```

### 2. Checkout development branch

```bash
git checkout develop
git pull
```

### 3. Configure local database

Tạo database trong MySQL:

```sql
CREATE DATABASE quizptit;
```

Tạo file cấu hình local:

* Sao chép file mẫu:

```
src/main/resources/application-local.example.yml
```

* Thành:

```
src/main/resources/application-local.yml
```

* Cập nhật thông tin kết nối database theo môi trường máy:

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/quizptit
    username: your_database_username
    password: your_database_password
```

---

### 4. Run application

```bash
./mvnw spring-boot:run
```

Ứng dụng sẽ chạy tại:

```
http://localhost:8080
```

---

## Configuration

```
application.yml                      : cấu hình chung của hệ thống
application-local.yml                : cấu hình local 
```

---

## Git Workflow

### Branch Strategy

```
main        : nhánh ổn định (dùng cho release / demo)
develop     : nhánh phát triển chính
feature/*   : nhánh phát triển theo từng chức năng
```

---

### Development Workflow

```bash
# cập nhật nhánh develop
git checkout develop
git pull

# tạo nhánh chức năng
git checkout -b feature/<ten-task>

# thực hiện phát triển và commit
git add .
git commit -m "feat: <mo-ta>"

# đẩy nhánh lên remote
git push origin feature/<ten-task>
```

Sau khi hoàn thành:

* Tạo Pull Request từ `feature/*` vào `develop`
* Thực hiện review trước khi merge
* Không commit trực tiếp vào `main`

---

## Notes

* Không commit các file cấu hình môi trường local
* Không lưu trữ thông tin nhạy cảm (password, secret) trong source code
* Mọi thay đổi phải thông qua Pull Request và được review trước khi merge
