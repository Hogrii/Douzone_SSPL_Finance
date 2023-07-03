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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
.reply-item {
	background-color: #f5f5f5;
	padding: 10px;
	margin-bottom: 10px;
}

.user_id {
	font-weight: bold;
}

.reply_content {
	margin-top: 5px;
}

.reply_date {
	color: gray;
	font-size: 12px;
}
</style>
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

		<div class="replyContentBox">
			<div class="replyContent">
				<hr />
				<div id="replyList"></div>
				<hr />

			</div>

		</div>

		<form id="replyForm" name="replyForm">
			<table class="table">
				<tr>
					<td><textarea style="width: 1100px" rows="3" cols="30"
							id="comment" name="comment" placeholder="댓글을 입력하세요"></textarea> <br>
						<div>
							<!-- 
						<a href='#' onClick="fn_comment('${detail.comm_seq}')"
							class="btn pull-right btn-success">등록</a>
					 -->
							<button type="button" class="btn btn-secondary" id="reply_btn">등록</button>
						</div></td>
				</tr>
			</table>
		</form>

		<!-- 댓글 시작 
		<c:set var="replyList" value="${requestScope.replyList}" />
		<div id="replyList" class="replyContainer">
			<div class="replyText">
				<span>댓글 0</span>
			</div>
		-->



		<!-- 댓글 끝 -->


		<!-- 목록, 수정, 삭제 버튼 시작 -->
		<div class="btns">
			<div class="listBtn">
				<button type="button" class="btn btn-secondary"
					onclick="location.href='list.do'">목록</button>
			</div>
			<div id="class="otherBtns">
				<button type="submit" class="btn btn-secondary"
					onclick="location.href='modify.do?comm_seq=${detail.comm_seq}'">수정</button>
				<button type="button" class="btn btn-secondary"
					onclick="location.href='delete.do?comm_seq=${detail.comm_seq}'">삭제</button>
			</div>
		</div>
		<!-- 목록, 수정, 삭제 버튼 끝 -->
	</div>
</body>
<script type="text/javascript">
 
$(function(){
  console.log(${detail.comm_seq});
  function getList(){
  $.ajax({
    type: "get",
    url: "/sspl_finance/restcommunity/replySelect/" + ${detail.comm_seq},
    contentType: "application/json; charset=utf-8",

    success: function(data) {
      $("#replyList").empty();
      let html = "";

      $.each(data, function() {
    	  console.log("comm_reply_seq 는 "+this.comm_reply_seq);
    	html += "<div class='d-flex justify-content-between'>"
	        html += "<div class='reply_item'>";
		        html += "<div class='user_id'>" + this.user_id + "</div>";
		        html += "<div class='reply_content'>" + this.comm_reply_content + "</div>";
		        html += "<div class='comm_reply_writen_date'>" + this.comm_reply_writen_date + "</div>";        
        	html += "</div>";
        	html += "<div class='btns'>";
		        //html += "<div><input type='button' class ='reReply' value='대댓글작성' comm_reply_seq='"+this.comm_reply_seq+"'></div>";
		        html += "<div><button type='button' class ='reReply' value='"+this.comm_reply_seq+"'>대댓글작성</button></div>";
		        html += "<div><button type='button' value='"+this.comm_reply_seq+"' class='mx-3'>삭제</button></div>";
		    html += "</div>";		    	
        html += "</div>";
   		html += "<hr id='hr" + this.comm_reply_seq + "'/>";	
      });
	
      $("#replyList").append(html);
    }
  });
}
  getList();
  
  
  //버튼 누르면 댓글 추가 // 댓글 입력하는 사람 임의로 넣어놓음 
  $('#reply_btn').on('click',function(){
	  console.log($("#comment").val());
	 let requestdata = {
		  "user_id" : "shs1994", 
		  "comm_reply_content" : $("#comment").val(),
		  "comm_seq" : ${detail.comm_seq},
		  
	  }
	 console.log("이거타? "+requestdata);
	  let data = JSON.stringify(requestdata);
	  console.log(data);
	  $.ajax({
		  type: "post",
		  url: "/sspl_finance/restcommunity/replyInsert",
		  data: data,
		  dataType: "json",
		  contentType: "application/json; charset=utf-8",
		  success: function(data) {
		      console.log("들어옴!!!");
		      console.log(data);
		      getList();
		      
		      
		    }
	  })
  });
    //대댓글 작성
    $(document).on("click","button[class='reReply']",function(){
	  let comm_reply_seq = $(this).val();
	  console.log(comm_reply_seq);
	  console.log("여긴오냐");
	  let html = "";
// 	  html += "<div class='d-flex flex-row'>";
	  html += "<input type='text' placeholder='내용을 입력해주세요' id ='comm_reply_content' class ='w-75'/>";
	  html += "<div class ='w-25 row'><button type='button' class ='reReplyComplete col-5' value='"+this.comm_reply_seq+"'>작성완료</button>";
	  html += "<button type='button' value='"+this.comm_reply_seq+"' class='col-5'>취소</button></div>";
	  html += "</div>";
	  $('#hr'+comm_reply_seq).before(html);
	   
	  });
	  
    $(document).on("click","button[class='reReplyComplete']",function(){
    	
    	let data ={
    		"comm_reply_content" : 	$("#comm_reply_content").val(), //내용
    		"comm_reply_seq": $(this).val(), //기존댓글의 seq
    		"user_id" : "shs1991", // 댓글작성자
    	}
 		console.log(data.toString());
    	$.ajax({
  		  type: "post",
  		  url: "/sspl_finance/restcommunity/reReplyInsert",
  		  data: data,
  		  dataType: "json",
  		  contentType: "application/json; charset=utf-8",
  		  success: function(data) {
  		      console.log("대댓글 작성 됏유");
  		      console.log(data);
  		      getList();
  		    }
  	  })
    	
    })
    
 
  });

  
  
  

</script>
</html>