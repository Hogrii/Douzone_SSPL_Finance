<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
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
        <link
            href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
            rel="stylesheet"
        />
        <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

        <title>문의게시판(글수정)</title>
        <style>
            * {
                box-sizing: border-box;
                padding: 0px;
                margin: 0px;
            }
            hr {
                color: black;
                border-width: 0.125em;
            }
        </style>
    </head>
    <body>
        <!-- header 영역 -->
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
        <!-- content 영역 -->
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <form action="#">
                        <hr />
                        <div class="d-flex flex-row mb-2">
                            <label for="id" class="form-label col-md-2"
                                ><span class="text-danger">*</span>아이디</label
                            >
                            <p>난_민아라고해</p>
                        </div>
                        <hr />
                        <div class="d-flex flex-row mb-2">
                            <label for="title" class="form-label col-md-2"
                                ><span class="text-danger">*</span>제목</label
                            >
                            <input
                                type="text"
                                class="form-control"
                                id="title"
                                placeholder="제목을 입력하세요"
                                value="문의드립니다."
                            />
                        </div>
                        <hr />
                        <div class="d-flex flex-row mb-2">
                            <label for="category" class="form-label col-md-2"
                                ><span class="text-danger">*</span
                                >카테고리</label
                            >
                            <select
                                class="form-select form-control"
                                id="category"
                            >
                                <option value="시세">시세</option>
                                <option value="환율">환율</option>
                                <option value="매수">매수</option>
                                <option value="매도" selected>매도</option>
                            </select>
                        </div>
                        <hr />
                        <div class="d-flex flex-row mb-2">
                            <label for="content" class="form-label col-md-2"
                                ><span class="text-danger">*</span>내용</label
                            >
                            <div class="col-md-10">
                                <div id="summernote">10월 3일 휴강인가요?</div>
                            </div>
                        </div>
                        <div class="row">
                            <div
                                class="d-grid gap-4 d-md-flex justify-content-md-end"
                            >
                                <input
                                    type="submit"
                                    class="btn btn-secondary"
                                    value="수정"
                                />
                                <input
                                    type="button"
                                    class="btn btn-secondary"
                                    value="취소"
                                />
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- footer 영역 -->
    </body>
    <script src="${pageContext.request.contextPath}/resources/js/summernote.js"></script>
</html>
