<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <!-- jQuery cdn-->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
        <!-- bootstrap cdn-->
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
        />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- summernote cdn -->
        <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
    	 
<link
	href="${pageContext.request.contextPath }/resources/css/global.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/communityWrite.css"
	rel="stylesheet" type="text/css">
</head>
<!-- 내부에서 세션 체크 필요 -->
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	<!-- 글쓰기 내용 시작 -->

	<form action="writeOk.do" method="post">
		<div class="writeBar py-5">
			<div class="writeCategory">
				<select id ="comm_category" name="comm_category" >
					<option value="">유형</option>
					<option value="매도">매도</option>
					<option value="매수">매수</option>
					<option value="시세">시세</option>
					<option value="환율">환율</option>
				</select>
			</div>
			<div id=comm_title>
				제목 : <input type="text" placeholder="제목을 입력하세요" name="comm_title"/>
			</div>
		</div>
		<!-- 글쓰기 내용 끝 -->
	
		<!-- summernote 시작 -->
		<!-- https://programmer93.tistory.com/27 참고 -->
		<div class="summernote">
			<textarea id="summernote" name="comm_content"></textarea>
		</div>
		<!-- summernote 끝 -->

		<!-- 글쓰기 버튼 시작 -->
		<div class="writeBtns">
			<button type="submit" class="btn btn-secondary"
				onclick="goWrite(this.form)">완료</button>
			<button type="button" class="btn btn-secondary"
				onclick="location.href='list.do'">취소</button>
		</div>
		</form>
		<!-- 글쓰기 버튼 끝 -->


		
</body>
		<script>
			$(document)
					.ready(
							function() {
								//여기 아래 부분
								$("#summernote")
										.summernote(
												{
													height : 300, // 에디터 높이
													minHeight : 300, // 최소 높이
													maxHeight : null, // 최대 높이
													focus : true, // 에디터 로딩후 포커스를 맞출지 여부
													lang : "ko-KR", // 한글 설정
													toolbar : [
															// [groupName, [list of button]]
															[
																	"fontname",
																	[ "fontname" ] ],
															[
																	"fontsize",
																	[ "fontsize" ] ],
															[
																	"style",
																	[
																			"bold",
																			"italic",
																			"underline",
																			"strikethrough",
																			"clear", ], ],
															[
																	"color",
																	[
																			"forecolor",
																			"color" ] ],
															[ "table",
																	[ "table" ] ],
															[
																	"para",
																	[
																			"ul",
																			"ol",
																			"paragraph" ] ],
															[
																	"height",
																	[ "height" ] ],
															[
																	"insert",
																	[
																			"picture",
																			"link",
																			"video" ] ],
															[
																	"view",
																	[
																			"fullscreen",
																			"help" ] ], ],
													fontNames : [ "Arial",
															"Arial Black",
															"Comic Sans MS",
															"Courier New",
															"맑은 고딕", "궁서",
															"굴림체", "굴림", "돋움체",
															"바탕체", ],
													fontSizes : [ "8", "9",
															"10", "11", "12",
															"14", "16", "18",
															"20", "22", "24",
															"28", "30", "36",
															"50", "72", ],
													placeholder : "최대 2048자까지 쓸 수 있습니다", //placeholder 설정

													callbacks : {
														//여기 부분이 이미지를 첨부하는 부분
														onImageUpload : function(
																files) {
															sendFile(files[0],
																	this);
														},
													},
												});
							});

			/**
			 * 이미지 파일 업로드
			 */
			function sendFile(file, editor) {
				var form_data = new FormData();
				form_data.append("file", file);
				$.ajax({
					data : form_data,
					type : "POST",
					url : "/community/image",
					cache : false,
					contentType : false,
					enctype : "multipart/form-data",
					processData : false,
					success : function(sysName) {
						console.log(sysName + "b");
						console.log("write에 왔습니다.");
						$(editor).summernote("insertImage", sysName);
					},
				});
			}
			  
			$("div.note-editable").on('drop',function(e){
		         for(i=0; i< e.originalEvent.dataTransfer.files.length; i++){
		         	uploadSummernoteImageFile(e.originalEvent.dataTransfer.files[i],$("#summernote")[0]);
		         }
		        e.preventDefault();
		   })
		    
		   $('#comm_content').summernote('code', '${board_data.BOARD_CONTENT}');
			function goWrite(frm) {
				let comm_category = frm.comm_category.value;
				let comm_title = frm.comm_title.value;
				let comm_content = frm.comm_content.value;
				
				if (comm_category.trim() == ''){
					alert("카테고리를 입력해주세요");
					return false;
				}
				if (comm_title.trim() == ''){
					alert("제목를 입력해주세요");
					return false;
				}
				if (comm_content.trim() == ''){
					alert("내용을 입력해주세요");
					return false;
				}
				frm.submit();
			}
			
    };
		   
		</script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/summernote.js"></script>
</html>