<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- CSS only -->
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
	href="${pageContext.request.contextPath }/resources/css/communityDetail.css"
	rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	
	<div class="Container py-5">
		<!-- 글 내용 시작 -->
		<c:set var="detail" value="${requestScope.detaillist}" />
		<div class="titles">
			<div class="category">[${detail.comm_category}]</div>
			<div class="title">${detail.comm_title}</div>
		</div>
		<div class="writeInfo">
			<div class="userid">${detail.user_id}</div>
			<div class="writen_date">${detail.comm_writen_date}</div>
			<div class="view_count">조회수 : ${detail.comm_view_count}</div>
		</div>
		<div class="content">${detail.comm_content}</div>
		<!-- 글 내용 끝 -->

		<!-- 댓글 시작 -->
		<div class="replyContainer">
			<div class="replyText">
				<span>댓글 0</span>
			</div>
			<div class="replyContentBox">
				<div class="replyContent">
					<input type="text" placeholder="내용을 입력해주세요" />
				</div>
				<div class="replyBtn">
					<button type="button" class="btn btn-secondary">완료</button>
				</div>
			</div>
		</div>
		<!-- 댓글 끝 -->

		<!-- 목록, 수정, 삭제 버튼 시작 -->
		<div class="btns">
			<div class="listBtn">
				<button type="button" class="btn btn-secondary" onclick="location.href='list.do'">목록</button>
			</div>
			<div class="otherBtns">
				<button type="submit" class="btn btn-secondary" onclick="location.href='modify.do?comm_seq=${detail.comm_seq}'">수정</button>
				<button type="button" class="btn btn-secondary" onclick="location.href='delete.do?comm_seq=${detail.comm_seq}'">삭제</button>
			</div>
		</div>
		<!-- 목록, 수정, 삭제 버튼 끝 -->
	</div>
</body>
</html>