<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="se"
	uri="http://www.springframework.org/security/tags"%>
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
	<se:authentication property="name" var="LoginUser" />
	<input id="login_id" type="hidden" value="${LoginUser}">
	<div class="container my-5">
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

		<!--  댓글 리스트 조회 -->
		<div class="replyContentBox">
			<div class="replyContent">
				<hr />
				<div id="replyList"></div>
			</div>
		</div>
		<!--  댓글 리스트 조회 끝 -->

		<!-- 댓글 입력 -->
		<form id="replyForm" name="replyForm">
			<table class="table" style="width: 100%"">
				<tr>
					<td><textarea class="w-100" rows="3" id="comment"
							name="comment" placeholder="댓글을 입력하세요"></textarea><br>
						<div>
							<button type="button" class="btn btn-secondary" id="reply_btn">등록</button>
						</div></td>
				</tr>
			</table>
		</form>

		<!-- 목록, 수정, 삭제 버튼 시작 -->
		<div class="btns d-flex justify-content-between">
			<div class="listBtn">
				<button type="button" class="btn btn-secondary"
					onclick="location.href='list.do?cp=${cp}&ps=${ps}'">목록</button>
			</div>
			<c:choose>
				<c:when test="${LoginUser == detail.user_id}">
					<!-- Result값이 있다면 실행할 로직 -->
					<div id="otherBtns">
						<button type="submit" class="btn btn-secondary"
							onclick="location.href='modify.do?comm_seq=${detail.comm_seq}&cp=${cpage}&ps=${pagesize}'">수정</button>
						<button type="button" class="btn btn-secondary"
							onclick="location.href='delete.do?comm_seq=${detail.comm_seq}'">삭제</button>
					</div>
				</c:when>
				<c:otherwise>
					<div id="otherBtns" style="display: none">
						<button type="submit" class="btn btn-secondary"
							onclick="location.href='modify.do?comm_seq=${detail.comm_seq}&cp=${cpage}&ps=${pagesize}'">수정</button>
						<button type="button" class="btn btn-secondary"
							onclick="location.href='delete.do?comm_seq=${detail.comm_seq}'">삭제</button>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
		<!-- 목록, 수정, 삭제 버튼 끝 -->
	</div>
	<!-- footer 영역 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>

