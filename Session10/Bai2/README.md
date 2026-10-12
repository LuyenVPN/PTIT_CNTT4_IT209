# Bài 2: Đóng gói Web Backend bằng Single-stage Dockerfile

## 1. Mục tiêu

Xây dựng REST API đơn giản bằng Node.js và Express, đóng gói ứng dụng thành Docker Image và triển khai bằng Docker Container.

## 2. Công nghệ

- Node.js 18 Alpine
- Express 4
- Docker

## 3. Cấu trúc dự án

- Dockerfile: cấu hình build image theo mô hình Single-stage.
- package.json: khai báo thông tin ứng dụng và dependency.
- server.js: triển khai REST API.
- README.md: tài liệu dự án.

## 4. Xây dựng Docker Image

```bash
docker build -t hw-backend:v1 .