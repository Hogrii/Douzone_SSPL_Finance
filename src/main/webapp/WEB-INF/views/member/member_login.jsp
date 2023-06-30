<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
	integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l"
	crossorigin="anonymous" />
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
	integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
	integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
	crossorigin="anonymous"></script>
<style>
* {
	box-sizing: border-box;
	padding: 0px;
	margin: 0px;
}

#main {
	width: 690px;
}
</style>
</head>

<body>
	<header>
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	</header>
	<main id="main" class="container pt-4 mt-1">
		<div class="row justify-content-center">
			<div class="col-md-6">
				<div class="card-body">
					<h3 class="text-center mb-4">SSPL Finance</h3>
					<form action="${pageContext.request.contextPath}/" method="get"
						class="pt-5">
						<div class="form-group pt-3">
							<label for="user_id">아이디</label> <input type="text"
								class="form-control form-control" name="user_id" id="user_id"
								placeholder="아이디를 입력하세요" />
						</div>
						<div class="form-group pt-3">
							<label for="password">비밀번호</label> <input type="password"
								class="form-control form-control" name="password" id="password"
								placeholder="비밀번호를 입력하세요" />
						</div>
						<div class="form-group form-check pt-3">
							<input type="checkbox" class="form-check-input"
								id="remember_password" value="비밀번호 기억하기" />
							<label class="form-check-label" for="remember_password">비밀번호
								기억하기</label>
						</div>
						<div class="text-center">
							<input type="submit" class="btn btn-secondary btn-block"
								value="로그인" /> <input
								type="button" class="btn btn-secondary mt-3 btn-block"
								value="회원가입"
								onClick="location.href='${pageContext.request.contextPath}/member/join'" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</main>
</body>
</html>