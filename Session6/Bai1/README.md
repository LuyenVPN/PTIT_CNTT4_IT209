\# Bài 1: Khảo sát FHS và Phân quyền File/Folder nâng cao



\## 1. Mục tiêu



\- Tạo cấu trúc thư mục theo chuẩn FHS.

\- Thực hành phân quyền file/folder bằng octal.

\- Thực hành thay đổi owner và group.

\- Sử dụng nhóm `www-data` cho thư mục ứng dụng web.



\## 2. Tạo cấu trúc thư mục



Đã tạo thư mục `/var/www/my-app` gồm hai thư mục con:



\- `public`: chứa mã nguồn/trang web static.

\- `logs`: chứa nhật ký hệ thống.



Các lệnh đã thực hiện:



```bash

sudo mkdir -p /var/www/my-app/public

sudo mkdir -p /var/www/my-app/logs

```



\## 3. Gán owner và group



Sử dụng tài khoản hiện tại làm owner và nhóm `www-data` làm group:



```bash

sudo chown -R $USER:www-data /var/www/my-app

```



\## 4. Phân quyền thư mục public



Yêu cầu:



\- Owner: đọc, ghi, thực thi (`rwx`).

\- Group: đọc, thực thi (`r-x`).

\- Others: không có quyền (`---`).



Sử dụng quyền `750`:



```bash

sudo chmod 750 /var/www/my-app/public

```



Quyền mong đợi:



```text

drwxr-x---

```



\## 5. Phân quyền thư mục logs



Yêu cầu:



\- Owner: toàn quyền (`rwx`).

\- Group: toàn quyền (`rwx`).

\- Others: không có quyền (`---`).



Sử dụng quyền `770`:



```bash

sudo chmod 770 /var/www/my-app/logs

```



Quyền mong đợi:



```text

drwxrwx---

```



\## 6. Kiểm tra kết quả



Lệnh kiểm tra:



```bash

ls -la /var/www/my-app

```



Kết quả thực tế:



```text

\# Dán output của lệnh ls -la /var/www/my-app vào đây

```

