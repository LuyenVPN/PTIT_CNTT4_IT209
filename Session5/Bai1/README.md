\# Bài 1: Khôi phục commit đã mất bằng Git Reflog



\## 1. Mục tiêu



Thực hành sử dụng Git Reflog để truy vết và khôi phục một commit đã bị mất khỏi lịch sử nhánh sau khi thực hiện `git reset --hard`.



\## 2. Tạo commit quan trọng



Tạo file `feature.txt` với nội dung:



```text

Day la tinh nang quan trong

```



Sau đó thêm file và commit:



```bash

git add .

git commit -m "Them tinh nang quan trong"

```



Kiểm tra lịch sử:



```bash

git log --oneline

```



Kết quả xuất hiện commit:



```text

\[HASH] Them tinh nang quan trong

```



\## 3. Giả lập việc mất commit



Thực hiện:



```bash

git reset --hard HEAD\~1

```



Lệnh trên đưa nhánh hiện tại về commit trước đó và đồng thời xóa các thay đổi trong working directory.



Kiểm tra lại:



```bash

git log --oneline

```



Commit `Them tinh nang quan trong` không còn xuất hiện trong lịch sử thông thường.



File `feature.txt` cũng không còn trong working directory.



\## 4. Tra cứu Reflog



Sử dụng:



```bash

git reflog

```



Kết quả tìm thấy commit đã bị mất:



```text

\[HASH] HEAD@{1}: commit: Them tinh nang quan trong

```



Reflog vẫn lưu lại tham chiếu đến commit cũ mặc dù commit đó không còn được trỏ tới bởi nhánh hiện tại.



\## 5. Khôi phục commit



Sử dụng mã hash tìm được từ Reflog:



```bash

git reset --hard \[HASH]

```



Ví dụ:



```bash

git reset --hard e3a5b2c

```



Sau khi thực hiện, nhánh hiện tại được đưa trở lại commit `Them tinh nang quan trong`.



\## 6. Kiểm tra kết quả



Kiểm tra lịch sử:



```bash

git log --oneline

```



Kết quả:



```text

\[HASH] Them tinh nang quan trong

```



Kiểm tra nội dung file:



```bash

cat feature.txt

```



Kết quả:



```text

Day la tinh nang quan trong

```



\## 7. Kết luận



Đã khôi phục thành công commit bị mất bằng Git Reflog.



Quy trình thực hiện:



```text

Commit

&#x20; ↓

git reset --hard HEAD\~1

&#x20; ↓

Commit biến mất khỏi git log

&#x20; ↓

git reflog

&#x20; ↓

Tìm lại mã hash của commit

&#x20; ↓

git reset --hard \[HASH]

&#x20; ↓

Commit và file được khôi phục

```

