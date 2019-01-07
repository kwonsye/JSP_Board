<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Bootstrap참조하는 부분 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<!-- 커스텀 css파일 추가 -->
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="css/bootstrap.css">
<title>로그인 페이지 테스트</title>
</head>
<body>
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
				<li><a href="bbs.jsp">Board</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
		<!-- 로그인 박스 -->
			<div class="jumbotron" style="padding-top:20px;">
				<form method="post" action="loginAction.jsp"><!--submit을 누르면 loginAction.jsp로 입력한 내용을 보낸다 -->
					<h3 style="text-align:center;">로그인 화면</h3>
					<!-- 입력받는 폼-->
					<div class="form-group">
						<input type="text" class="form-control" placeholder="ID" name="userID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="Password" name="userPassword" maxlength="20">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="Login">
				</form>
			</div>
		</div>
		<div class="col-lg-4"></div>
	</div>
</body>
</html>