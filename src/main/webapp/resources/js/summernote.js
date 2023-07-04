$("#summernote").summernote({
    placeholder: "문의 내용을 입력해주세요.",
    tabsize: 2,
    height: 300,
    maxHeight: 300,
    minHeight:300,
    lang: "ko-KR",
    toolbar: [
        ["style", ["style"]],
        [
            "font",
            ["bold", "underline", "clear"],
        ],
        ["color", ["color"]],
        ["para", ["ul", "ol", "paragraph"]],
        ["table", ["table"]],
        [
            "insert",
            ["link", "picture", "video"],
        ],
        [
            "view",
            ["codeview"],
        ],
    ],
});

/**
* 이미지 파일 업로드
*/
function sendFile(file, editor) {
	console.log("파일처리하러왔어요~");
    var form_data = new FormData();
    form_data.append('file', file);
    $.ajax({
        data : form_data,
        type : "POST",
        url : "/qna/qnaImage.do",
        cache : false,
        contentType : false,
        enctype : "multipart/form-data",
        processData : false,
        success : function(sysName) {
            console.log(sysName + "b")
			console.log("write에 왔습니다.")
            $(editor).summernote('insertImage', sysName);
        }
    });
}