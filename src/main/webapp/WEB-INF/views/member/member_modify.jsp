<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="se"
	uri="http://www.springframework.org/security/tags"%>
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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {

		let id = $('#id').val();
		let b_userData = {};
		let a_userData = {};
		let new_userData = {};
		let focusdata = '';

		$.ajax({
			url : '/sspl_finance/member/userData/',
			type : 'get',
			contentType : 'application/json;charset=UTF-8',
			data : {
				"id" : id
			},
			dataType : 'json',
			success : function(data) {
				$('#name').val(data.name);
				$('#email').val(data.email);
				$('#phone_number').val(data.phone_number);
				b_userData.name = data.name;
				b_userData.email = data.email;
				b_userData.phone_number = data.phone_number
			},
			error : function(xhr, status, error) {
				console.error(error); // 에러 처리
			}
		});

		$('#form')
				.submit(
						function(e) {

							e.preventDefault(); // 폼의 기본 동작인 페이지 새로고침을 방지

							let password = $("#password").val();
							let password_ok = $("#password_ok").val();

							// Validate name
							let nameRegex = /^[가-힣]{2,4}$/;
							let name = $("#name").val();
							if (!nameRegex.test(name)) {
								$("#resultModal").modal("show");
								$("#resultMessage").text(
										"이름은 2자 이상 4자 이하의 한국어만 입력 가능합니다.");
								focusdata = "#name"; // Set the focusdata variable for name input field
								return;
							}

							if (password !== password_ok) {
								$("#resultModal").modal("show");
								$("#resultMessage")
										.text("비밀번호 서로 다르게 입력하셨습니다.");
								focusdata = "#password_ok"; // Set the focusdata variable for password_ok input field
								return;
							}

							// Validate email
							let emailRegex = /^[A-Za-z\d]+@[A-Za-z\d]+\.[A-Za-z\d]+$/;
							let email = $("#email").val();
							if (!emailRegex.test(email)) {
								$("#resultModal").modal("show");
								$("#resultMessage").text("올바른 이메일 주소를 입력하세요.");
								focusdata = "#email"; // Set the focusdata variable for email input field
								return;
							}

							// Validate phone number
							let phoneRegex = /^(010|011|016|017|018|019)[^0][0-9]{3,4}[0-9]{4}$/;
							let phone_number = $("#phone_number").val();
							if (!phoneRegex.test(phone_number)) {
								$("#resultModal").modal("show");
								$("#resultMessage").text("올바른 휴대폰 번호를 입력하세요.");
								focusdata = "#phone_number"; // Set the focusdata variable for phone_number input field
								return;
							}

							let formData = $(this).serialize();

							console.log("sdfsdfsdf" + formData.name);
							$
									.ajax({
										url : '/sspl_finance/member/passwordCheck', // 수정된 주소로 변경
										type : 'POST',
										contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
										data : formData,
										dataType : 'text',
										success : function(data) {

											console.log(data);
											if (data === "true") {
												a_userData.name = $('#name')
														.val();
												a_userData.email = $('#email')
														.val();
												a_userData.phone_number = $(
														'#phone_number').val();
												dupData();
											} else if (data === "false") {
												$('#resultMessage').empty();
												$('#resultModal').modal('show');
												$('#resultMessage').text(
														"비밀번호를 잘못 입력하셨습니다.");
											}

										},
										error : function(xhr, status, error) {
											console.error(error); // 에러 처리
										}
									});

							function nextPage(message) {
								if (message.includes("성공")
										|| message.includes("완료")) {
									location.href = "/sspl_finance/";
								} else if (message.includes("@")) {
									focusdata = "#email";
									focusOn(focusdata);
								} else if (message.includes("01")) {
									focusdata = "#phone_number";
									focusOn(focusdata);
								}
							}

							function equalsCheck() {
								let userData = {
									"user_id" : id,
									"name" : (b_userData.name !== a_userData.name) ? a_userData.name
											: "null",
									"email" : (b_userData.email !== a_userData.email) ? a_userData.email
											: "null",
									"phone_number" : (b_userData.phone_number !== a_userData.phone_number) ? a_userData.phone_number
											: "null"
								};
								now_userData = userData;

								let count = 0;

								console.log(b_userData);
								console.log(a_userData);
								console.log(now_userData);

								for ( var prop in now_userData) {
									if (now_userData[prop] !== "null") {
										count++;
									}
								}

								return count;
							}

							function dupData() {
								equalsCheck();
								console.log("진입");
								console.log(now_userData);
								$
										.ajax({
											url : "/sspl_finance/member/dupDataCheck",
											type : "POST",
											contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
											data : now_userData,
											dataType : "json",
											success : function(data) {

												if (equalsCheck() >= 1) {
													console.log(now_userData);
													console.log("유무:"
															+ equalsCheck());

													if (data.message == "null") {
														console.log("나옴");
														console.log(data);
														update(now_userData);
													} else if (data.message != "null") {
														$('#resultMessage')
																.empty();
														$('#resultModal')
																.modal('show');
														$('#resultMessage')
																.text(
																		data.message);
														$('#resultModal')
																.on(
																		'hidden.bs.modal',
																		function() {
																			nextPage(data.message);
																		});
													}
												}
											},
											error : function(xhr, status, error) {
												console.error(error); // 에러 처리
											},
										});

							}

							function update(userData) {

								if (equalsCheck() === 1) {
									$('#resultModal').modal('show');
									$('#resultMessage').text("수정된 데이터가 없습니다.");
									return;
								}

								$
										.ajax({
											url : "/sspl_finance/member/userModify",
											type : "POST",
											contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
											data : now_userData,
											dataType : "json",
											success : function(data) {
												$('#resultMessage').empty();
												if (data.message != null) {

													$('#resultModal').modal(
															'show');
													$('#resultMessage').text(
															data.message);
													$('#resultModal')
															.on(
																	'hidden.bs.modal',
																	function() {
																		console
																				.log("없음");
																		nextPage(data.message);
																	});
												}
											},
											error : function(xhr, status, error) {
												console.error(error); // 에러 처리
											},
										});
							}

						});

		function focusOn(elementId) {
			console.log(elementId);
			$(elementId).focus();
		}

		// 모달 닫기 버튼 클릭 이벤트 처리
		$("#resultModal").on("click", '[data-dismiss="modal"]', function() {
			$("#resultModal").modal("hide");

			$("#resultModal").on("hidden.bs.modal", function() {
				console.log("커서" + focusdata)
				focusOn(focusdata); // Set focus on the input field stored in focusdata variable
			});
		});

	});
