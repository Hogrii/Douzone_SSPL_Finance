<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
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

<!-- summernote -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
	rel="stylesheet" />
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<link
	href="${pageContext.request.contextPath }/resources/css/global.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/communityDetail.css"
	rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	<se:authentication property="name" var="LoginUser" />
	<div class="userMessage">[${LoginUser}]</div>
	
	<!-- 글쓰기 내용 시작 -->
	<form action="modifyOk.do" method="post">
		<c:set var="detail" value="${requestScope.detaillist}" />
		<div class="editBar py-5">
			<div class="editCategory">
				<select name="comm_category" class="readonly"
					onFocus="this.initialSelect = this.selectedIndex;"
					onChange="this.selectedIndex = this.initialSelect;">
					<option value="${detail.comm_category}">${detail.comm_category}</option>
				</select>
			</div>
			<div class="title">
				제목 : <input type="text" placeholder="${detail.comm_title}" readonly
					value="${detail.comm_title}" name="comm_title" />
			</div>
			<input type="hidden" name="comm_seq" value="${detail.comm_seq}">
		</div>
		<!-- 글쓰기 내용 끝 -->

		<!-- summernote 시작 -->
		<!-- https://programmer93.tistory.com/27 참고 -->
		<div class="summernote">
			<textarea id="summernote" name="comm_content">${detail.comm_content}</textarea>
		</div>
		<!-- summernote 끝 -->

		<!-- 목록, 수정, 삭제 버튼 시작 -->
		<div class="btns">
			<div class="listBtn">
				<button type="button" class="btn btn-secondary"
					onclick="location.href='list.do'">목록</button>
			</div>
			<div class="otherBtns">
				<button type="button" class="btn btn-secondary"
					onclick="goWrite(this.form)">완료</button>
				<button type="button" class="btn btn-secondary"
					onclick="location.href='list.do'">취소</button>
			</div>
		</div>
	</form>
	<!-- 목록, 수정, 삭제 버튼 끝 -->
	<script>
		$('#summernote').summernote(
				{
					height : 300, // 에디터 높이
					minHeight : null, // 최소 높이
					maxHeight : null, // 최대 높이
					focus : true, // 에디터 로딩후 포커스를 맞출지 여부
					lang : "ko-KR", // 한글 설정
					placeholder : '최대 2048자까지 쓸 수 있습니다', //placeholder 설정
					callbacks : { //여기 부분이 이미지를 첨부하는 부분
						onImageUpload : function(files) {
							uploadSummernoteImageFile(files[0], this);
						},
						onPaste : function(e) {
							var clipboardData = e.originalEvent.clipboardData;
							if (clipboardData && clipboardData.items
									&& clipboardData.items.length) {
								var item = clipboardData.items[0];
								if (item.kind === 'file'
										&& item.type.indexOf('image/') !== -1) {
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
			data = new FormData();
			data.append("file", file);
			$.ajax({
				data : data,
				type : "POST",
				url : "/sspl_finance/community/image",
				contentType : false,
				processData : false,
				success : function(data) {
					//항상 업로드된 파일의 url이 있어야 한다.
					//console.log(data);
					//let json = JSON.parse(data);
					//$(el).summernote('editor.insertImage',json["url"]);
					//jsonArray.push(json["url"]);
					//jsonFn(jsonArray);
					$(editor).summernote('insertImage', data.url);
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
						})

		function goWrite(frm) {
			let comm_category = frm.comm_category.value;
			let comm_title = frm.comm_title.value;
			let comm_content = $($("#summernote").summernote("code")).text();//frm.comm_content.value;
			console.log("comm_category : " + comm_category);
			console.log("comm_title : " + comm_title);
			console.log("comm_content : " + comm_content);
			if (comm_category.trim() == '') {
				alert("카테고리를 입력해주세요");
				return false;
			}
			if (comm_title.trim() == '') {
				alert("제목를 입력해주세요");
				return false;
			}
			if (comm_content.trim() == '') {
				alert("내용을 입력해주세요");
				return false;
			}
			frm.submit();

		}
	</script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/summernote.js"></script>
</body>
</html>