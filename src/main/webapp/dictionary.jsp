<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.HashMap,java.util.Map,java.util.Locale" %>
<%-- Scriptlet: nhận tham số search, khởi tạo Map và thực hiện tra cứu. --%>
<%
    request.setCharacterEncoding("UTF-8");
    String searchWord = request.getParameter("search");

    Map<String, String> dic = new HashMap<>();
    dic.put("hello", "Xin chào");
    dic.put("how", "Thế nào");
    dic.put("book", "Quyển sách");
    dic.put("computer", "Máy tính");
    dic.put("student", "Sinh viên");

    String result = null;
    boolean hasSearch = searchWord != null && !searchWord.trim().isEmpty();
    if (hasSearch) {
        result = dic.get(searchWord.trim().toLowerCase(Locale.ROOT));
    }

    // Mã hóa từ khóa để hiển thị như văn bản, kể cả khi có ký tự HTML.
    String safeSearchWord = searchWord == null ? "" : searchWord
            .replace("&", "&amp;")
            .replace("<", "&lt;")
            .replace(">", "&gt;")
            .replace("\"", "&quot;")
            .replace("'", "&#39;");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Kết quả tra cứu</title>
    <link rel="stylesheet" href="assets/styles.css">
</head>
<body>
    <main class="card">
        <p class="tag">CODEGYM · JAVA SERVER PAGES</p>
        <h1>Kết quả tra cứu</h1>
        <% if (result != null) { %>
            <p class="word">Từ cần tra: <strong id="search-word"><%= safeSearchWord %></strong></p>
            <div class="result">
                <p>Nghĩa là:</p>
                <%-- Expression: xuất nghĩa tiếng Việt từ biến Java result. --%>
                <strong class="meaning" id="meaning"><%= result %></strong>
            </div>
        <% } else if (hasSearch) { %>
            <div class="notice" id="not-found">
                <h2>Không tìm thấy!</h2>
                <p>Từ khóa <strong id="search-word"><%= safeSearchWord %></strong> không có trong từ điển.</p>
            </div>
        <% } else { %>
            <div class="notice" id="validation-message">
                <h2>Vui lòng nhập từ khóa hợp lệ!</h2>
                <p>Nhập một từ tiếng Anh từ trang chủ để bắt đầu tra cứu.</p>
            </div>
        <% } %>
        <a class="button" href="index.jsp">Quay lại trang chủ</a>
    </main>
</body>
</html>
