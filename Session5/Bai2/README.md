```markdown

\# Bài 2: Tái cấu trúc lịch sử commit bằng Interactive Rebase



\## 1. Mục tiêu



Sử dụng Interactive Rebase để chỉnh sửa lịch sử commit cục bộ, gộp các commit nhỏ, đổi tên commit message và xóa commit không cần thiết.



\## 2. Các commit ban đầu



Đã tạo các commit trên nhánh `feature/auth`:



\- `feat: khoi tao module auth`

\- `fix typo`

\- `adds utility functions`

\- `add temp file for debug`



Trong đó commit `add temp file for debug` tạo file `temp.txt` dùng để kiểm tra việc xóa commit.



\## 3. Thực hiện Interactive Rebase



Sử dụng lệnh:



```bash

git rebase -i HEAD\~4

```



Trong giao diện Interactive Rebase, cấu hình:



```text

pick \[commit 1] feat: khoi tao module auth

squash \[commit 2] fix typo

squash \[commit 3] adds utility functions

drop \[commit 4] add temp file for debug

```



Ý nghĩa:



\- `pick`: giữ lại commit.

\- `squash`: gộp commit vào commit ngay phía trên.

\- `drop`: xóa hoàn toàn commit.



\## 4. Thay đổi commit message



Sau khi thực hiện `squash`, Git yêu cầu chỉnh sửa commit message.



Commit message cuối cùng được đặt thành:



```text

feat: hoan thien module authentication

```



\## 5. Kết quả sau khi Rebase



Kiểm tra lịch sử bằng:



```bash

git log --oneline

```



Kết quả:



```text

0fa4103 feat: hoan thien module authentication

1c567af Add files via upload

ef35791 ss3

49450be first commit

```



Ba commit liên quan đến module authentication đã được gộp thành một commit duy nhất.



Commit `add temp file for debug` đã bị loại bỏ.



\## 6. Kiểm tra file



Sau khi hoàn thành, file `auth.js` vẫn được giữ lại.



File `temp.txt` đã được loại bỏ.



\## 7. Kết luận



Đã hoàn thành yêu cầu tái cấu trúc lịch sử commit bằng Interactive Rebase:



1\. Gộp các commit nhỏ bằng `squash`.

2\. Đổi commit message thành `feat: hoan thien module authentication`.

3\. Xóa commit chứa file rác `temp.txt` bằng `drop`.

4\. Tạo lịch sử commit sạch và có ý nghĩa hơn.





```

