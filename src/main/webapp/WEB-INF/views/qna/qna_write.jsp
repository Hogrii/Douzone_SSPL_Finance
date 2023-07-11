<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- jQuery cdn-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- bootstrap cdn-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- summernote cdn -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<title>문의게시판(글작성)</title>
<style>
* {
	box-sizing: border-box;
	padding: 0px;
	margin: 0px;
}

hr {
	color: black;
	border-width: 0.125em;
}
</style>
</head>
<body>
	<se:authentication property="name" var="LoginUser"/>
	<input id="login_id" type="hidden" value="${LoginUser}">
	<!-- header 영역 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<!-- content 영역 -->
	<div class="container my-5">
		<div class="row justify-content-center">
			<div class="col-md-8">
				<form action="qnaWriteOk.do" method="post" id="frmWrite">
					<hr />
					<div class="d-flex flex-row mb-2">
						<label for="id" class="form-label col-md-2"><span
							class="text-danger">* </span>아이디</label> <input type="text"
							class="form-control" id="user_id" name="user_id" value="${LoginUser}" readonly
							style="border:none"
							/>
					</div>
					<hr />
					<div class="d-flex flex-row mb-2">
						<label for="title" class="form-label col-md-2"><span
							class="text-danger">* </span>제목</label> <input type="text"
							class="form-control" id="qna_title" name="qna_title"
							placeholder="제목을 입력하세요" />
					</div>
					<hr />
					<div class="d-flex flex-row mb-2">
						<label for="category" class="form-label col-md-2"><span
							class="text-danger">* </span>카테고리</label>
						<select
							class="form-select form-control"
							id="qna_category"
							name="qna_category">
							<option value="시세">시세</option>
							<option value="환율">환율</option>
							<option value="매수">매수</option>
							<option value="매도">매도</option>
						</select>
					</div>
					<hr />
					<div class="d-flex flex-row mb-2">
						<label for="content" class="form-label col-md-2"><span
							class="text-danger">* </span>내용</label>
						<div class="col-md-10">
							<textarea id="summernote" name="qna_content"></textarea>
						</div>
					</div>
					<div class="row">
						<div class="d-grid gap-4 d-md-flex justify-content-md-end">
                                <button
                                    type="button"
                                    class="btn btn-secondary"
                                    value="등록"
                                    id="qnaWriteOk"
                                >등록</button>
							<button type="button" class="btn btn-secondary"
								onclick="location.href='qnaList.do'">취소</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<!-- footer 영역 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	
	<script>
		$('#summernote').summernote({
			height: 300,                 // 에디터 높이
			minHeight: null,             // 최소 높이
			maxHeight: null,             // 최대 높이
			focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
			lang: "ko-KR",					// 한글 설정
			placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정
			callbacks: {	//여기 부분이 이미지를 첨부하는 부분
				onImageUpload : function(files) {
					uploadSummernoteImageFile(files[0],this);
				},
				onPaste: function (e) {
					var clipboardData = e.originalEvent.clipboardData;
					if (clipboardData && clipboardData.items && clipboardData.items.length) {
						var item = clipboardData.items[0];
						if (item.kind === 'file' && item.type.indexOf('image/') !== -1) {
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
			data = new FormData();
			data.append("file", file);
			$.ajax({
				data : data,
				type : "POST",
				enctype: 'multipart/form-data',
				url : "image",
				contentType : false,
				processData : false,
				success : function(data) {
	            	$(editor).summernote('insertImage', data.url);
				}
			});
		}
		
		$("#qnaWriteOk").on("click", function() {
			if ($("#qna_title").val() == "") {
				alert("제목를 선택해주세요");
				return false;
			}
			
			if ($("#qna_category").val() == "") {
				alert("카테고리를을 선택해주세요");
				return false;
			}
			
			if ($("#summernote").val() == "") {
				alert("내용을 입력해주세요");
				return false;
			}
			
			if (confirm("이대로 작성하시겠습니까?") == true) {
				$("#frmWrite").submit();
			} else {
				return false;
			}
		});
	</script>
	<script
		src="${pageContext.request.contextPath}/resources/js/summernote.js">
	</script>
</body>
</html>
