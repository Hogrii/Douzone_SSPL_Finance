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
.container {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
}

form {
	width: 275px;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/member/member_join.js"></script>
<link
	href="${pageContext.request.contextPath }/resources/css/global.css"
	rel="stylesheet" type="text/css" />

</head>


<body>
	<header>
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	</header>
	<!-- 여기서부터 메인 -->
	<div class="container my-5 ">
		<h3 class="">SSPL Finance</h3>

		<form class="pt-5 mt-2" id="form">
			<div class="form-group pt-4">
				<label for="name">이름</label> <input type="text" class="form-control"
					id="name" name="name" placeholder="이름을 입력하세요" />
			</div>
			<div class="form-group pt-3 row">
				<label for="user_id" class="col-sm-3 col-form-label">아이디</label>
				<div class="col-sm-9 input-group">
					<input type="text" class="form-control" id="user_id" name="user_id"
						placeholder="아이디를 입력하세요" />
					<div class="input-group-append">
						<button id="id_check" class="btn btn-secondary btn-sm">
							중복확인</button>
					</div>
				</div>
			</div>
			<div class="form-group pt-3">
				<label for="password">비밀번호</label> <input type="password"
					class="form-control" id="password" name="password"
					placeholder="비밀번호를 입력하세요" />
			</div>
			<div class="form-group pt-3">
				<label for="password_ok">비밀번호 확인</label> <input type="password"
					class="form-control" id="password_ok" name="password_ok"
					placeholder="비밀번호를 입력하세요" />
			</div>
			<div class="form-group pt-3">
				<label for="email">이메일</label> <input type="text"
					class="form-control" id="email" name="email"
					placeholder="이메일을 입력하세요" />
			</div>
			<div class="form-group pt-3">
				<label for="phone_number">휴대폰번호</label> <input type="text"
					class="form-control" id="phone_number" name="phone_number"
					placeholder="휴대폰 번호를 입력하세요" />
			</div>
			<div class="text-center pt-2">
				<button type="submit" class="btn btn-secondary mr-4 px-4 btn-sm">
					가입하기</button>
				<button type="button" class="btn btn-secondary ml-3 px-4 btn-sm"
					onClick="location.href='${pageContext.request.contextPath}/'">
					취소하기</button>	
			</div>
		</form>
	</div>


	<div class="modal fade" id="resultModal" tabindex="-1" role="dialog"
		aria-labelledby="resultModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="resultModalLabel">결과</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div id="resultMessage"></div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- footer 영역 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>

	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
		integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
		integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
		crossorigin="anonymous"></script>
</body>
</html>