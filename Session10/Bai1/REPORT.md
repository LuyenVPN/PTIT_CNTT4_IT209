# BÁO CÁO KỸ THUẬT: PHÂN TÍCH KIẾN TRÚC CONTAINER VS VIRTUAL MACHINE

## 1. Mục tiêu

Phân tích sự khác biệt giữa ảo hóa phần cứng bằng Virtual Machine (VM) và ảo hóa hệ điều hành bằng Container. Đồng thời, tìm hiểu cơ chế Namespaces, Control Groups (cgroups) của Linux và kiểm tra thông tin Docker Engine trên hệ thống thực tế.

## 2. So sánh VM và Container

| Tiêu chí | Virtual Machine (VM) | Container |
|---|---|---|
| Dung lượng Image | Thường lớn vì cần hệ điều hành khách và các thành phần liên quan. | Thường nhỏ hơn, chỉ chứa ứng dụng, thư viện và dependency cần thiết. |
| Thời gian khởi động | Thường từ vài giây đến vài phút tùy hệ điều hành và cấu hình. | Thường từ dưới một giây đến vài giây, tùy ứng dụng. |
| Hao phí OS | Mỗi VM cần hệ điều hành khách riêng, tiêu thụ thêm CPU, RAM và dung lượng lưu trữ. | Nhiều container chia sẻ kernel máy chủ nên giảm chi phí tài nguyên dành cho hệ điều hành. |
| Mức độ cô lập | Có ranh giới ảo hóa phần cứng và kernel riêng cho từng VM. | Cô lập tiến trình ở cấp hệ điều hành; mức độ bảo mật phụ thuộc kernel và cấu hình. |
| Khả năng mở rộng | Có thể mở rộng nhưng thường cần nhiều tài nguyên và thời gian khởi tạo hơn. | Có thể tạo, thay thế và nhân bản nhanh, phù hợp với microservices. |

Các đặc điểm trên mang tính khái quát. Hiệu năng thực tế phụ thuộc cấu hình máy chủ, hệ điều hành, ứng dụng và cách triển khai.

## 3. Cơ chế Namespaces của Linux

Namespaces là cơ chế của Linux cho phép cô lập góc nhìn của các nhóm tiến trình đối với những tài nguyên hệ thống.

- **PID Namespace:** Cô lập không gian định danh tiến trình. Tiến trình trong container có thể nhìn thấy cây tiến trình riêng thay vì toàn bộ tiến trình trên máy chủ.
- **Network Namespace:** Cô lập giao diện mạng, địa chỉ IP, bảng định tuyến và các thành phần mạng liên quan. Docker sử dụng cơ chế này để cung cấp môi trường mạng cho container.
- **Mount Namespace:** Cô lập các điểm gắn kết hệ thống tệp, cho phép container có góc nhìn filesystem riêng.

Namespaces giúp container hoạt động như một môi trường độc lập, nhưng container không có kernel riêng như VM.

## 4. Cơ chế quản lý tài nguyên bằng cgroups

Control Groups (cgroups) là cơ chế của Linux để theo dõi và giới hạn tài nguyên được sử dụng bởi các nhóm tiến trình.

- **CPU:** Có thể giới hạn lượng CPU container được sử dụng và phân bổ mức ưu tiên tương đối.
- **RAM:** Có thể đặt giới hạn bộ nhớ cho container. Khi vượt giới hạn, hệ thống có thể từ chối cấp phát hoặc kích hoạt cơ chế OOM tùy tình huống.
- **Giám sát:** Cung cấp thông tin sử dụng tài nguyên, hỗ trợ quản trị viên kiểm soát hiệu năng.

Namespaces tập trung vào cô lập góc nhìn tài nguyên, trong khi cgroups tập trung vào quản lý và kiểm soát mức tiêu thụ tài nguyên.

## 5. Thông số Docker thực tế

Các lệnh `docker version` và `docker info` đã thực thi thành công bằng user thường `ec2-user`, không cần sử dụng `sudo`.

Thông số thu thập từ hệ thống Amazon Linux 2023:

| Thông số | Giá trị thực tế |
|---|---|
| Client Version | 25.0.14 |
| Server Version | 25.0.16 |
| Cgroup Driver | systemd |
| Cgroup Version | 2 |
| Tổng số Containers | 2 |
| Containers đang chạy | 1 |
| Containers đang tạm dừng | 0 |
| Containers đã dừng | 1 |
| Tổng số Images | 2 |
| Storage Driver | overlay2 |
| Hệ điều hành | Amazon Linux 2023 |
| Số CPU | 2 |
| Tổng RAM | 913.2 MiB |

Cgroup Driver `systemd` cho biết Docker sử dụng systemd để quản lý các nhóm cgroups. Cgroup Version `2` cho biết hệ thống đang sử dụng kiến trúc cgroups phiên bản 2.

Storage Driver `overlay2` hỗ trợ xây dựng các lớp filesystem của image và container. Docker sử dụng cơ chế lớp để tái sử dụng dữ liệu, giảm trùng lặp và hỗ trợ triển khai ứng dụng.

## 6. Lý do doanh nghiệp chuyển từ VPS sang Docker

Docker giúp đóng gói ứng dụng cùng các thư viện và dependency cần thiết thành image có thể tái sử dụng. Nhờ đó, môi trường triển khai giữa máy phát triển, kiểm thử và sản xuất nhất quán hơn.

Container thường khởi động nhanh, sử dụng tài nguyên hiệu quả và dễ tích hợp với CI/CD. Doanh nghiệp có thể triển khai, thay thế hoặc mở rộng từng dịch vụ độc lập, phù hợp với kiến trúc microservices.

Tuy nhiên, Docker không hoàn toàn thay thế VPS. VPS cung cấp môi trường máy chủ ảo, còn Docker quản lý ứng dụng trong container. Doanh nghiệp có thể cài Docker trên VPS để kết hợp hai công nghệ. VM vẫn có lợi thế khi cần hệ điều hành riêng hoặc ranh giới cô lập mạnh hơn.

## 7. Kết luận

VM ảo hóa phần cứng và chạy hệ điều hành khách riêng, còn container cô lập ứng dụng ở cấp hệ điều hành và chia sẻ kernel máy chủ. Namespaces hỗ trợ cô lập tài nguyên, trong khi cgroups giúp quản lý CPU và RAM. Docker đem lại lợi ích về tốc độ triển khai, khả năng tái sử dụng image và hiệu quả tài nguyên, nhưng cần cấu hình bảo mật và giới hạn tài nguyên phù hợp.