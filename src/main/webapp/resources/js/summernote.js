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