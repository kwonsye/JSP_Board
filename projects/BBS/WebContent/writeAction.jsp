<!-- 게시글 저장을 처리하는 jsp파일 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%> <!-- java Resource에 작성한 파일을 임포트 -->
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트를 작성하기 위해 임포트 -->

<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 데이터 형식을 UTF로 바꿈 -->

<!-- 자바빈즈로서 Bbs를 사용-->
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<!-- write.jsp에서 넘어온 bbsTitle,bbsContent 객체 bbs로서 담긴다. -->
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />

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
		}else{ //로그인이 되어 있는 경우
			if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null){
				PrintWriter printWriter = response.getWriter();
				printWriter.println("<script>");
				printWriter.println("alert('입력이 안 된 사항이 있습니다.')");
				printWriter.println("history.back()");
				printWriter.println("</script>");
			} else {
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
				//db오류
				if(result == -1){
					PrintWriter printWriter = response.getWriter();
					printWriter.println("<script>");
					printWriter.println("alert('글쓰기에 실패했습니다.')");
					printWriter.println("history.back()");
					printWriter.println("</script>");
				} else { //db에 성공적으로 저장된 경우
					PrintWriter printWriter = response.getWriter();
					printWriter.println("<script>");
					printWriter.println("location.href = 'bbs.jsp'");
					printWriter.println("</script>");
				}
			}
		}

		
	%>
</body>
</html>