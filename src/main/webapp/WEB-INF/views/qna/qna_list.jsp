<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- bootstrap css-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" />
<!-- bootstrap js cdn-->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- boxicons js cdn -->
<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<!-- jQuery cdn -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
	crossorigin="anonymous">
<title>문의게시판(글목록)</title>
<style>
* {
	box-sizing: border-box;
	padding: 0px;
	margin: 0px;
}

box-icon {
	vertical-align: -5px;
}
</style>
</head>
<body>
	<!-- header 영역 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<!-- content 영역 -->
	<div class="container my-5">
		<div class="row">
			<div class="col-md-9 align-self-center">
				<p>
					총 <strong class="text-danger">00</strong>건의 게시물
				</p>
			</div>
			<div class="col-md-3">
				<form action="#">
					<div class="input-group mb-3">
						<input type="text" class="form-control" placeholder="검색어를 입력하세요" />
						<button type="submit" class="btn btn-secondary">검색</button>
					</div>
				</form>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover text-center">
					<thead
						class="border-top border-bottom border-1 border-secondary bg-secondary text-dark bg-opacity-25">
						<tr>
							<th>순번</th>
							<th>카테고리</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>답변상태</th>
							<th>파일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="list" items="${qnaList}">
							<tr class="border-bottom border-2">
								<td>${list.qna_seq }</td>
								<td>${list.qna_category }</td>
								<td><a href="qnaDetail.do?qna_seq=${list.qna_seq }"> <box-icon
											name="lock" type="solid"></box-icon> ${list.qna_title }
								</a></td>
								<td>${list.user_id }</td>
								<td>${list.qna_date}</td>
								<td>${list.qna_status }</td>
								<td><box-icon name="file"></box-icon></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="d-grid gap-1 d-md-flex justify-content-md-end">
				<a href="qnaWrite.do">
					<button type="button" class="btn btn-secondary">글 작성</button>
				</a>
			</div>
		</div>

		<div class="d-flex justify-content-between">
			<div class="" style="visibility: hidden;"></div>
			<!-- 공간차지용 -->

			<!-- 페이징 시작  ★★★★★★★★★★★★★★★★★★★★★★-->
			<ul id="page" class="pagination" style="margin: 0 auto">
				<!-- justify-content-end -->
				<c:if test="${cpage>1 }">
					<li class="page-item"><a
						href="qnaList.do?cp=${cpage-1}&ps=${pagesize}" class="page-link">
							<i class="fas fa-arrow-left"></i>
					</a></li>
				</c:if>
				<c:forEach var="i" begin="1" end="${pagecount}" step="1">
					<c:choose>
						<c:when test="${cpage == i }">
							<li class="page-item"><a href="" class="page-link"
								style="color: red">${i}</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a
								href="qnaList.do?cp=${i}&ps=${pagesize}" class="page-link">${i}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${cpage < pagecount}">
					<li class="page-item"><a
						href="qnaList.do?cp=${cpage+1}&ps=${pagesize}" class="page-link">
							<i class="fas fa-arrow-right"></i>
					</a></li>
				</c:if>
			</ul>
			<!-- 페이징 끝  ★★★★★★★★★★★★★★★★★★★★★★★★★★ -->
		</div>
	</div>
	<!-- footer 영역 -->
</body>
</html>
