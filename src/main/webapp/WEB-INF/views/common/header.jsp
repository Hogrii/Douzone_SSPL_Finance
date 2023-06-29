<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Document</title>
<!-- CSS only -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous" />
<!-- JavaScript Bundle with Popper -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath }/resources/css/header.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/body.css" rel="stylesheet" type="text/css">
</head>
<body>
	<!-- header 시작 -->
	<div class="header">
		<div class="top">
			<div class="logoContainer">
				<div class="logo">
					<img src="${pageContext.request.contextPath}/resources/img/logo.svg" alt="user.." />
				</div>
			</div>
			<div class="userContainer">
				<div class="userImage">
					<img
						src="${pageContext.request.contextPath }/resources/img/person-circle.svg"
						alt="user.." />
				</div>
				<div class="userMessage">유저님 반갑습니다!</div>
				<div class="myPage">
					<button type="button" class="btn btn-secondary">마이페이지</button>
				</div>
				<div class="logout">
					<button type="button" class="btn btn-secondary">로그아웃</button>
				</div>
			</div>
		</div>
		<hr />
		<div class="nav">
			<div class="navContainer">
				<div class="home">
					<button type="button" class="btn btn-secondary">홈</button>
				</div>
				<div class="community">
					<button type="button" class="btn btn-secondary">커뮤니티</button>
				</div>
				<div class="qna">
					<button type="button" class="btn btn-secondary">문의</button>
				</div>
				<div class="interest">
					<button type="button" class="btn btn-secondary">관심종목</button>
				</div>
			</div>
		</div>
	</div>
	<!-- header 끝 -->
</body>
</html>
