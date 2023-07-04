<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags" %>


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
<div class="userMessage">[${LoginUser}]</div>

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
						<div class="col-md-9">
							<div
							 	type="text" 
							 	id="user_id" 
							 	name="user_id"
							 	style="word-break:break-all">
							 	${qna.user_id }
							 </div>
						</div>
					</div>
					<hr />
					<div class="d-flex flex-row mb-2">
						<label for="title" class="form-label col-md-2"><span
							class="text-danger">*</span> 제목</label>
						<div class="col-md-9">
							<div
							 	type="text" 
							 	id="qna_title" 
							 	name="qna_title"
							 	style="word-break:break-all">
							 	${qna.qna_title}
							 </div>
						</div>
					</div>
					<hr />
					<div class="d-flex flex-row mb-2">
						<label for="category" class="form-label col-md-2">
							<span class="text-danger">*</span>
							카테고리
						</label>
						<div class="col-md-9">
							<div
							 	type="text" 
							 	id="qna_category" 
							 	name="qna_category"
							 	style="word-break:break-all">
							 	${qna.qna_category}
							 </div>
						</div>
					</div>
					<hr />
					<div class="d-flex flex-row mb-2">
						<label for="content" class="form-label col-md-2"><span
							class="text-danger">*</span> 내용</label>
						<div class="col-md-9">
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
				
				<hr />
				<c:forEach var="replyList" items="${qnaReplyList }">
					<div class="d-flex flex-row mb-2 reply">
						<label for="reply" class="form-label col-md-2"><span
							class="text-danger">*</span>답변내용</label>
						<div class="col-md-8">
							<input 
								class="col-md-11"
								type="text" 
								id="qna_reply_editContent${replyList.qna_reply_seq}" 
								name="qna_reply_content"
								value="${replyList.qna_reply_content }"
								style="word-break:keep-all; display:none"
								 />
							<div 
								class="col-md-11" 
								id="qna_reply_content${replyList.qna_reply_seq}"
								style="word-break:break-all">
								${replyList.qna_reply_content }
							</div>
						</div>
						<div class="d-flex flex-row">
							<div>
								<input type="button" class="updateReply" id="updateReply${replyList.qna_reply_seq}" qna_seq="${qna.qna_seq }" qna_reply_seq="${replyList.qna_reply_seq}" value="수정">								
							</div>
							<div style="margin-left: 5px">
								<input type="button" class="deleteReply" id="deleteReply${replyList.qna_reply_seq}" qna_seq="${qna.qna_seq }" qna_reply_seq="${replyList.qna_reply_seq}" value="삭제">
							</div>
						</div>
						<div class="d-flex flex-row">
							<div>
								<input type="button" class="updateOkReply" id="updateOkReply${replyList.qna_reply_seq}" qna_seq="${qna.qna_seq }" qna_reply_seq="${replyList.qna_reply_seq}" value="완료" style="display:none">								
							</div>
							<div style="margin-left: 5px">
								<input type="button" class="cancleReply" id="cancleReply${replyList.qna_reply_seq}" qna_seq="${qna.qna_seq }" qna_reply_seq="${replyList.qna_reply_seq}" value="취소" style="display:none">
							</div>
						</div>
						<!-- 
						"deleteReply.do?qna_reply_seq=${replyList.qna_reply_seq }&qna_seq=${qna.qna_seq}"
						<a href="modifyReply.do?qna_reply_seq=${replyList.qna_reply_seq }&qna_seq=${qna.qna_seq}">o</a>
						 -->
					</div>
				</c:forEach>
				<form
					action="qnaReplyOk.do?qna_seq=${qna.qna_seq }&user_id=${qna.user_id}"
					method="post">
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
	
	<script>
		$('.deleteReply').on('click', function(){
			console.log("삭제하러갈거야");
			console.log("qna_seq : " + $(this).attr("qna_seq"));
			console.log("qna_reply_seq : " + $(this).attr("qna_reply_seq"));
			let qna_seq = $(this).attr("qna_seq");
			let qna_reply_seq = $(this).attr("qna_reply_seq"); 
			$.ajax({
				url : "deleteReply.do",
				data : "qna_seq="+qna_seq+"&qna_reply_seq="+qna_reply_seq,
				success : function(response) {
					console.log("다녀왔어요~");
				}
			})
			$('#qna_reply_content'+qna_reply_seq).parent().parent().remove();
		})
		
		$('.updateReply').on('click', function(){
			console.log("수정버튼 눌렀어~");
			let qna_reply_seq = $(this).attr("qna_reply_seq");
			$('#deleteReply'+qna_reply_seq).attr("style", "display:none");
			$('#updateReply'+qna_reply_seq).attr("style", "display:none");
			$('#updateOkReply'+qna_reply_seq).removeAttr('style');
			$('#cancleReply'+qna_reply_seq).removeAttr('style');
			
			$('#qna_reply_editContent'+qna_reply_seq).removeAttr('style');
			$('#qna_reply_editContent'+qna_reply_seq).attr("style", "word-break:keep-all");
			$('#qna_reply_content'+qna_reply_seq).removeAttr('style');
			$('#qna_reply_content'+qna_reply_seq).attr("style", "display:none");
		})
		
		$('.cancleReply').on('click', function(){
			console.log("취소버튼 눌렀어~");
			let qna_reply_seq = $(this).attr("qna_reply_seq");
			$('#updateOkReply'+qna_reply_seq).attr("style", "display:none");
			$('#cancleReply'+qna_reply_seq).attr("style", "display:none");
			$('#deleteReply'+qna_reply_seq).removeAttr('style');
			$('#updateReply'+qna_reply_seq).removeAttr('style');
			
			$('#qna_reply_content'+qna_reply_seq).removeAttr('style');
			$('#qna_reply_content'+qna_reply_seq).attr("style", "word-break:break-all");
			$('#qna_reply_editContent'+qna_reply_seq).removeAttr('style');
			$('#qna_reply_editContent'+qna_reply_seq).attr("style", "display:none");
		})
		
		$('.updateOkReply').on('click', function(){
			console.log("수정합시다~");
			let qna_reply_seq = $(this).attr("qna_reply_seq");
			console.log("seq : " + qna_reply_seq);
			
			let data = {
				"qna_reply_seq" : qna_reply_seq,
				"qna_reply_content": $('#qna_reply_editContent'+qna_reply_seq).val()
			}
			console.log(data);
			$.ajax({
				url : "updateOkReply.do",
				type : "POST",
				data: data,
				success : function(response) {
					console.log("수정하고 왔어요~~");
					console.log("response : " + response.qna_reply_content);
					let div = "";
					div += "<div class='col-md-11' id='qna_reply_content" + qna_reply_seq + "'>";
					div += response.qna_reply_content;
					div += "</div>";
					$('#qna_reply_content'+qna_reply_seq).remove();
					$('#qna_reply_editContent' + qna_reply_seq).after(div);
					$('#qna_reply_editContent' + qna_reply_seq).attr("style", "display:none");
					
					$('#updateOkReply'+qna_reply_seq).attr("style", "display:none");
					$('#cancleReply'+qna_reply_seq).attr("style", "display:none");
					$('#deleteReply'+qna_reply_seq).removeAttr('style');
					$('#updateReply'+qna_reply_seq).removeAttr('style');
				}
			})
		})	
	</script>
</body>
</html>