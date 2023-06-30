<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@ taglib prefix="fn"
uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <!-- bootstrap css-->
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
        />
        <!-- bootstrap js cdn-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- boxicons js cdn -->
        <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
        <!-- jQuery cdn -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>

        <title>커뮤니티게시판</title>
        <style>
            * {
                box-sizing: border-box;
                padding: 0px;
                margin: 0px;
            }

            box-icon {
                vertical-align: -5px;
            }
        </style>
    </head>
    <body>
        <div class="listContainer">
            <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

            <c:set var="pagesize" value="${requestScope.pagesize}" />
            <c:set var="cpage" value="${requestScope.cpage}" />
            <c:set var="pagecount" value="${requestScope.pagecount }" />
            <div class="main py-5">
                <!-- 검색버튼 시작 -->
                <div class="container">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-12 col-md-6">
                                <div
                                    class="form-group d-flex align-items-center"
                                >
                                    <div
                                        class="col-sm-2"
                                        style="padding-left: 0"
                                    >
                                        <!-- action="EmpTable.do?ps=selected" -->
                                        <form name="list">
                                            <select
                                                name="ps"
                                                class="form-control"
                                                onchange="submit()"
                                            >
                                                <c:forEach
                                                    var="i"
                                                    begin="5"
                                                    end="20"
                                                    step="5"
                                                >
                                                    <c:choose>
                                                        <c:when
                                                            test="${pagesize == i }"
                                                        >
                                                            <option
                                                                value="${i}"
                                                                selected
                                                            >
                                                                ${i}
                                                            </option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option
                                                                value="${i}"
                                                            >
                                                                ${i}
                                                            </option>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                            </select>
                                        </form>
                                    </div>
                                    <label for="" style="margin-bottom: 0"
                                        >개씩 보기</label
                                    >
                                </div>
                            </div>
                            <div class="col-sm-12 col-md-6">
                                <div class="d-flex justify-content-end">
                                    <div class="col-sm-4">
                                        <select
                                            id="selectBox"
                                            class="form-control"
                                        >
                                            <option value="제목">제목</option>
                                            <option value="작성자">
                                                작성자
                                            </option>
                                            <option value="글제목">
                                                글제목
                                            </option>
                                        </select>
                                    </div>
                                    <div class="searchText">
                                        <input
                                            type="text"
                                            placeholder="검색어를 입력하세요"
                                        />
                                    </div>
                                    <div class="searchBtn">
                                        <button
                                            type="button"
                                            class="btn btn-secondary"
                                        >
                                            검색
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 검색 버튼 끝 -->

                <!-- 총 게시물 출력 시작 -->
                <div class="totalPostContainer">
                    총 ${requestScope.total}건의 게시물
                </div>
                <!-- 총 게시물 출력 끝 -->

                <!-- 테이블 시작 -->
                <table class="table">
                    <thead class="table-light">
                        <tr>
                            <td>순번</td>
                            <td>카테고리</td>
                            <td>제목</td>
                            <td>글쓴이</td>
                            <td>작성날짜</td>
                            <td>조회수</td>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="list" value="${requestScope.list}" />
                        <c:forEach var="list2" items="${list}">
                            <tr>
                                <td>${list2.comm_seq}</td>
                                <td>${list2.comm_category}</td>
                                <td>
                                    <a href="detail.do">${list2.comm_title}</a>
                                </td>
                                <td>${list2.user_id}</td>
                                <td>${list2.comm_writen_date}</td>
                                <td>${list2.comm_view_count}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <!-- 테이블 끝 -->

                <!-- 글쓰기 버튼 시작 -->
                <div class="writeContainer">
                    <button
                        type="button"
                        class="btn btn-secondary"
                        onclick="location.href='write.do'"
                    >
                        글 작성
                    </button>
                </div>
                <!-- 글쓰기 버튼 끝 -->
                <!-- 페이징 시작 -->
                <div>
                    <nav aria-label="Page navigation example">
                        <ul class="pagination justify-content-center">
                            <c:if test="${cpage>1 }">
                                <li class="page-item">
                                    <a
                                        class="page-link"
                                        href="list.do?cp=${cpage-1}&ps=${pagesize}"
                                        aria-label="Previous"
                                    >
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                            </c:if>
                            <c:forEach
                                var="i"
                                begin="1"
                                end="${pagecount}"
                                step="1"
                            >
                                <c:choose>
                                    <c:when test="${cpage == i}">
                                        <li class="page-item">
                                            <a
                                                href=""
                                                class="page-link"
                                                style="color: blue"
                                                >${i}</a
                                            >
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="page-item">
                                            <a
                                                href="list.do?cp=${i}&ps=${pagesize}"
                                                class="page-link"
                                                >${i}</a
                                            >
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            <!--  <c:if test="${cpage < pagecount}">
               <li class="page-item"><a
                  href="list.do?cp=${cpage+1}&ps=${pagesize}" class="page-link">
                     <i class="fas fa-arrow-right"></i>
               </a></li>
            </c:if>
             -->
                        </ul>
                    </nav>
                </div>
                <!-- 페이징 끝 -->
            </div>
        </div>
    </body>
</html>
