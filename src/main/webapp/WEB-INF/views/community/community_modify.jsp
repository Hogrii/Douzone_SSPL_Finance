<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	<!-- 글쓰기 내용 시작 -->
	<div class="editBar py-5">
		<div class="editCategory">
			<select name="" id="">
				<option value="">유형</option>
				<option value="매도">매도</option>
				<option value="매수">매수</option>
				<option value="시세">시세</option>
				<option value="환율">환율</option>
			</select>
		</div>
		<div class="title">
			제목 : <input type="text" placeholder="제목을 입력하세요" />
		</div>
	</div>
	<!-- 글쓰기 내용 끝 -->

	<!-- summernote 시작 -->
	<!-- https://programmer93.tistory.com/27 참고 -->
	<div class="summernote">
		<textarea id="summernote" name="editordata"></textarea>
	</div>
	<!-- summernote 끝 -->

	<!-- 목록, 수정, 삭제 버튼 시작 -->
	<div class="btns">
		<div class="listBtn">
			<button type="button" class="btn btn-secondary" onclick="location.href='list.do'">목록</button>
		</div>
		<div class="otherBtns">
			<button type="button" class="btn btn-secondary" onclick="location.href='detail.do'">완료</button>
			<button type="button" class="btn btn-secondary" onclick="location.href='detail.do'">취소</button>
		</div>
	</div>
	<!-- 목록, 수정, 삭제 버튼 끝 -->

    <script>
        $(document).ready(function () {
            //여기 아래 부분
            $("#summernote").summernote({
                height: 300, // 에디터 높이
                minHeight: 300, // 최소 높이
                maxHeight: null, // 최대 높이
                focus: true, // 에디터 로딩후 포커스를 맞출지 여부
                lang: "ko-KR", // 한글 설정
                toolbar: [
                    // [groupName, [list of button]]
                    ["fontname", ["fontname"]],
                    ["fontsize", ["fontsize"]],
                    [
                        "style",
                        [
                            "bold",
                            "italic",
                            "underline",
                            "strikethrough",
                            "clear",
                        ],
                    ],
                    ["color", ["forecolor", "color"]],
                    ["table", ["table"]],
                    ["para", ["ul", "ol", "paragraph"]],
                    ["height", ["height"]],
                    ["insert", ["picture", "link", "video"]],
                    ["view", ["fullscreen", "help"]],
                ],
                fontNames: [
                    "Arial",
                    "Arial Black",
                    "Comic Sans MS",
                    "Courier New",
                    "맑은 고딕",
                    "궁서",
                    "굴림체",
                    "굴림",
                    "돋움체",
                    "바탕체",
                ],
                fontSizes: [
                    "8",
                    "9",
                    "10",
                    "11",
                    "12",
                    "14",
                    "16",
                    "18",
                    "20",
                    "22",
                    "24",
                    "28",
                    "30",
                    "36",
                    "50",
                    "72",
                ],
                placeholder: "최대 2048자까지 쓸 수 있습니다", //placeholder 설정

                callbacks: {
                    //여기 부분이 이미지를 첨부하는 부분
                    onImageUpload: function (files) {
                        sendFile(files[0], this);
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
                data: form_data,
                type: "POST",
                url: "/companyboard/imageUpload",
                cache: false,
                contentType: false,
                enctype: "multipart/form-data",
                processData: false,
                success: function (sysName) {
                    console.log(sysName + "b");
                    console.log("write에 왔습니다.");
                    $(editor).summernote("insertImage", sysName);
                },
            });
        }
    </script>
</body>
</html>