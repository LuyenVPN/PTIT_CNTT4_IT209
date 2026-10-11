# Bài 3: Đóng gói trang Web HTML tĩnh bằng Docker

## 1. Mục tiêu

Tạo trang web HTML tĩnh và đóng gói thành Docker Image sử dụng Nginx Alpine.

## 2. Cấu trúc thư mục

- Dockerfile
- index.html
- README.md

## 3. Nội dung index.html

    <h1>Hello Docker Session 09!</h1>

## 4. Nội dung Dockerfile

    FROM nginx:alpine
    COPY index.html /usr/share/nginx/html/index.html

## 5. Build Docker Image

    docker build -t my-html-app:v1 .

## 6. Khởi chạy container

    docker run -d -p 8081:80 --name html-app my-html-app:v1

## 7. Kiểm tra kết quả

    curl http://localhost:8081

Kết quả mong đợi:

    <h1>Hello Docker Session 09!</h1>

## 8. Kết luận

Đã đóng gói trang HTML tĩnh bằng Nginx Alpine, tạo Docker Image my-html-app:v1 và chạy container trên cổng 8081.
