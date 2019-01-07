<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Bootstrap참조하는 부분 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<!-- 커스텀 css파일 추가 -->
<link rel="stylesheet" href="css/custom.css">
<title>메인 페이지 테스트</title>
</head>
<body>

	<%
		//로그인이 된 사람이라면
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
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
				<li class="active"><a href="main.jsp">Main</a></li>
				<li><a href="bbs.jsp">Board</a></li>
			</ul>
			<%
				//로그인이 된 상태가 아닐 떄만 접속하기가 보이게 한다.
				if(userID == null){
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
			//로그인이 된 사람만 볼 수 있는 화면
				}else{
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
			
		</div>
	</nav>
	
	<!-- 웹사이트를 소개하는 부분 -->
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1>웹 사이트 소개</h1><br>			
				<p>JSP 웹 사이트</p>
				<p>Bootstrap 3.3.7 사용</p>
				<p>웹서버 : Apache</p>
				<p>WAS : tomcat 8.5.37</p>
				<p>DB : mySQL / mysql-connector-java-8.0.13</p>
				<p>인프런_안경잡이개발자 강의 클론 코딩</p>
				<p><a class="btn btn-primary btn-pull" href="https://www.inflearn.com/course/jsp-게시판" role="button">인프런 JSP강의 바로가기</a></p>
			
			</div>
		</div>
	</div>
	<!-- 사진첩 -->
	<div class="container">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>
			<!-- 사진을 보여주는 부분 -->
			<div class="carousel-inner">
				<div class="item active">
					<img src="images/pietro-de-grandi-329892-unsplash.jpg">
				</div>
				<div class="item">
					<img src="images/ales-krivec-26310-unsplash.jpg">
				</div>
				<div class="item">
					<img src="images/jeff-king-115540-unsplash.jpg">
				</div>
			</div>
			<!-- 사진을 넘기는 버튼 -->
			<!-- 이전으로 가기 버튼 -->
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<!-- 아이콘 넣기--> 
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a>

			<!-- 다음으로 가기 버튼 -->
			<a class="right carousel-control" href="#myCarousel"
				data-slide="next"> 
				<!-- 아이콘 넣기--> 
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>

	</div>
	
</body>
</html>