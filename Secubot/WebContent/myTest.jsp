<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<a href="${pageContext.request.contextPath}/index.jsp" target="_blank">link</a>
	<button onclick="window.open('${pageContext.request.contextPath}/index.jsp',
	'window_name', 'width=430, height=500, location=no, status=no, scrollbars=yes');">popup</button>

</body>
</html>