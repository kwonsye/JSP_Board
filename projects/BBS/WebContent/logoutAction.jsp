<!-- 로그아웃을 처리하는 jsp파일 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%> <!-- java Resource에 작성한 파일을 임포트 -->
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트를 작성하기 위해 임포트 -->

<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 데이터 형식을 UTF로 바꿈 -->

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title></title>
</head>
<body>
	<%
		//로그아웃을 하면 그 회원의 세션을 뺴앗는다.
		session.invalidate();
	%>
	<!-- 다시 메인페이지로 이동시킨다. -->
	<script>
		location.href = 'main.jsp';
	</script>
</body>
</html>