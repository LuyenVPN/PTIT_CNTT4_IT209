\# Bài 2: Cấu hình phân quyền Nhóm và sudoers bằng visudo



\## 1. Mục tiêu



\- Tạo group `devops-admin`.

\- Tạo user `deployer`.

\- Đưa user `deployer` vào group `devops-admin`.

\- Cấu hình `/etc/sudoers` để group `devops-admin` được phép thực hiện các lệnh quản lý service bằng `systemctl`.

\- Không cấp toàn quyền root cho user `deployer`.



\## 2. Tạo group devops-admin



Đã tạo group:



```bash

sudo groupadd devops-admin

```



\## 3. Tạo user deployer



Đã tạo user:



```bash

sudo adduser deployer

```



Đưa user `deployer` vào group `devops-admin`:



```bash

sudo usermod -aG devops-admin deployer

```



Kiểm tra group:



```bash

groups

```



Kết quả:



```text

deployer devops-admin

```



Như vậy user `deployer` đã thuộc group `devops-admin`.



\## 4. Cấu hình sudoers bằng visudo



Mở file sudoers bằng:



```bash

sudo visudo

```



Thêm cấu hình:



```text

%devops-admin ALL=(ALL) NOPASSWD: /usr/bin/systemctl start \*, /usr/bin/systemctl stop \*, /usr/bin/systemctl restart \*, /usr/bin/systemctl status \*

```



Ý nghĩa:



\- `%devops-admin`: áp dụng quyền cho tất cả user thuộc group `devops-admin`.

\- `ALL=(ALL)`: cho phép chạy lệnh với quyền được sudo cấp.

\- `NOPASSWD`: không yêu cầu nhập password.

\- `systemctl start \*`: cho phép khởi động service.

\- `systemctl stop \*`: cho phép dừng service.

\- `systemctl restart \*`: cho phép restart service.

\- `systemctl status \*`: cho phép kiểm tra trạng thái service.



\## 5. Kiểm tra user deployer



Đăng nhập bằng user:



```bash

su - deployer

```



Kiểm tra user hiện tại:



```bash

whoami

```



Kết quả:



```text

deployer

```



Kiểm tra group:



```bash

groups

```



Kết quả:



```text

deployer devops-admin

```



\## 6. Kiểm tra quyền sudo



Thực hiện:



```bash

sudo -l

```



Kết quả:



```text

User deployer may run the following commands on ip-172-31-34-25:

&#x20;   (ALL) NOPASSWD: /usr/bin/systemctl start \*, /usr/bin/systemctl stop \*,

&#x20;       /usr/bin/systemctl restart \*, /usr/bin/systemctl status \*

```



Kết quả cho thấy user `deployer` được cấp quyền thông qua group `devops-admin` và các lệnh `systemctl` được cấu hình với `NOPASSWD`.



\## 7. Kiểm tra restart service



Trên Amazon Linux 2023, hệ thống không có service `cron`, vì vậy sử dụng service `chronyd` đang chạy để kiểm tra.



Thực hiện:



```bash

sudo systemctl restart chronyd

```



Lệnh chạy thành công mà không yêu cầu nhập password.



Sau đó kiểm tra:



```bash

sudo systemctl status chronyd

```



Kết quả:



```text

● chronyd.service - NTP client/server

&#x20;    Loaded: loaded (/usr/lib/systemd/system/chronyd.service; enabled)

&#x20;    Active: active (running)

```



