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
<!-- bootstrap-->
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
<title>문의게시판(글상세보기)</title>
<style>
* {
	box-sizing: border-box;
	padding: 0px;
	margin: 0px;
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
				<form
					action="qnaModify.do?qna_seq=${qna.qna_seq }"
					method="post">
					<hr />
					<div class="d-flex flex-row mb-2">
						<label for="id" class="form-label col-md-2"><span
							class="text-danger">*</span> 아이디</label>
						<div>
							<input 
								type="text" 
								id="user_id" 
								name="user_id" 
								value="${qna.user_id }"
								style="border:0"
								readonly />
						</div>
					</div>
					<hr />
					<div class="d-flex flex-row mb-2">
						<label for="title" class="form-label col-md-2"><span
							class="text-danger">*</span> 제목</label>
						<div>
							<input 
								type="text" 
								id="qna_title" 
								name="qna_title" 
								value="${qna.qna_title}"
								style="border:0"
								readonly />
						</div>
					</div>
					<hr />
					<div class="d-flex flex-row mb-2">
						<label for="category" class="form-label col-md-2">
							<span class="text-danger">*</span>
							카테고리
						</label>
						<select 
							class="form-control"
							id="qna_category"
							name="qna_category" 
							disabled>
							<option value="1" selected>시세</option>
							<option value="2">환율</option>
							<option value="3">매수</option>
							<option value="4">매도</option>
						</select>
					</div>
					<hr />
					<div class="d-flex flex-row mb-2">
						<label for="content" class="form-label col-md-2"><span
							class="text-danger">*</span> 내용</label>
						<div class="col-md-10">
							<div
							 	type="text" 
							 	id="qna_title" 
							 	name="qna_title"
							 	style="word-break:break-all">
							 	${qna.qna_content}
							 </div>
						</div>
					</div>
					<hr />
					<div class="row">
						<div class="d-grid gap-4 d-md-flex justify-content-md-end">
							<input 
								type="button" 
								class="btn btn-secondary"
								onclick="location.href='qnaList.do'" 
								value="글목록" /> 
							<input
								type="submit" 
								class="btn btn-secondary"
								value="글수정" /> 
							<input
								type="button" 
								class="btn btn-secondary"
								onclick="location.href='delete.do?qna_seq=${qna.qna_seq}'"
								value="글삭제" />
						</div>
					</div>
				</form>
				<form
					action="qnaReplyOk.do?qna_seq=${qna.qna_seq }&user_id=${qna.user_id}"
					method="post">
					<hr />
					<c:forEach var="replyList" items="${qnaReplyList }">
						<div class="d-flex flex-row mb-2">
							<label for="reply" class="form-label col-md-2"><span
								class="text-danger">*</span>답변내용</label>
							<div class="col-md-12">
								<div class="col-md-10">${replyList.qna_reply_content }</div>
							</div>
						</div>
					</c:forEach>

					<hr />
					<div class="d-flex flex-row mb-2">
						<label for="reply" class="form-label col-md-2"><span
							class="text-danger">*</span>답변내용</label>
						<div class="col-md-12">
							<input type="text" class="col-md-10" id="qna_reply_content"
								name="qna_reply_content">
						</div>
					</div>
					<div class="row">
						<div class="d-grid gap-4 d-md-flex justify-content-md-end">
							<input
								type="submit" 
								class="btn btn-secondary"
								value="댓글등록" /> 
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- footer 영역 -->
</body>
</html>