# Bài 4: Custom Network và Named Volume bằng Docker CLI

## 1. Mục tiêu

- Tạo Custom Bridge Network tên `app-net`.
- Tạo Named Volume tên `db-data`.
- Kết nối Backend và PostgreSQL bằng hostname `db-server`.
- Kiểm tra dữ liệu PostgreSQL vẫn tồn tại sau khi xóa và tạo lại container Database.

## 2. Công nghệ

- Docker CLI
- Docker Bridge Network
- Docker Named Volume
- PostgreSQL 15 Alpine
- Node.js và Express

## 3. Cấu trúc

- `commands.sh`: Script tạo network, volume, container và kiểm tra DNS, Data Persistence.
- `README.md`: Tài liệu hướng dẫn.

## 4. Thực thi

Chạy trong Git Bash hoặc WSL tại thư mục chứa `commands.sh`:

Image Backend hw-backend:v1 phải được build trước.
5. Kiến trúc
                 app-net (Bridge Network)
                /                        \
     app-container                    db-server
       Backend                       PostgreSQL 15
          |                               |
          +---- DB_HOST=db-server --------+
                                          |
                                    db-data (Volume)
                                          |
                              /var/lib/postgresql/data


6. Kiểm tra Network
docker network ls | grep app-net
docker network inspect app-net


7. Kiểm tra Volume
docker volume ls | grep db-data
docker volume inspect db-data


8. Kiểm tra DNS
docker exec -it app-container ping -c 2 db-server


Hostname db-server phải được phân giải thành IP nội bộ của container PostgreSQL.
9. Kiểm tra Data Persistence
Script thực hiện các bước:
1. Tạo bảng persistence_test.
2. Thêm một bản ghi kiểm thử.
3. Xóa container db-server.
4. Tạo lại container db-server với cùng volume db-data.
5. Truy vấn và so sánh dữ liệu sau khi khởi động lại.
Kết quả mong đợi:
 id | message
----+-------------------------------------
  1 | Data survives container recreation


Script in thông báo PASS nếu dữ liệu còn nguyên.