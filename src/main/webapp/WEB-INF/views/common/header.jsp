<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags" %>
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
<link
	href="${pageContext.request.contextPath }/resources/css/header.css"
	rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/body.css"
	rel="stylesheet" type="text/css">
</head>
<body>
	<!-- header 시작 -->
	<div class="header">
		<div class="top">
			<div class="logoContainer">
				<div class="logo">
					<a href="${pageContext.request.contextPath}/"> <img
						src="${pageContext.request.contextPath}/resources/img/logo.svg"
						alt="user.." />
					</a>
				</div>
			</div>
			<div class="userContainer">
			<se:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_USER')">
				<div class="userImage">
					<a href="${pageContext.request.contextPath}/member/mypage"> <img
						src="${pageContext.request.contextPath }/resources/img/person-circle.svg"
						alt="user.." />
					</a>
				</div>
				
				
				<se:authentication property="name" var="LoginUser" />
				<div class="userMessage">[${LoginUser}]</div>
				<div class="myPage">
					<a href="${pageContext.request.contextPath}/member/mypage">
						<button type="button" class="btn btn-secondary">마이페이지</button>
					</a>
				</div>
			</se:authorize>
				<div class="join">
					<a href="${pageContext.request.contextPath}/member/join">
						<button type="button" class="btn btn-secondary">회원가입</button>
					</a>
				</div>
				<se:authorize access="!hasRole('ROLE_USER')">
					<div class="login">
						<a href="${pageContext.request.contextPath}/member/login">
							<button type="button" class="btn btn-secondary">로그인</button>
						</a>
					</div>
				</se:authorize>
				<se:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_USER')">
					<div class="logout">
						
							<a href="${pageContext.request.contextPath}/member/logout">
								<button type="button" class="btn btn-secondary">로그아웃</button>
							</a> 
					</div>
				</se:authorize>
			</div>
		</div>
		<hr />
	
		<div class="nav">
			<div class="navContainer">
				<div class="home">
					<a href="${pageContext.request.contextPath}/">
						<button type="button" class="btn btn-secondary">홈</button>
					</a>
				</div>
				<div class="community">
					<a href="${pageContext.request.contextPath}/community/list.do">
						<button type="button" class="btn btn-secondary">커뮤니티</button>
					</a>
				</div>
				<div class="qna">
					<a href="${pageContext.request.contextPath}/qna/qnaList.do">
						<button type="button" class="btn btn-secondary">문의</button>
					</a>
				</div>
				<div class="interest">
				<a href="${pageContext.request.contextPath}/kanban/kanban_board.do">
					<button type="button" class="btn btn-secondary">관심종목</button>
					</a>
				</div>
			</div>
		</div>
	</div>
	<!-- header 끝 -->
</body>
</html>
