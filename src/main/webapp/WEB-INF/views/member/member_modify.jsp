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
<style>
* {
	box-sizing: border-box;
	padding: 0px;
	margin: 0px;
}

#main {
	width: 613px;
}
</style>
</head>

<body>
	<header>
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	</header>
	<main id="main" class="container py-5">
		<div class="row justify-content-center">
			<div class="col-md-6">
				<h3 class="text-center mb-3">SSPL Finance</h3>
				<form action="${pageContext.request.contextPath}/" method="get"
					class="pt-5">
					<div class="form-group pt-4">
						<label for="password">비밀번호</label> <input type="password"
							class="form-control" name="password" id="password"
							placeholder="비밀번호를 입력하세요" />
					</div>
					<div class="form-group pt-4">
						<label for="password_ok">비밀번호 확인</label> <input type="password"
							class="form-control" name="password_ok" id="password_ok"
							placeholder="비밀번호를 입력하세요" />
					</div>
					<div class="form-group pt-4">
						<label for="email">이메일</label> <input type="email"
							class="form-control" name="email" id="email"
							placeholder="이메일을 입력하세요" />
					</div>
					<div class="form-group pt-4">
						<label for="phone_number">휴대폰번호</label> <input type="text"
							class="form-control" name="phone_number" id="phone_number"
							placeholder="휴대폰 번호를 입력하세요" />
					</div>
					<div class="text-center pt-2">
						<input type="submit" class="btn btn-secondary mr-4 px-4 btn-sm"
							value="수정하기" /> <input
							type="button" class="btn btn-secondary ml-3 px-4 btn-sm"
							value="취소하기"
							onClick="location.href='${pageContext.request.contextPath}/'" />
					</div>
				</form>
			</div>
		</div>
	</main>
</body>
</html>