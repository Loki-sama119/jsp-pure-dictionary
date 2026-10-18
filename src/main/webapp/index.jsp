<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Từ điển Anh - Việt</title>
    <link rel="stylesheet" href="assets/styles.css">
</head>
<body>
    <main class="card">
        <p class="tag">CODEGYM · JAVA SERVER PAGES</p>
        <div class="languages" aria-label="Tra cứu tiếng Anh sang tiếng Việt">
            <span>EN</span><span class="arrow" aria-hidden="true">→</span><span>VI</span>
        </div>
        <h1>Từ điển Anh – Việt</h1>
        <p class="intro">Nhập từ tiếng Anh để tìm nghĩa tiếng Việt.</p>
        <form action="dictionary.jsp" method="POST" accept-charset="UTF-8">
            <label for="search">Từ tiếng Anh</label>
            <input id="search" type="text" name="search" placeholder="Nhập từ tiếng Anh..."
                   required autofocus spellcheck="false" aria-describedby="search-hint">
            <button type="submit">Tìm kiếm</button>
        </form>
        <p id="search-hint" class="hint">Từ có sẵn: hello, how, book, computer, student.</p>
        <p class="note">Tra cứu hỗ trợ chữ hoa, chữ thường và khoảng trắng đầu/cuối.</p>
    </main>
</body>
</html>
