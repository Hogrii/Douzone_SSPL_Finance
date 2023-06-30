<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
						<tr class="border-bottom border-2">
							<td>4</td>
							<td>시세</td>
							<td><a href="qnaDetail.do"><box-icon
										name="lock" type="solid"></box-icon>&nbsp;문의드립니다.</a>
							</td>
							<td>김유신</td>
							<td>2023-06-27</td>
							<td>답변완료</td>
							<td><box-icon name="file"></box-icon></td>
						</tr>
						<tr class="border-bottom border-2">
							<td>3</td>
							<td>매수</td>
							<td><a href="#"><box-icon
										name="lock" type="solid"></box-icon>&nbsp;문의드립니다.</a>
							</td>
							<td>김유신</td>
							<td>2023-06-26</td>
							<td>답변완료</td>
							<td></td>
						</tr>
						<tr class="border-bottom border-2">
							<td>2</td>
							<td>매도</td>
							<td><a href="#"><box-icon
										name="lock" type="solid"></box-icon>&nbsp;문의드립니다.</a>
							</td>
							<td>이순신</td>
							<td>2023-06-25</td>
							<td>답변 중</td>
							<td><box-icon name="file"></box-icon></td>
						</tr>
						<tr class="border-bottom border-2">
							<td>1</td>
							<td>매수</td>
							<td><a href="#"><box-icon
										name="lock" type="solid"></box-icon>&nbsp;문의드립니다.</a>
							</td>
							<td>홍길동</td>
							<td>2023-06-22</td>
							<td>답변완료</td>
							<td><box-icon name="file"></box-icon></td>
						</tr>
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

		<div>
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center">
					<li class="page-item"><a class="page-link" href="#"
						aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
					</a></li>
					<li class="page-item"><a class="page-link" href="#">1</a></li>
					<li class="page-item"><a class="page-link" href="#">2</a></li>
					<li class="page-item"><a class="page-link" href="#">3</a></li>
					<li class="page-item"><a class="page-link" href="#"
						aria-label="Next"> <span aria-hidden="true">&raquo;</span>
					</a></li>
				</ul>
			</nav>
		</div>
	</div>
	<!-- footer 영역 -->
</body>
</html>