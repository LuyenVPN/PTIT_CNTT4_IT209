\# Báo cáo Bài 2 - Quản lý nhánh và giải quyết xung đột



\## 1. Tạo nhánh



Tạo nhánh `feature-update` từ `main`:



```bash

git checkout -b feature-update

```



\## 2. Tạo xung đột



Tôi chỉnh sửa `README.md` trên nhánh `feature-update`, sau đó commit.



Tiếp theo quay lại `main` và chỉnh sửa cùng nội dung trong `README.md`, sau đó commit.



\## 3. Merge và phát sinh conflict



Thực hiện:



```bash

git merge feature-update

```



Git phát hiện xung đột trong `README.md`.



\## 4. Giải quyết thủ công



Tôi mở `README.md` và xử lý thủ công các marker:



\- `<<<<<<<`

\- `=======`

\- `>>>>>>>`



Sau đó xóa các marker và giữ lại nội dung cần thiết từ cả hai nhánh.



\## 5. Hoàn tất merge



Thực hiện:



```bash

git add README.md

git commit -m "merge: resolve README conflict"

```



\## 6. Kiểm tra



Sử dụng:



```bash

git log --graph --oneline

```



Lịch sử cho thấy `feature-update` được tách từ `main` và sau đó được hợp nhất bằng merge commit.



Merge commit:



`711f653 merge: resolve README conflict`

```