<script>
$(function(){

	
	 //전체 댓글
	  function getList(){
	  $.ajax({
	    type: "get",
	    url: "replySelect/" + ${detail.comm_seq},
	    contentType: "application/json; charset=utf-8",

	    success: function(data) {
	      $("#replyList").empty();
			
	      let i =0;
	      $.each(data, function() {
	    	  
	    	  let html = "";
	    	  
	    	  if(data[i++].depth==1){//대댓글 조회 (들여쓰기)
		    	  html += "<div class='d-flex justify-content-between' id='reply"+this.comm_reply_seq+"' style='margin-left:50px'>"
		    	  html += "<div class='reply_item'>";
				  html += "<div class='user_id'>" + this.user_id + "</div>";
				  html += "<div class='reply_content'>" + this.comm_reply_content + "</div>";
				  html += "<div class='comm_reply_writen_date'>" + this.comm_reply_writen_date + "</div>";        
			      html += "</div>";
				  html += "<div class='btns'>";
				  if("${LoginUser}" == this.user_id )
			      	html += "<div><button type ='button' value='"+this.comm_reply_seq+"' class='replydelete mx-3 btn btn-secondary'>삭제</button></div>";
			      else
			    	html += "<div><button type ='button' style='display:none' value='"+this.comm_reply_seq+"' class='replydelete mx-3 btn btn-secondary'>삭제</button></div>";	
					html += "</div>";		    	
		          	html += "</div>";
	    	  }else{// 댓
				  html += "<div class='d-flex justify-content-between' id='reply"+this.comm_reply_seq+"'>"
				  html += "<div class='reply_item'>";
				  html += "<div class='user_id'>" + this.user_id + "</div>";
				  html += "<div class='reply_content'>" + this.comm_reply_content + "</div>";
				  html += "<div class='comm_reply_writen_date'>" + this.comm_reply_writen_date + "</div>";        
				  html += "</div>";
				  html += "<div class='btns'>";
				  html += "<div><button type='button' class ='reReply btn btn-secondary' value='"+this.comm_reply_seq+"'>대댓글작성</button></div>";
				  if("${LoginUser}" == this.user_id )
				  	html += "<div><button type ='button' value='"+this.comm_reply_seq+"' class='replydelete mx-3 btn btn-secondary'>삭제</button></div>";
				  else
					  html += "<div><button type ='button' style='display:none' value='"+this.comm_reply_seq+"' class='replydelete mx-3 btn btn-secondary'>삭제</button></div>";
					  html += "</div>";		    	
				      html += "</div>";
		      	  console.log(html);
	    	  }
		   		html += "<hr id='hr" + this.comm_reply_seq + "'/>";	
		      $("#replyList").append(html);
	      });
		}
	  });
	} //댓글 조회 끝

	   getList(); //댓글조회
	   
	  //버튼 누르면 댓글 추가 
	  $('#reply_btn').on('click',function(){
		  console.log("코맨트??????"+$("#comment").val());
		 let requestdata = {
			  "user_id" : "${LoginUser}", 
			  "comm_reply_content" : $("#comment").val(),
			  "comm_seq" : ${detail.comm_seq},
			  
		  }
		 console.log("이거타? "+requestdata);
		  let data = JSON.stringify(requestdata);
		  console.log(data);
		  $.ajax({
			  type: "post",
			  url: "replyInsert",
			  data: data,
			  dataType: "json",
			  contentType: "application/json; charset=utf-8",
			  success: function(data) {
			      console.log("들어옴!!!");
			      console.log(data);
			      console.log(data.comm_reply_seq);
			      getList();
			      $('#comment').val("");
			      $('#comment').focus();
			      //getReRepyList();
			    }
		  })
	  }); //댓글 추가 끝
 
	    //대댓글 작성버튼
	    $(document).on("click","button[class='reReply btn btn-secondary']",function(){
			  let comm_reply_seq = $(this).val(); //댓글의 seq번호 (이 번호에 대해 대댓글 달아야 함 )
			  let html = "";
		 	  html += "<div class='d-flex flex-row justify-content-between align-items-center'>";
			  html += "<input type='text' placeholder='내용을 입력해주세요' id ='comm_reply_content' class ='w-75'/>";
			  html += "<div class='w-25 row'><button type='button' class ='reReplyComplete col-5 m-2 btn btn-sm btn-secondary text-white' comm_reply_seq='"+comm_reply_seq+"'>작성완료</button>";
			  html += "<button type='button' value='"+this.comm_reply_seq+"' class='col-5 m-2 btn btn-sm btn-secondary text-white'>취소</button></div>";
			  html += "</div>";
		  $('#hr'+comm_reply_seq).before(html);
		  }); //대댓글 작성 완료 끝 
		
		//대댓글완료버튼 
	    $(document).on("click","button[class='reReplyComplete col-5 m-2 btn btn-sm btn-secondary text-white']",function(){
	    	//console.log("제발 :" +$(this).attr("comm_reply_seq"));
	    	let data ={
	    		"comm_reply_content" : 	$("#comm_reply_content").val(), //내용
	    		"comm_reply_seq": $(this).attr("comm_reply_seq"), //기존댓글의 seq
	    		"user_id" : "${LoginUser}", // 댓글작성자
	    	}
	    	
	    	let data2 = JSON.stringify(data);
 
	    	$.ajax({
	  		  type: "post",
	  		  url: "reReplyInsert",
	  		  data: data2,
	  		  dataType: "json",
	  		  contentType: "application/json; charset=utf-8",
	  		  success: function(data) {
	  		      console.log("대댓글 작성 됏유");
	  		      console.log(data);
	  		      getList();
	  		    }
	  	  });
	    }); // 작성완료 끝 
	    
	    //댓글 삭제 
	    $(document).on("click","button[class='replydelete mx-3 btn btn-secondary']",function(){<!--delete ajax!-->
	    	let comm_reply_seq = $(this).val();
		  	$.ajax({
		  		url: "replyDelete/"+comm_reply_seq,
		  		type : 'get',
		  		data: comm_reply_seq,
		  		dataType: "json",
		  		success: function(result){
		  			console.log("댓글 삭제완료");
		  			 getList();
		  		}
		  		, error: function(error){
		  			console.log("에러 : " + error);
		  		}
		  		});
	  		});
	 
	  });
</script>

</html>