# Bài 4: Cấu hình Reverse Proxy Nginx cho ứng dụng Spring Boot

## 1. Mục tiêu

Cấu hình Nginx làm Reverse Proxy cho ứng dụng Spring Boot.

Mô hình:

```text
Client
  |
  | HTTP :80
  v
Nginx
  |
  +---- / --------------------> /var/www/html/
  |
  +---- /api/ ----------------> Spring Boot :8082
```

Nginx chịu trách nhiệm:

- Phục vụ trang web tĩnh tại `/`.
- Chuyển tiếp các request bắt đầu bằng `/api/` đến Spring Boot.
- Chuyển tiếp thông tin Host và IP của client đến backend.

---

## 2. Tạo thư mục website

Tạo thư mục:

```bash
sudo mkdir -p /var/www/html
```

Tạo file:

```bash
sudo nano /var/www/html/index.html
```

Nội dung:

```html
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin học viên</title>
</head>
<body>
    <h1>Thông tin học viên</h1>

    <p><strong>Họ tên:</strong> Đặng Văn Luyện</p>
    <p><strong>Mã lớp:</strong> IT209</p>

</body>
</html>
```

---

## 3. Tạo cấu hình Nginx

Tạo file:

```text
/etc/nginx/sites-available/spring-proxy.conf
```

Nội dung:

```nginx
server {
    listen 80;
    listen [::]:80;

    server_name _;

    location / {
        root /var/www/html;
        index index.html;
    }

    location /api/ {
        proxy_pass http://127.0.0.1:8082/;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

---

## 4. Kích hoạt Server Block

Tạo symbolic link:

```bash
sudo ln -s /etc/nginx/sites-available/spring-proxy.conf /etc/nginx/sites-enabled/spring-proxy.conf
```

Kiểm tra:

```bash
ls -l /etc/nginx/sites-enabled/
```

Kết quả:

```text
spring-proxy.conf -> /etc/nginx/sites-available/spring-proxy.conf
```

---

## 5. Kiểm tra cấu hình Nginx

Chạy:

```bash
sudo nginx -t
```

Kết quả:

```text
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```

Cấu hình Nginx hợp lệ.

---

## 6. Reload Nginx

Sau khi kiểm tra cú pháp thành công:

```bash
sudo systemctl reload nginx
```

Kiểm tra trạng thái:

```bash
sudo systemctl status nginx
```

Kết quả:

```text
Active: active (running)
```

---

## 7. Kiểm tra trang Static

Thực hiện:

```bash
curl -I http://localhost/
```

Kết quả:

```text
HTTP/1.1 200 OK
Server: nginx
Content-Type: text/html
```

Trang `/` được Nginx phục vụ trực tiếp từ:

```text
/var/www/html/index.html
```

Kiểm tra nội dung:

```bash
curl http://localhost/
```

Kết quả:

```html
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin học viên</title>
</head>
<body>
    <h1>Thông tin học viên</h1>

    <p><strong>Họ tên:</strong> Đặng Văn Luyện</p>
    <p><strong>Mã lớp:</strong> IT209</p>
</body>
</html>
```

---

## 8. Kiểm tra Reverse Proxy

Kiểm tra API:

```bash
curl -i http://localhost/api/health
```

Request có dạng:

```text
Client
  |
  | GET /api/health
  v
Nginx :80
  |
  | proxy_pass
  v
Spring Boot :8082
```

Kết quả mong đợi:

```text
HTTP/1.1 200 OK
Content-Type: application/json
```

và nhận được response từ Spring Boot backend.

Không xuất hiện:

```text
502 Bad Gateway
```

---

## 9. Kiểm tra cấu hình định tuyến

### Static

Request:

```text
GET /
```

được xử lý bởi:

```nginx
location / {
    root /var/www/html;
    index index.html;
}
```

Nginx trả về:

```text
/var/www/html/index.html
```

### API

Request:

```text
GET /api/health
```

được xử lý bởi:

```nginx
location /api/ {
    proxy_pass http://127.0.0.1:8082/;
}
```

và được chuyển đến Spring Boot.

---

## 10. Kết quả

| Thành phần | Cấu hình | Kết quả |
|---|---|---|
| Nginx | Port 80 | Hoạt động |
| Static `/` | `/var/www/html/` | HTTP 200 |
| API `/api/` | Spring Boot `127.0.0.1:8082` | Reverse Proxy |
| `nginx -t` | Kiểm tra syntax | Successful |
| Nginx service | systemd | Active |
| Backend | Port 8082 | Được Nginx chuyển tiếp |
