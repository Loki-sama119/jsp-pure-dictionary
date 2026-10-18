# [Thực hành] Ứng dụng từ điển Anh – Việt bằng JSP

**Mã bài: `jsp-pure-dictionary` — groupId: `com.codegym`.**

Ứng dụng tạo form tra cứu từ tiếng Anh, gửi dữ liệu bằng POST tới `dictionary.jsp`, tra cứu trong `Map` và hiển thị nghĩa tiếng Việt trực tiếp bằng JSP Scriptlet và Expression.

## Các file mã nguồn để đối chiếu yêu cầu

- [pom.xml](pom.xml): Maven Webapp, `packaging=war`, artifactId `jsp-pure-dictionary`.
- [index.jsp](src/main/webapp/index.jsp): form `action="dictionary.jsp"`, `method="POST"`, ô nhập `name="search"`, nút `Tìm kiếm`.
- [dictionary.jsp](src/main/webapp/dictionary.jsp): nhận `request.getParameter("search")`, khởi tạo `HashMap`, tra cứu bằng Scriptlet `<% %>` và hiển thị bằng Expression `<%= %>`.
- [WEB-INF/web.xml](src/main/webapp/WEB-INF/web.xml): namespace Jakarta, phiên bản 6.0, trang mặc định `index.jsp`.
- [styles.css](src/main/webapp/assets/styles.css): định dạng giao diện.

Hai file `index.jsp` và `dictionary.jsp` nằm cùng cấp tại `src/main/webapp/`.

## Chức năng

1. Nhập từ tiếng Anh ở trang chủ, bấm **Tìm kiếm**.
2. Form POST tham số **`search`** tới **`dictionary.jsp`**.
3. Scriptlet trong JSP khởi tạo từ điển và tra cứu từ đã bỏ khoảng trắng đầu/cuối, chuyển về chữ thường.
4. Tìm thấy: Expression `<%= result %>` hiển thị nghĩa tiếng Việt.
5. Không tìm thấy: hiển thị **`Không tìm thấy!`** và **`Từ khóa [từ đã nhập] không có trong từ điển.`**
6. Thiếu hoặc rỗng từ khóa: hướng dẫn nhập từ hợp lệ và cung cấp liên kết quay lại trang chủ.
7. Từ khóa chứa ký tự HTML được mã hóa trước khi đưa vào Expression hiển thị.

## Từ điển có sẵn trong dictionary.jsp

- `hello` → `Xin chào`
- `how` → `Thế nào`
- `book` → `Quyển sách`
- `computer` → `Máy tính`
- `student` → `Sinh viên`

## Cấu trúc Maven

```text
jsp-pure-dictionary/
├── pom.xml
├── README.md
├── .gitignore
└── src/main/webapp/
    ├── index.jsp
    ├── dictionary.jsp
    ├── assets/styles.css
    └── WEB-INF/web.xml
```

## Môi trường

- JDK 17 trở lên; môi trường triển khai dùng JDK 21.
- Maven.
- Apache Tomcat 10.1, Jakarta Servlet 6.0 và Jakarta Server Pages 3.1.

## Build và triển khai

Mở PowerShell tại thư mục chứa `pom.xml`:

```powershell
mvn clean package
Copy-Item -LiteralPath '.\target\jsp-pure-dictionary.war' -Destination 'C:\Tools\apache-tomcat-10.1.60\webapps\jsp-pure-dictionary.war'
# Chỉ khởi động nếu Tomcat chưa chạy:
& 'C:\Tools\apache-tomcat-10.1.60\bin\startup.bat'
```

Mở <http://localhost:8080/jsp-pure-dictionary/>. Nếu Tomcat dùng cổng khác, thay cổng theo connector HTTP trong `conf/server.xml`.

Maven đóng gói JSP vào WAR. Tomcat biên dịch và thực thi các JSP khi nhận request.

## Tự kiểm tra

- `hello` → `Xin chào`.
- `book` hoặc `  BOOK  ` → `Quyển sách`.
- `computer` → `Máy tính`.
- `unknownword` → thông báo không tìm thấy và hiển thị lại từ đã nhập.
- POST thiếu hoặc rỗng `search` → hướng dẫn nhập từ khóa.

```powershell
Invoke-WebRequest -Uri 'http://localhost:8080/jsp-pure-dictionary/dictionary.jsp' -Method POST -Body @{search='book'} -UseBasicParsing
Invoke-WebRequest -Uri 'http://localhost:8080/jsp-pure-dictionary/dictionary.jsp' -Method POST -Body @{search='unknownword'} -UseBasicParsing
```

## Nộp bài

Nộp URL repository GitHub công khai, nhánh `main`. File `pom.xml` và cây `src/` nằm ngay tại gốc repository. Thư mục build `target/` được loại khỏi Git bằng `.gitignore`.

## Kết quả kiểm thử thực tế

Đã kiểm tra ngày 18/10/2026 trên JDK 21, Apache Tomcat 10.1.60, cổng HTTP 8080:

- Cấu hình Maven: đúng `com.codegym:jsp-pure-dictionary`, đóng gói WAR; descriptor Jakarta 6.0 hợp lệ.
- Đã kiểm tra trực tiếp mã form dùng `search`, POST tới `dictionary.jsp`, Scriptlet khởi tạo `HashMap` và Expression `<%= result %>`.
- `mvn clean package`: `BUILD SUCCESS`.
- Hai JSP được Tomcat biên dịch và thực thi qua HTTP thực tế.
- `hello`, `how`, `book`, `computer`, `student`: HTTP 200, nghĩa tiếng Việt đúng.
- `  BOOK  ` và `HeLLo`: HTTP 200, tra được đúng nghĩa.
- `unknownword`: HTTP 200, hiện `Không tìm thấy!` và từ đã nhập.
- Rỗng, chỉ có khoảng trắng, thiếu tham số `search` và truy cập trực tiếp `dictionary.jsp`: HTTP 200, hiện hướng dẫn nhập từ khóa.
- Từ khóa chứa HTML và tiếng Việt được hiển thị đúng dưới dạng văn bản.
- CSS và liên kết quay về `index.jsp`: HTTP 200.
