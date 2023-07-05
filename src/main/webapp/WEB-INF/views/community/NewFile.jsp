<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 	html +=	"<div class='d-flex flex-row'>"
	html +=	"<div> <input type='button' class='updateReply' id='updateReply'+${this.user_id}" qna_seq="${qna.qna_seq }" qna_reply_seq="${replyList.qna_reply_seq}" value="수정">								
	html +=  </div>
	html +=	 <div style="margin-left: 5px">
	html +=		<input type="button" class="deleteReply" id="deleteReply${replyList.qna_reply_seq}" qna_seq="${qna.qna_seq }" qna_reply_seq="${replyList.qna_reply_seq}" value="삭제">
	html +=	</div>
	html += 	</div>
	html +=	<div class="d-flex flex-row">
	html +=		<div>
	html +=			<input type="button" class="updateOkReply" id="updateOkReply${replyList.qna_reply_seq}" qna_seq="${qna.qna_seq }" qna_reply_seq="${replyList.qna_reply_seq}" value="완료" style="display:none">								
	html +=		</div>
	html +=		<div style="margin-left: 5px">
	html +=			<input type="button" class="cancleReply" id="cancleReply${replyList.qna_reply_seq}" qna_seq="${qna.qna_seq }" qna_reply_seq="${replyList.qna_reply_seq}" value="취소" style="display:none">
	html +=		</div>
	html +=	</div>
	<!-- footer 영역 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	
</body>
</html>