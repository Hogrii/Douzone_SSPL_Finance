<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="se"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
	crossorigin="anonymous">
<link href="${pageContext.request.contextPath }/resources/css/global.css"
	rel="stylesheet" type="text/css">
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
<script type="text/javascript">
	$(function() {
		$('#search').on('click', function(){
			let qna_title = $('#qna_title').val();
			$.ajax({
				url : "searchKeyword.do",
				type : "GET",
				data : {
					"qna_title" : qna_title
				},
				dataType : "JSON",
				success : function(data) {
					$('#tbody').empty();
					$('#page').empty();
					if(data.length == 0) { //검색 결과가 없는 경우
						let tr = "<tr>";
						tr += "<td class='text-center' colspan='4'>검색 결과가 없습니다.</td>";
						tr += "</tr>";
						$('#tbody').append(tr);
					}else { //검색 결과가 있는 경우
						data.forEach(item => {
							let tr = "<tr>";
							tr += "<td>" + item.qna_seq + "</td>";
							tr += "<td>" + item.qna_category + "</td>";
							tr += "<td><a href='qnaDetail.do?qna_seq="
									+ item.qna_seq
									+ "'> <box-icon name='lock'' type='solid'></box-icon>"
									+ item.qna_title + "</a></td>";
							tr += "<td>" + item.user_id + "</td>";
							tr += "<td>" + item.qna_date + "</td>";
							tr += "<td>" + item.qna_status + "</td>";
							tr += "<td><box-icon name='file'></box-icon></td>";
							$('tbody').append(tr);
						});
					}
				}
			})
		})

		$('.title').on("click", function(){
			let qna_seq = $(this).attr("qna_seq");		

			let loginUser = $('#login_id').val();
			let writeUser = $('#user_id'+qna_seq).text();
			
			let cpage = $(this).attr("cpage");
			let pagesize = $(this).attr("pagesize");

			if(loginUser !== writeUser) {
				alert("접근 권한이 없습니다.");
			}else {
				location.href = "qnaDetail.do?qna_seq="+qna_seq+"&cp="+cpage+"&ps="+pagesize;
			}
		})
				
	})
</script>
</head>
<body>
	<se:authentication property="name" var="LoginUser" />
	<input id="login_id" type="hidden" value="${LoginUser}">
	<!-- header 영역 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<!-- content 영역 -->
	<div class="container my-5">
		<div class="row">
			<div class="col-md-9 align-self-center">
				<p>
					총 <strong class="text-danger">${totalcount }</strong>건의 게시물
				</p>
			</div>
			<div class="col-md-3">
				<form action="searchKeyword.do">
					<div class="input-group mb-3">
						<input type="text" class="form-control" id="qna_title"
							placeholder="글 제목을 입력하세요" />
						<button type="button" id="search" class="btn btn-secondary">검색</button>
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
					<tbody id="tbody">
						<c:forEach var="list" items="${qnaList}">
							<tr class="border-bottom border-2">
								<td class="qna_seq">${list.qna_seq }</td>
								<td>${list.qna_category }</td>
								<td class="title" qna_seq="${list.qna_seq }" cpage="${cpage}" pagesize="${pagesize }" }><box-icon name="lock" type="solid"></box-icon>${list.qna_title }</td>
								<td class="user_id" id="user_id${list.qna_seq}">${list.user_id }</td>
								<td>${list.qna_date}</td>
								<td>${list.qna_status }</td>
								<c:if test="${fn:contains(list.qna_content, '<img')}">
									<td><box-icon name="file"></box-icon></td>
								</c:if>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="d-grid gap-1 d-md-flex justify-content-md-end">
				<a href="qnaWrite.do">
					<button type="button" class="btn btn-secondary">글작성</button>
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
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	
</body>
</html>
