<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
							class="form-control" id="user_id" name="user_id"
							placeholder="아이디를 입력하세요" />
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
							<!-- 
                                <input
                                    type="submit"
                                    class="btn btn-secondary"
                                    value="취소"
                                />
                             -->
                                <input
                                    type="submit"
                                    class="btn btn-secondary"
                                    value="등록"
                                    id="qnaWriteOk"
                                />
							<!-- 
							<button type="button" class="btn btn-secondary" id="qnaWriteBtn">등록</button>
 -->
							<button type="button" class="btn btn-secondary"
								onclick="location.href='qnaList.do'">취소</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/summernote.js"></script>

</html>
