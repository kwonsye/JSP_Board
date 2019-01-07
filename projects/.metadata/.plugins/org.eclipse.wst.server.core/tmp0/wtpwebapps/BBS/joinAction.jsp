<!-- 회원가입 처리하는 jsp파일 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%> <!-- java Resource에 작성한 파일을 임포트 -->
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트를 작성하기 위해 임포트 -->

<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 데이터 형식을 UTF로 바꿈 -->

<!-- 자바빈즈로서 User를 사용-->
<jsp:useBean id="user" class="user.User" scope="page" />
<!-- login.jsp에서 넘어온 userID,userPassword,userName,userGender,userEmail가 user로서 담긴다. -->
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title></title>
</head>
<body>
	<%
		//세션을 부여받은 회원은 로그인,회원가입페이지에 접근하지 못하도록 한다.
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID != null) {
			PrintWriter printWriter = response.getWriter();
			printWriter.println("<script>");
			printWriter.println("alert('이미 회원가입이 되어있습니다.')");
			printWriter.println("location.href = 'main.jsp'");
			printWriter.println("</script>");
		}

		//공백으로 입력한게 한 개라도 있으면
		if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
				|| user.getUserGender() == null || user.getUserEmail() == null) {

			PrintWriter printWriter = response.getWriter();
			printWriter.println("<script>");
			printWriter.println("alert('공백 없이 채워주세요.')");
			printWriter.println("history.back()");
			printWriter.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);

			if (result == -1) { //데이터베이스 오류 발생한 경우 
				PrintWriter printWriter = response.getWriter();
				printWriter.println("<script>");
				printWriter.println("alert('이미 존재하는 ID입니다.')");
				printWriter.println("history.back()");
				printWriter.println("</script>");
			} else { //회원가입이 정상적으로 된 경우
						//회원에게 세션을 부여해준 후 메인으로 넘겨준다.
				session.setAttribute("userID", user.getUserID());

				PrintWriter printWriter = response.getWriter();
				printWriter.println("<script>");
				printWriter.println("location.href = 'main.jsp'"); //main.jsp파일로 이동
				printWriter.println("</script>");

			}
		}
	%>
</body>
</html>