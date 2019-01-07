<!-- 로그인 처리하는 jsp파일 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%> <!-- java Resource에 작성한 파일을 임포트 -->
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트를 작성하기 위해 임포트 -->

<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 데이터 형식을 UTF로 바꿈 -->

<!-- 자바빈즈로서 User를 사용-->
<jsp:useBean id="user" class="user.User" scope="page" />
<!-- login.jsp에서 넘어온 userID,userPassword가 user로서 담긴다. -->
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />

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
		if (session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		if (userID != null){
			PrintWriter printWriter = response.getWriter();
			printWriter.println("<script>");
			printWriter.println("alert('이미 로그인이 되어있습니다.')");
			printWriter.println("location.href = 'main.jsp'");
			printWriter.println("</script>");
		}
		
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		if(result == 1){//로그인 성공하면
			//로그인한 회원에게 세션을 부여해준다.
			session.setAttribute("userID",user.getUserID());
			
			PrintWriter printWriter = response.getWriter();
			printWriter.println("<script>");
			printWriter.println("location.href = 'main.jsp'");
			printWriter.println("</script>");
		}
		if(result == 0){//로그인 실패하면
			PrintWriter printWriter = response.getWriter();
			printWriter.println("<script>");
			printWriter.println("alert('비밀번호가 틀립니다.')");
			printWriter.println("history.back()"); //이전 페이지(login.jsp)로 사용자를 돌려보낸다.
			printWriter.println("</script>");
		}
		if(result == -2){//DB접속 오류면
			PrintWriter printWriter = response.getWriter();
			printWriter.println("<script>");
			printWriter.println("alert('데이터베이스 오류가 발생했습니다.')");
			printWriter.println("history.back()"); //이전 페이지(login.jsp)로 사용자를 돌려보낸다.
			printWriter.println("</script>");
		}
		if(result == -1){//해당 아이디가 없으면
			PrintWriter printWriter = response.getWriter();
			printWriter.println("<script>");
			printWriter.println("alert('입력하신 아이디가 존재하지 않습니다.')");
			printWriter.println("history.back()"); //이전 페이지(login.jsp)로 사용자를 돌려보낸다.
			printWriter.println("</script>");
		}
	
	%>
</body>
</html>