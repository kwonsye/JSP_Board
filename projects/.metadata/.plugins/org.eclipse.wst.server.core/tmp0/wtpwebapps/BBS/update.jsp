<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Bootstrap참조하는 부분 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<!-- 커스텀 css파일 추가 -->
<link rel="stylesheet" href="css/custom.css">
<title>글 수정 페이지 테스트</title>
</head>
<body>

	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		//로그인을 안 한 상태라면
		if(userID == null){
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
		if(!bbs.getUserID().equals(userID)){
			PrintWriter printWriter = response.getWriter();
			printWriter.println("<script>");
			printWriter.println("alert('권한이 없습니다.')");
			printWriter.println("location.href = 'bbs.jsp'");
			printWriter.println("</script>");
		}
	%>
	<!-- 자바스크립트 파일 추가 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<!-- 네비게이션 메뉴바 달기 -->
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">JSP게시판 웹 사이트</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">Main</a></li>
				<li class="active"><a href="bbs.jsp">Board</a></li>
			</ul>
			
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>

			
		</div>
	</nav>
	
	<!-- 게시글을 볼 수 있는 곳 -->
	<div class="container">
		<div class="row">
			<form method="post" action="updateAction.jsp?bbsID=<%= bbsID %>"><!-- submit누르면 writeAction.jsp파일로 데이터 넘어감 -->
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2"
								style="background-color: #eeeeee; text-align: center;">게시판
								글 수정 양식</th>
						</tr>
					</thead>

					<tbody>
						<!-- 글 제목 작성 부분 -->
						<tr>
							<td><input type="text" class="form-control"
								placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%=bbs.getBbsTitle() %>"></td>
						</tr>
						<!-- 글 내용 작성 부분 -->
						<tr>
							<td><textarea class="form-control" placeholder="글 내용"
									name="bbsContent" maxlength="2048" style="height: 350px; "> <%= bbs.getBbsContent()%></textarea></td>
						</tr>
					</tbody>
				</table>
				<!-- 글 수정 버튼 -->
				<input type="submit" class="btn btn-primary pull-right" value="글 수정">
				
			</form>
		</div>
		
	</div>
</body>
</html>