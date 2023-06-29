<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous" />
<!-- JavaScript Bundle with Popper -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous"></script>
<link
	href="${pageContext.request.contextPath }/resources/css/global.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/communityList.css"
	rel="stylesheet" type="text/css">
</head>
<body>
	<div class="listContainer">
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	<div class="main py-5">
		<!-- 검색버튼 시작 -->
		<div class="searchBar">
			<div class="searchCategory">
				<select name="" id="">
					<option value="제목">제목</option>
					<option value="작성자">작성자</option>
					<option value="글제목">글제목</option>
				</select>
			</div>
			<div class="searchText">
				<input type="text" placeholder="검색어를 입력하세요" />
			</div>
			<div class="searchBtn">
				<button type="button" class="btn btn-secondary">검색</button>
			</div>
		</div>
		<!-- 검색 버튼 끝 -->

		<!-- 총 게시물 출력 시작 -->
		<div class="totalPostContainer">총 0건의 게시물</div>
		<!-- 총 게시물 출력 끝 -->

		<!-- 테이블 시작 -->
		<table class="table">
			<thead class="table-light">
				<tr>
					<td>순번</td>
					<td>카테고리</td>
					<td>제목</td>
					<td>글쓴이</td>
					<td>작성날짜</td>
					<td>파일</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>1</td>
					<td>매도</td>
					<td>힘내라 힘!</td>
					<td>난_민아라고해</td>
					<td>2023-06-26</td>
				</tr>
			</tbody>
		</table>
		<!-- 테이블 끝 -->

		<!-- 글쓰기 버튼 시작 -->
		<div class="writeContainer">
			<button type="button" class="btn btn-secondary">글쓰기</button>
		</div>
		<!-- 글쓰기 버튼 끝 -->
	</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
</html>