</script>
</head>

<body>
	<header>
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	</header>
	<!-- 여기서부터 메인 -->
	<se:authentication property="name" var="LoginUser" />


	<div id="main" class="container my-5">
		<div class="row justify-content-center">
			<div class="col-md-6">
				<h3 class="text-center mb-3">SSPL Finance</h3>
				<form action="" class="pt-5" id="form" method="post">
					<!-- Added method="post" attribute -->
					<div class="form-group pt-4">
						<label for="name">이름</label> <input type="text"
							class="form-control" name="name" id="name"
							placeholder="수정 할 이름을 입력하세요" />
					</div>
					<div class="form-group pt-4">
						<label for="email">이메일</label> <input type="text"
							class="form-control" name="email" id="email"
							placeholder="이메일을 입력하세요" />
					</div>
					<div class="form-group pt-4">
						<label for="phone_number">휴대폰번호</label> <input type="text"
							class="form-control" name="phone_number" id="phone_number"
							placeholder="휴대폰 번호를 입력하세요" />
					</div>
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
					<div class="text-center pt-2">
						<input type="submit" class="btn btn-secondary mr-4 px-4 btn-sm"
							value="수정하기" /> <input type="button"
							class="btn btn-secondary ml-3 px-4 btn-sm" value="취소하기"
							onClick="location.href='${pageContext.request.contextPath}/'" />

						<input type="hidden" id="id" name="id" value="${LoginUser}">
					</div>
				</form>
			</div>
		</div>
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
	
</body>
</html>