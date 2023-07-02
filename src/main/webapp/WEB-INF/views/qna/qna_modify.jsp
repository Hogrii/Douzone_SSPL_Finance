<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	rel="stylesheet" />
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<title>문의게시판(글수정)</title>
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
	<!-- header 영역 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<!-- content 영역 -->
	<div class="container my-5">
		<div class="row justify-content-center">
			<div class="col-md-8">
				<form action="qnaModifyOk.do?qna_seq=${qna.qna_seq }" method="post">
					<hr />
					<div class="d-flex flex-row mb-2">
						<label for="id" class="form-label col-md-2"><span
							class="text-danger">*</span>아이디</label>
						<input 
							type="text" 
							name="user_id" 
							value="${qna.user_id }" 
							style="border: 0"
							readonly />
					</div>
					<hr />
					<div class="d-flex flex-row mb-2">
						<label for="title" class="form-label col-md-2"><span
							class="text-danger">*</span>제목</label> 
						<input 
							type="text"
							class="form-control" 
							id="title"
							name="qna_title"
							placeholder="제목을 입력하세요"
							value=${qna.qna_title } />
					</div>
					<hr />
					<div class="d-flex flex-row mb-2">
						<label for="category" class="form-label col-md-2"><span
							class="text-danger">*</span>카테고리</label> 
						<select
							class="form-select form-control" 
							id="category"
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
							class="text-danger">*</span>내용</label>
						<div class="col-md-10">
							<textarea id="summernote" name="qna_content">${qna.qna_content }</textarea>
						</div>
					</div>
					<div class="row">
						<div class="d-grid gap-4 d-md-flex justify-content-md-end">
							<input type="submit" class="btn btn-secondary" value="수정" />
							<input type="button" class="btn btn-secondary" value="취소" />
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- footer 영역 -->
	
	<script>
		$("#summernote").summernote({
		    placeholder: "문의 내용을 입력해주세요.",
		    tabsize: 2,
		    height: 300,
		    maxHeight: 300,
		    minHeight:300,
		    lang: "ko-KR",
		    toolbar: [
		        ["style", ["style"]],
		        [
		            "font",
		            ["bold", "underline", "clear"],
		        ],
		        ["color", ["color"]],
		        ["para", ["ul", "ol", "paragraph"]],
		        ["table", ["table"]],
		        [
		            "insert",
		            ["link", "picture", "video"],
		        ],
		        [
		            "view",
		            ["codeview"],
		        ],
		    ],
		    callbacks: {	//여기 부분이 이미지를 첨부하는 부분
		    	console.log("콜백와써요");
				onImageUpload : function(files) {
					sendFile(files[0],this);
				}
			}
		});
	
		/**
		* 이미지 파일 업로드
		*/
		function sendFile(file, editor) {
		    var form_data = new FormData();
		    form_data.append('file', file);
		    $.ajax({
		        data : form_data,
		        type : "POST",
		        url : "/qna/qnaImage.do",
		        cache : false,
		        contentType : false,
		        enctype : "multipart/form-data",
		        processData : false,
		        success : function(sysName) {
		            console.log(sysName + "b")
					console.log("write에 왔습니다.")
		            $(editor).summernote('insertImage', sysName);
		        }
		    });
		}
	</script>
</body>
<!-- 
<script
	src="${pageContext.request.contextPath}/resources/js/summernote.js"></script>
	 -->
</html>