<!-- 게시글 삭제를 처리하는 jsp파일 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%> <!-- java Resource에 작성한 파일을 임포트 -->
<%@ page import="bbs.Bbs"%>
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
		//세션을 부여받은 회원만 글을 작성할 수 있다.
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		//로그인하지 않은 회원은 글을 작성할 수 없다.
		if (userID == null) {
			PrintWriter printWriter = response.getWriter();
			printWriter.println("<script>");
			printWriter.println("alert('로그인을 하세요.')");
			printWriter.println("location.href = 'login.jsp'");
			printWriter.println("</script>");
		}
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID == 0){ //request로 bbsID 넘어온게 없으면
			PrintWriter printWriter = response.getWriter();
			printWriter.println("<script>");
			printWriter.println("alert('유효하지 않은 글입니다.')");
			printWriter.println("location.href = 'bbs.jsp'");
			printWriter.println("</script>");
		}
		
		//글작성자와 세션회원이 동일한지 확인
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		//글 삭제 권한이 없다면
		if(!bbs.getUserID().equals(userID)){
			PrintWriter printWriter = response.getWriter();
			printWriter.println("<script>");
			printWriter.println("alert('권한이 없습니다.')");
			printWriter.println("location.href = 'bbs.jsp'");
			printWriter.println("</script>");
		}
		
		//글 삭제 권한이 있다면
		else{
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.delete(bbsID);
			//db오류
			if(result == -1){
				PrintWriter printWriter = response.getWriter();
				printWriter.println("<script>");
				printWriter.println("alert('글 삭제에 실패했습니다.')");
				printWriter.println("history.back()");
				printWriter.println("</script>");
			} else { //db에 성공적으로 삭제된 경우
				PrintWriter printWriter = response.getWriter();
				printWriter.println("<script>");
				printWriter.println("location.href = 'bbs.jsp'");
				printWriter.println("</script>");
			}
		}

		
	%>
</body>
</html>