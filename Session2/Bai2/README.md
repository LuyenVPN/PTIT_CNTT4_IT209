# Bài 2: Khởi tạo User thường và thiết lập đặc quyền quản trị

## 1. Mục tiêu

- Tạo tài khoản người dùng thường `devops`.
- Cấp quyền quản trị cho `devops`.
- Cấu hình SSH Key để `devops` có thể đăng nhập SSH.
- Phân quyền đúng cho thư mục `.ssh` và file `authorized_keys`.
- Kiểm tra quyền `sudo` bằng lệnh `sudo whoami`.

> **Lưu ý:** Bài yêu cầu Ubuntu và nhóm `sudo`, nhưng môi trường thực tế sử dụng Amazon Linux trên EC2. Vì vậy nhóm quản trị tương ứng là `wheel`.

---

## 2. Tạo user `devops`

Tạo user:

```bash
sudo adduser devops
```

Kiểm tra user:

```bash
id devops
```

Kết quả:

```text
uid=1001(devops) gid=1001(devops) groups=1001(devops)
```

User `devops` đã được tạo thành công.

**Minh chứng:** `screenshots/01-create-user.png`

---

## 3. Thêm `devops` vào nhóm quản trị

Trên Amazon Linux, nhóm quản trị là `wheel`.

Thực hiện:

```bash
sudo usermod -aG wheel devops
```

Kiểm tra:

```bash
groups devops
```

Kết quả:

```text
devops : devops wheel
```

Điều này cho phép user `devops` sử dụng quyền quản trị thông qua `sudo`.

**Minh chứng:** `screenshots/02-sudo-group.png`

---

## 4. Thiết lập password cho `devops`

Đặt password:

```bash
sudo passwd devops
```

Sau khi nhập password hai lần, hệ thống hiển thị:

```text
passwd: all authentication tokens updated successfully.
```

Không ghi password thật vào README.

---

## 5. Cấu hình SSH Key

Kiểm tra SSH Key của `ec2-user`:

```bash
ls -la ~/.ssh
```

Tạo thư mục `.ssh` cho `devops`:

```bash
sudo mkdir -p /home/devops/.ssh
```

Sao chép `authorized_keys`:

```bash
sudo cp /home/ec2-user/.ssh/authorized_keys /home/devops/.ssh/authorized_keys
```

---

## 6. Thiết lập owner cho SSH

Thực hiện:

```bash
sudo chown -R devops:devops /home/devops/.ssh
```

Kiểm tra:

```bash
sudo ls -ld /home/devops/.ssh
```

Owner phải là:

```text
devops devops
```

---

## 7. Phân quyền thư mục `.ssh`

Thiết lập quyền `700`:

```bash
sudo chmod 700 /home/devops/.ssh
```

Kiểm tra:

```bash
sudo ls -ld /home/devops/.ssh
```

Kết quả mong đợi:

```text
drwx------ ... devops devops ... /home/devops/.ssh
```

---

## 8. Phân quyền file `authorized_keys`

Thiết lập quyền `600`:

```bash
sudo chmod 600 /home/devops/.ssh/authorized_keys
```

Kiểm tra:

```bash
sudo ls -l /home/devops/.ssh/authorized_keys
```

Kết quả mong đợi:

```text
-rw------- ... devops devops ... authorized_keys
```

**Minh chứng:** `screenshots/03-ssh-permission.png`

---

## 9. Đăng nhập SSH bằng user `devops`

Từ máy cá nhân sử dụng private key tương ứng:

```powershell
ssh -i "C:\sshkeys\luyendv.pem" devops@52.64.126.224
```

Sau khi đăng nhập thành công, kiểm tra:

```bash
whoami
```

Kết quả:

```text
devops
```

Điều này chứng minh user `devops` có thể đăng nhập SSH thành công.

**Minh chứng:** `screenshots/04-ssh-login.png`

---

## 10. Kiểm tra nhóm quản trị

Sau khi đăng nhập bằng `devops`:

```bash
groups
```

Kết quả:

```text
devops wheel
```

User `devops` đã thuộc nhóm quản trị `wheel`.

---

## 11. Kiểm tra quyền sudo

Thực hiện:

```bash
sudo whoami
```

Nhập password của user `devops`.

Kết quả:

```text
root
```

Điều này chứng minh user `devops` có quyền thực hiện các lệnh quản trị thông qua `sudo`.

**Minh chứng:** `screenshots/05-sudo-check.png`

---
