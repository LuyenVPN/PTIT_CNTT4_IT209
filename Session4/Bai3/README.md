```

\# Bài 3: Cấu hình xác thực SSH và Đẩy dự án lên GitHub



\## 1. Mục tiêu



\- Cấu hình xác thực SSH với GitHub.

\- Sử dụng thuật toán Ed25519.

\- Liên kết repository cục bộ với GitHub bằng giao thức SSH.

\- Đẩy mã nguồn và lịch sử commit lên GitHub.



\## 2. Tạo và kiểm tra SSH Key



Máy tính đã có sẵn cặp khóa SSH Ed25519:



\- `id\_ed25519`: private key.

\- `id\_ed25519.pub`: public key.



Private key không được chia sẻ hoặc đưa lên repository.



Public key được cấu hình trên tài khoản GitHub.



\## 3. Kiểm tra kết nối SSH



Sử dụng lệnh:



```bash

ssh -T git@github.com

```



Kết quả:



```text

Hi LuyenVPN! You've successfully authenticated, but GitHub does not provide shell access.

```



Kết quả trên xác nhận kết nối SSH tới GitHub đã được xác thực thành công.



\## 4. Cấu hình Git Remote



Ban đầu repository sử dụng HTTPS. Remote được chuyển sang giao thức SSH bằng lệnh:



```bash

git remote set-url origin git@github.com:LuyenVPN/PTIT\_CNTT4\_IT209.git

```



Kiểm tra:



```bash

git remote -v

```



Kết quả:



```text

origin  git@github.com:LuyenVPN/PTIT\_CNTT4\_IT209.git (fetch)

origin  git@github.com:LuyenVPN/PTIT\_CNTT4\_IT209.git (push)

```



Như vậy repository đã sử dụng SSH thay vì HTTPS.



\## 5. Xử lý lịch sử Git và Conflict



Trong quá trình push, repository từ xa có các commit mà repository cục bộ chưa có.



Đã thực hiện lấy thay đổi từ remote và rebase:



```bash

git fetch origin

git pull --rebase origin main

```



Trong quá trình rebase phát sinh conflict tại:



```text

Session4/Bai2/README.md

```



Conflict được giải quyết thủ công, sau đó tiếp tục rebase bằng:



```bash

git add ../Bai2/README.md

git rebase --continue

```



Sau khi xử lý hoàn tất, kiểm tra trạng thái:



```bash

git status

```



Kết quả:



```text

On branch main

Your branch is ahead of 'origin/main' by 1 commit.

nothing to commit, working tree clean

```



\## 6. Push lên GitHub



Đẩy các commit lên GitHub bằng SSH:



```bash

git push -u origin main

```



Kết quả:



```text

To github.com:LuyenVPN/PTIT\_CNTT4\_IT209.git

main -> main

branch 'main' set up to track 'origin/main'.

```



Sau đó kiểm tra lại và nhận được:



```text

Everything up-to-date

```



\## 7. Repository GitHub



Repository:



```text

https://github.com/LuyenVPN/PTIT\_CNTT4\_IT209

```



SSH URL:



```text

git@github.com:LuyenVPN/PTIT\_CNTT4\_IT209.git

```



