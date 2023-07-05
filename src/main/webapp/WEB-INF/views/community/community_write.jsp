<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Insert title here</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- jQuery cdn -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- bootstrap cdn -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- summernote cdn -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
	rel="stylesheet" />
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<link href="${pageContext.request.contextPath}/resources/css/global.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/css/communityWrite.css"
	rel="stylesheet" type="text/css" />
</head>
<!-- 내부에서 세션 체크 필요 -->
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	<!-- 글쓰기 내용 시작 -->
	<se:authentication property="name" var="LoginUser" />
	<input id="login_id" type="hidden" value="${LoginUser}">
	
	<form action="writeOk.do" method="post" id="frmWrite"
		enctype="multipart/form-data">
		<div class="writeBar py-5">
			<div class="writeCategory">
				<select id="comm_category" name="comm_category">
					<option value="">유형</option>
					<option value="매도">매도</option>
					<option value="매수">매수</option>
					<option value="시세">시세</option>
					<option value="환율">환율</option>
				</select>
			</div>

			제목 : <input type="text" placeholder="제목을 입력하세요" id="comm_title"
				name="comm_title" />
		</div>
		<!-- 글쓰기 내용 끝 -->

		<!-- summernote 시작 -->
		<!-- https://programmer93.tistory.com/27 참고 -->
		<div class="summernote">
			<textarea id="summernote" name="comm_content"></textarea>
		</div>
		<!-- summernote 끝 -->

		<!-- 글쓰기 버튼 시작 -->
		<div class="writeBtns">
			<button class="btn btn-secondary" id="goWrite">완료</button>
			<button type="button" class="btn btn-secondary"
				onclick="location.href='list.do'">취소</button>
		</div>
	</form>
	<!-- 글쓰기 버튼 끝 -->
</body>
<script>
	$(document)
			.ready(
					function() {
						$('#summernote')
								.summernote(
										{
											height : 300, // 에디터 높이
											minHeight : null, // 최소 높이
											maxHeight : null, // 최대 높이
											focus : true, // 에디터 로딩후 포커스를 맞출지 여부
											lang : "ko-KR", // 한글 설정
											placeholder : '최대 2048자까지 쓸 수 있습니다', // placeholder 설정
											callbacks : { //여기 부분이 이미지를 첨부하는 부분
												onImageUpload : function(files) {
													uploadSummernoteImageFile(
															files[0], this);
												},
												onPaste : function(e) {
													var clipboardData = e.originalEvent.clipboardData;
													if (clipboardData
															&& clipboardData.items
															&& clipboardData.items.length) {
														var item = clipboardData.items[0];
														if (item.kind === 'file'
																&& item.type
																		.indexOf('image/') !== -1) {
															e.preventDefault();
														}
													}
												}
											}
										});

						/**
						 * 이미지 파일 업로드
						 */
						function uploadSummernoteImageFile(file, editor) {
							console.log("update call!!");
							var data = new FormData();
							data.append("file", file);
							$.ajax({
								data : data,
								type : "POST",
								enctype : 'multipart/form-data',
								url : "/sspl_finance/community/image",
								contentType : false,
								processData : false,
								success : function(data) {
									//console.log(data);
									//항상 업로드된 파일의 url이 있어야 한다.
									//var json = JSON.parse(data);
									$(editor).summernote('insertImage',
											data.url);
									//$(el).summernote('editor.insertImage',data["url"]);
									//jsonArray.push(json["url"]);
									//jsonFn(jsonArray);
									//$(editor).summernote('insertImage', data.url);
								}
							});
						}

						$("div.note-editable")
								.on(
										'drop',
										function(e) {
											for (i = 0; i < e.originalEvent.dataTransfer.files.length; i++) {
												uploadSummernoteImageFile(
														e.originalEvent.dataTransfer.files[i],
														$("#summernote")[0]);
											}
											e.preventDefault();
										});

						$("#goWrite").on("click", function() {
							if ($("#comm_category").val() == "") {
								alert("카테고리를 선택해주세요");
								return false;
							}
							//console.log("summernote 내용은 : " + $("#summernote").val());
							if ($("#summernote").val() == "") {
								alert("내용을 입력해주세요");
								return false;
							}
							if ($("#comm_title").val() == "") {
								alert("제목을 입력해주세요");
								return false;
							}
							if (confirm("이대로 작성하시겠습니까?") == true) {
								$("#frmWrite").submit();
							} else {
								return false;
							}
						});
					});
</script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/summernote.js"></script>
</html>
