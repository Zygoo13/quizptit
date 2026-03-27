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
* Maven (hoặc dùng `mvnw`)
* MySQL 8

---

## Setup & Run Local

```bash
# clone project
git clone <repo-url>
cd quizptit

# lấy branch develop
git checkout develop
git pull

# tạo file env
cp .env.example .env
```

### Cấu hình database

Tạo database trong MySQL:

```sql
CREATE DATABASE quizptit;
```

Cập nhật file `.env`:

```env
DB_HOST=localhost
DB_PORT=3306
DB_NAME=quizptit
DB_USER=root
DB_PASSWORD=your_password
SPRING_PROFILES_ACTIVE=local
```

---

### Chạy application

```bash
./mvnw spring-boot:run
```

---

## Configuration

```
application.yml           : cấu hình chung
application-local.yml     : cấu hình local
.env.example              : mẫu biến môi trường
.env                      : cấu hình local (không commit)
```

---

## Git Workflow

### Branch Strategy

```
main      : stable
develop   : working branch
feature/* : branch cho từng task
```

---

### Quy trình làm việc

```bash
# luôn bắt đầu từ develop
git checkout develop
git pull

# tạo branch mới
git checkout -b feature/<ten-task>

# code xong
git add .
git commit -m "feat: <mo-ta>"
git push origin feature/<ten-task>
```

Sau đó:

* tạo Pull Request: `feature/* → develop`
* không push trực tiếp vào `main`

---

