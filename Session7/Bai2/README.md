\# Bài 2: Quản trị Tường lửa UFW cho Cụm Dịch vụ Multi-port



\## 1. Mục tiêu



Thiết lập tường lửa UFW để bảo mật máy chủ chạy nhiều dịch vụ đồng thời.



Các dịch vụ trên máy chủ:



\- SSH: port `22/tcp`

\- Nginx Web: port `80/tcp`

\- Spring Boot: port `8082/tcp`

\- MySQL: port `3306/tcp`



Yêu cầu bảo mật:



\- Chặn mặc định tất cả kết nối đi vào.

\- Cho phép kết nối SSH qua port `22/tcp`.

\- Cho phép HTTP qua port `80/tcp`.

\- Cho phép ứng dụng Spring Boot qua port `8082/tcp`.

\- Không cho phép kết nối MySQL từ Internet qua port `3306/tcp`.



\---



\## 2. Cấu hình chính sách mặc định



Sử dụng các lệnh:



```bash

sudo ufw default deny incoming

sudo ufw default allow outgoing

```



Trong đó:



\- `deny incoming`: mặc định chặn tất cả kết nối đi vào máy chủ.

\- `allow outgoing`: cho phép máy chủ thực hiện các kết nối đi ra ngoài.



\---



\## 3. Cho phép các dịch vụ cần thiết



Cho phép SSH:



```bash

sudo ufw allow 22/tcp

```



Cho phép HTTP:



```bash

sudo ufw allow 80/tcp

```



Cho phép Spring Boot:



```bash

sudo ufw allow 8082/tcp

```



Không tạo luật `allow` cho MySQL `3306/tcp`, vì vậy port này tiếp tục bị chặn bởi chính sách `deny incoming`.



\---



\## 4. Kích hoạt UFW



Kích hoạt firewall bằng lệnh:



```bash

sudo ufw enable

```



\---



\## 5. Kiểm tra trạng thái UFW



Sử dụng lệnh:



```bash

sudo ufw status verbose

```



Kết quả:



```text

Status: active

Logging: on (low)

Default: deny (incoming), allow (outgoing), disabled (routed)



To                         Action      From

\--                         ------      ----

22/tcp                     ALLOW       Anywhere

80/tcp                     ALLOW       Anywhere

8082/tcp                   ALLOW       Anywhere

22/tcp (v6)                ALLOW       Anywhere (v6)

80/tcp                     ALLOW       Anywhere (v6)

8082/tcp                   ALLOW       Anywhere (v6)

```



\---



\## 6. Phân tích kết quả



\### Port 22/tcp



```text

22/tcp ALLOW Anywhere

```



Cho phép kết nối SSH từ bên ngoài để quản trị máy chủ.



\### Port 80/tcp



```text

80/tcp ALLOW Anywhere

```



Cho phép truy cập website thông qua Nginx bằng giao thức HTTP.



\### Port 8082/tcp



```text

8082/tcp ALLOW Anywhere

```



Cho phép truy cập ứng dụng Spring Boot từ xa để kiểm tra.



\### Port 3306/tcp



Port `3306/tcp` không xuất hiện trong danh sách `ALLOW`.



Do chính sách mặc định là:



```text

Default: deny (incoming)

```



nên kết nối từ Internet tới MySQL port `3306` sẽ bị chặn.



\---

