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

		<!--  댓글 리스트 조회 -->
		<div class="replyContentBox">
			<div class="replyContent">
				<hr />
				<div id="replyList"></div>
				<hr />

			</div>
		</div>
		<!--  댓글 리스트 조회 끝 -->

		<!-- 댓글 입력 -->
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

<script>
$(function(){

	 //전체 댓글
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
		    	html += "<div class='d-flex justify-content-between' id='reply"+this.comm_reply_seq+"'>"
				    html += "<div class='reply_item'>";
						html += "<div class='user_id'>" + this.user_id + "</div>";
						html += "<div id='comm_reply_seq'>"+ "댓글번호 :" +this.comm_reply_seq+"</div>";
						html += "<div class='reply_content'>" + this.comm_reply_content + "</div>";
						html += "<div class='comm_reply_writen_date'>" + this.comm_reply_writen_date + "</div>";        
			        html += "</div>";
				        html += "<div class='btns'>";
						html += "<div><button type='button' class ='reReply' value='"+this.comm_reply_seq+"'>대댓글작성</button></div>";
						html += "<div><button type='button' value='"+this.comm_reply_seq+"' class='replydelete mx-3'>삭제</button></div>";
					html += "</div>";		    	
		        html += "</div>";
		   		html += "<hr id='hr" + this.comm_reply_seq + "'/>";	
		      $("#replyList").append(html);
		      getReRepyList(this.comm_reply_seq);//대댓글 조회 
	      });
		}
	  });
	} //댓글 조회 끝
	
	
	    //대댓글 조회
	    function getReRepyList(comm_reply_seq){
	  	  $.ajax({
	  	    type: "get",
	  	    url: "/sspl_finance/restcommunity/reReplySelect/" + ${detail.comm_seq},
	  	    contentType: "application/json; charset=utf-8",
	  	    
	  	    success: function(data) {
	  	      //$("#replyList").empty();
	  	      let html = "";
	  	      
	  	      if(data.length< 1){
	  	    	html = "등록된 댓글이 없습니다.";
	  	      }else{
	  	    	  let i =0;
	  	      $.each(data, function() {
	  	    	  let reply_seq = data[i++].refer;
	  	    	  if(comm_reply_seq == reply_seq){
	  	    		console.log("comm_reply_seq :" + comm_reply_seq);
	  	    		console.log("reply_seq :" + reply_seq);
	  	    	  	
		  		  $('#rereply'+reply_seq).empty();
	  	    	  console.log("reply_seq : " + reply_seq);
	  	    	  html+="<div id='rereply'" + reply_seq + ">"
		  	    	html += "<div class='d-flex justify-content-between '>"
			  		    html += "<div class='reply_item ms-3'>";
				  			html += "<div class='user_id'>" + this.user_id + "</div>";
				  			html += "<div id='comm_reply_seq'>"+ "댓글번호 :" +this.comm_reply_seq+"</div>";
				  			html += "<div class='reply_content'>" + this.comm_reply_content + "</div>";
				  			html += "<div class='comm_reply_writen_date'>" + this.comm_reply_writen_date + "</div>";        
			  	        html += "</div>";
			  	        html += "<div class='btns'>";
				  			html += "<div><button type='button' value='"+this.comm_reply_seq+"' class='replydelete mx-3'>삭제</button></div>";
			  			html += "</div>";		    	
		  	        html += "</div>";
		  	   		html += "<hr id='hr" + this.comm_reply_seq + "'/>";
		  	   		html += "<br>";
		  	   	html+="</div>";
		  	      $("#reply"+reply_seq).after(html);
	  	    	  }
	  	      });
	  	      }
	  		}
	  	  });
	  	} //댓글 조회 끝


	   getList(); //댓글조회
	   
	  
	  //버튼 누르면 댓글 추가 
	  $('#reply_btn').on('click',function(){
		  console.log("코맨트??????"+$("#comment").val());
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
			      console.log(data.comm_reply_seq);
			      getList();
			      //getReRepyList();
			    }
		  })
	  }); //댓글 추가 끝
 
	    //대댓글 작성버튼
	    $(document).on("click","button[class='reReply']",function(){
			  let comm_reply_seq = $(this).val(); //댓글의 seq번호 (이 번호에 대해 대댓글 달아야 함 )
			  let html = "";
	//	 	  html += "<div class='d-flex flex-row'>";
			  html += "<input type='text' placeholder='내용을 입력해주세요' id ='comm_reply_content' class ='w-75'/>";
			  html += "<div class ='w-25 row'><button type='button' class ='reReplyComplete col-5' comm_reply_seq='"+comm_reply_seq+"'>작성완료</button>";
			  html += "<button type='button' value='"+this.comm_reply_seq+"' class='col-5'>취소</button></div>";
			  html += "</div>";
		  $('#hr'+comm_reply_seq).before(html);
		  }); //대댓글 작성 완료 끝 
		
		//대댓글완료버튼 
	    $(document).on("click","button[class='reReplyComplete col-5']",function(){
	    	//console.log("제발 :" +$(this).attr("comm_reply_seq"));
	    	let data ={
	    		"comm_reply_content" : 	$("#comm_reply_content").val(), //내용
	    		"comm_reply_seq": $(this).attr("comm_reply_seq"), //기존댓글의 seq
	    		"user_id" : "shs1991", // 댓글작성자
	    	}
	    	
	    	let data2 = JSON.stringify(data);
 
	    	$.ajax({
	  		  type: "post",
	  		  url: "/sspl_finance/restcommunity/reReplyInsert",
	  		  data: data2,
	  		  dataType: "json",
	  		  contentType: "application/json; charset=utf-8",
	  		  success: function(data) {
	  		      console.log("대댓글 작성 됏유");
	  		      console.log(data);
	  		      getList();
	  		      //getReRepyList();
	  		    }
	  	  });
	    }); // 작성완료 끝 
	    
	    //댓글 삭제 
	    $(document).on("click","button[class='replydelete mx-3']",function(){<!--delete ajax!-->
	    	console.log("여기와??????????????????");   
	    	let comm_reply_seq = $(this).val();
	    	 
		  	$.ajax({
		  		url: "/sspl_finance/restcommunity/replyDelete/"+comm_reply_seq,
		  		type : 'get',
		  		data: comm_reply_seq,
		  		dataType: "json",
		  		success: function(result){
		  			console.log("댓글 삭제완료");
		  			 getList();
		  			// getReRepyList();
		  		}
		  		, error: function(error){
		  			console.log("에러 : " + error);
		  		}
		  		});
	  		});
	 
	  });
</script>

</html>