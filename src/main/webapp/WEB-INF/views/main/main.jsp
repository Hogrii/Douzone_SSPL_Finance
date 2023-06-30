<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
<title>메인페이지(mainpage)</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
.chart {
	width: 400px;
	height: 150px;
	margin: 10px auto;
	display: flex;
}

#myChart1 {
	border: 1px solid red;
	flex: 1;
	margin: 0px 5%;
	width: 30%;
	box-sizing: border-box;
}

#myChart2 {
	border: 1px solid green;
	flex: 1;
	margin: 0px 5%;
	width: 30%;
	box-sizing: border-box;
}

#myChart3 {
	border: 1px solid blue;
	flex: 1;
	width: 30%;
	box-sizing: border-box;
}

.mainboard {
	width: 100%;
	margin: 10px auto;
	display: flex;
}

#board1 {
	flex: 1;
	margin: 0px 5%;
	width: 50%;
	box-sizing: border-box;
}

#board2 {
	flex: 1;
	margin: 0px 5%;
	width: 50%;
	box-sizing: border-box;
}

#moveTopBtn {
	position: fixed;
	bottom: 1rem;
	right: 1rem;
	width: 4rem;
	height: 4rem;
}
</style>
</head>
<body>
	<!-- header 영역 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	<!-- content 영역 -->
	<main class="container my-5">
		<div class="d-flex justify-content-end">
			<!-- 검색목록 페이지 이동 (8번)-->
			<form action="#" method="post">
				<div class="input-group mb-3">
					<input type="text" class="form-control"
						placeholder="종목명 또는 종목코드 검색" /> <a
						href="${pageContext.request.contextPath}/search/searchList.do">
						<button type="button" class="btn btn-secondary">검색</button>
					</a>
				</div>
			</form>
		</div>
		<div class="py-3 py-md-3">즐겨찾기</div>
		<hr class="my-2 gy-5" />
		<div class="py-3 py-md-3">
			<div class="d-flex flex-row mb-3 gy-5">
				<div class="chart">
					<canvas id="myChart1"></canvas>
				</div>
				<div class="chart">
					<canvas id="myChart2"></canvas>
				</div>
				<div class="chart">
					<canvas id="myChart3"></canvas>
				</div>
			</div>
		</div>
		<div class="py-3 py-md-3">인기검색</div>
		<hr class="my-2 gy-5" />
		<div class="py-3 py-md-3">
			<div class="col-md-12">
				<table class="table text-center">
					<thead class="bg-secondary text-dark bg-opacity-25">
						<tr>
							<th>종목명</th>
							<th>공백</th>
							<th>현재가</th>
							<th>등락률</th>
							<th>시가총액</th>
							<th>거래량</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>에코프로</td>
							<td>공백</td>
							<td><a href="#"><box-icon
										name="lock" type="solid"></box-icon>&nbsp;72,700</a>
							</td>
							<td>32.5%</td>
							<td>5,000,000</td>
							<td>1,000,000</td>
						</tr>
						<tr>
							<td>하나기술</td>
							<td>공백</td>
							<td><a href="#"><box-icon
										name="lock" type="solid"></box-icon>&nbsp;72,700</a>
							</td>
							<td>32.5%</td>
							<td>5,000,000</td>
							<td>1,000,000</td>
							<td></td>
						</tr>
						<tr>
							<td>삼성전자</td>
							<td>공백</td>
							<td><a href="#"><box-icon
										name="lock" type="solid"></box-icon>&nbsp;72,700</a>
							</td>
							<td>32.5%</td>
							<td>5,000,000</td>
							<td>1,000,000</td>
						</tr>
						<tr>
							<td>삼부토건</td>
							<td>공백</td>
							<td><a href="#"><box-icon
										name="lock" type="solid"></box-icon>&nbsp;72,700</a>
							</td>
							<td>32.5%</td>
							<td>5,000,000</td>
							<td>1,000,000</td>
						</tr>
						<tr>
							<td>한국전력</td>
							<td>공백</td>
							<td><a href="#"><box-icon
										name="lock" type="solid"></box-icon>&nbsp;72,700</a>
							</td>
							<td>32.5%</td>
							<td>5,000,000</td>
							<td>1,000,000</td>
						</tr>
						<tr>
							<td>삼부토건</td>
							<td>공백</td>
							<td><a href="#"><box-icon
										name="lock" type="solid"></box-icon>&nbsp;72,700</a>
							</td>
							<td>32.5%</td>
							<td>5,000,000</td>
							<td>1,000,000</td>
						</tr>
						<tr>
							<td>에코프로비엠</td>
							<td>공백</td>
							<td><a href="#"><box-icon
										name="lock" type="solid"></box-icon>&nbsp;72,700</a>
							</td>
							<td>32.5%</td>
							<td>5,000,000</td>
							<td>1,000,000</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="py-3 py-md-3">실시간 등락률</div>
		<div class="py-3 py-md-3">국내 해외</div>

		<div class="py-3 py-md-3">
			<hr class="my-2 gy-5" />
		</div>
		<div class="py-3 py-md-3">
			<div class="col-md-12">
				<table class="table text-center">
					<thead class="bg-secondary text-dark bg-opacity-25">
						<tr>
							<th>종목명</th>
							<th>공백</th>
							<th>현재가</th>
							<th>등락률</th>
							<th>시가총액</th>
							<th>거래량</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>에코프로</td>
							<td>공백</td>
							<td><a href="#"><box-icon
										name="lock" type="solid"></box-icon>&nbsp;72,700</a>
							</td>
							<td>32.5%</td>
							<td>5,000,000</td>
							<td>1,000,000</td>
						</tr>
						<tr>
							<td>하나기술</td>
							<td>공백</td>
							<td><a href="#"><box-icon
										name="lock" type="solid"></box-icon>&nbsp;72,700</a>
							</td>
							<td>32.5%</td>
							<td>5,000,000</td>
							<td>1,000,000</td>
							<td></td>
						</tr>
						<tr>
							<td>삼성전자</td>
							<td>공백</td>
							<td><a href="#"><box-icon
										name="lock" type="solid"></box-icon>&nbsp;72,700</a>
							</td>
							<td>32.5%</td>
							<td>5,000,000</td>
							<td>1,000,000</td>
						</tr>
						<tr>
							<td>삼부토건</td>
							<td>공백</td>
							<td><a href="#"><box-icon
										name="lock" type="solid"></box-icon>&nbsp;72,700</a>
							</td>
							<td>32.5%</td>
							<td>5,000,000</td>
							<td>1,000,000</td>
						</tr>
						<tr>
							<td>한국전력</td>
							<td>공백</td>
							<td><a href="#"><box-icon
										name="lock" type="solid"></box-icon>&nbsp;72,700</a>
							</td>
							<td>32.5%</td>
							<td>5,000,000</td>
							<td>1,000,000</td>
						</tr>
						<tr>
							<td>삼부토건</td>
							<td>공백</td>
							<td><a href="#"><box-icon
										name="lock" type="solid"></box-icon>&nbsp;72,700</a>
							</td>
							<td>32.5%</td>
							<td>5,000,000</td>
							<td>1,000,000</td>
						</tr>
						<tr>
							<td>에코프로비엠</td>
							<td>공백</td>
							<td><a href="#"><box-icon
										name="lock" type="solid"></box-icon>&nbsp;72,700</a>
							</td>
							<td>32.5%</td>
							<td>5,000,000</td>
							<td>1,000,000</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="py-3 py-md-3">
			<div class="py-3 py-md-3">실시간 인기랭킹</div>
			<div class="py-3 py-md-3">국내 해외</div>

			<hr class="my-2 gy-7" />
			<div class="py-3 py-md-3">
				<div class="col-md-12">
					<table class="table text-center">
						<thead class="bg-secondary text-dark bg-opacity-25">
							<tr>
								<th>종목명</th>
								<th>공백</th>
								<th>현재가</th>
								<th>등락률</th>
								<th>시가총액</th>
								<th>거래량</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>에코프로</td>
								<td>공백</td>
								<td><a href="#"><box-icon
											name="lock" type="solid"></box-icon>&nbsp;72,700</a>
								</td>
								<td>32.5%</td>
								<td>5,000,000</td>
								<td>1,000,000</td>
							</tr>
							<tr>
								<td>하나기술</td>
								<td>공백</td>
								<td><a href="#"><box-icon
											name="lock" type="solid"></box-icon>&nbsp;72,700</a>
								</td>
								<td>32.5%</td>
								<td>5,000,000</td>
								<td>1,000,000</td>
								<td></td>
							</tr>
							<tr>
								<td>삼성전자</td>
								<td>공백</td>
								<td><a href="#"><box-icon
											name="lock" type="solid"></box-icon>&nbsp;72,700</a>
								</td>
								<td>32.5%</td>
								<td>5,000,000</td>
								<td>1,000,000</td>
							</tr>
							<tr>
								<td>삼부토건</td>
								<td>공백</td>
								<td><a href="#"><box-icon
											name="lock" type="solid"></box-icon>&nbsp;72,700</a>
								</td>
								<td>32.5%</td>
								<td>5,000,000</td>
								<td>1,000,000</td>
							</tr>
							<tr>
								<td>한국전력</td>
								<td>공백</td>
								<td><a href="#"><box-icon
											name="lock" type="solid"></box-icon>&nbsp;72,700</a>
								</td>
								<td>32.5%</td>
								<td>5,000,000</td>
								<td>1,000,000</td>
							</tr>
							<tr>
								<td>삼부토건</td>
								<td>공백</td>
								<td><a href="#"><box-icon
											name="lock" type="solid"></box-icon>&nbsp;72,700</a>
								</td>
								<td>32.5%</td>
								<td>5,000,000</td>
								<td>1,000,000</td>
							</tr>
							<tr>
								<td>에코프로비엠</td>
								<td>공백</td>
								<td><a href="#"><box-icon
											name="lock" type="solid"></box-icon>&nbsp;72,700</a>
								</td>
								<td>32.5%</td>
								<td>5,000,000</td>
								<td>1,000,000</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="mainboard">
			<div id="board1">
				<div class="py-3 py-md-3">커뮤니티</div>
				<ul class="list-group list-group-flush">
					<li class="list-group-item">1. An item</li>
					<li class="list-group-item">2. second item</li>
					<li class="list-group-item">3. third item</li>
					<li class="list-group-item">4. fourth item</li>
					<li class="list-group-item">5. And a fifth one</li>
				</ul>
			</div>
			<div id="board2">
				<div class="py-3 py-md-3">문의</div>
				<ul class="list-group list-group-flush">
					<li class="list-group-item">1. An item</li>
					<li class="list-group-item">2. second item</li>
					<li class="list-group-item">3. third item</li>
					<li class="list-group-item">4. fourth item</li>
					<li class="list-group-item">5. And a fifth one</li>
				</ul>
			</div>
			<div class="py-3 py-md-3"></div>
		</div>
	</main>
	<a id="moveTopBtn"><img
		src="${pageContext.request.contextPath}/resources/img/topbutton.png"
		style="width: 38px; height: 38px" /></a>
	<!-- footer 영역 -->
</body>
<script>
        var ctx = document.getElementById("myChart1").getContext("2d");
        var data = [
            ["2023-06-14", 72700],
            ["2023-06-15", 71500],
            ["2023-06-16", 71800],
            ["2023-06-17", 71200],
            ["2023-06-18", 71400],
            ["2023-06-19", 70500],
            ["2023-06-20", 71300],
            ["2023-06-21", 71600],
            ["2023-06-22", 72500],
            ["2023-06-23", 72600],
            ["2023-06-24", 72700],
        ];
        var lineChart = new Chart(ctx, {
            type: "line",
            data: {
                labels: data.map(function (x) {
                    return x[0];
                }),
                datasets: [
                    {
                        data: data.map(function (x) {
                            return x[1];
                        }),
                        borderColor: "blue",
                        borderWidth: 2,
                    },
                ],
            },
            options: {
                title: {
                    text: "Samsung Electronics Stock Price",
                },
                legend: {
                    display: false,
                },
                xAxis: {
                    title: {
                        text: "Date",
                    },
                },
                yAxis: {
                    title: {
                        text: "Price (won)",
                    },
                },
            },
        });
    </script>
<script>
        var ctx = document.getElementById("myChart2").getContext("2d");
        var data = [
            ["2023-06-14", 72700],
            ["2023-06-15", 71500],
            ["2023-06-16", 71800],
            ["2023-06-17", 71200],
            ["2023-06-18", 71400],
            ["2023-06-19", 70500],
            ["2023-06-20", 71300],
            ["2023-06-21", 71600],
            ["2023-06-22", 72500],
            ["2023-06-23", 72600],
            ["2023-06-24", 72700],
        ];
        var lineChart = new Chart(ctx, {
            type: "line",
            data: {
                labels: data.map(function (x) {
                    return x[0];
                }),
                datasets: [
                    {
                        data: data.map(function (x) {
                            return x[1];
                        }),
                        borderColor: "blue",
                        borderWidth: 2,
                    },
                ],
            },
            options: {
                title: {
                    text: "Samsung Electronics Stock Price",
                },
                legend: {
                    display: false,
                },
                xAxis: {
                    title: {
                        text: "Date",
                    },
                },
                yAxis: {
                    title: {
                        text: "Price (won)",
                    },
                },
            },
        });
    </script>
<script>
        var ctx = document.getElementById("myChart3").getContext("2d");
        var data = [
            ["2023-06-14", 72700],
            ["2023-06-15", 71500],
            ["2023-06-16", 71800],
            ["2023-06-17", 71200],
            ["2023-06-18", 71400],
            ["2023-06-19", 70500],
            ["2023-06-20", 71300],
            ["2023-06-21", 71600],
            ["2023-06-22", 72500],
            ["2023-06-23", 72600],
            ["2023-06-24", 72700],
        ];
        var lineChart = new Chart(ctx, {
            type: "line",
            data: {
                labels: data.map(function (x) {
                    return x[0];
                }),
                datasets: [
                    {
                        data: data.map(function (x) {
                            return x[1];
                        }),
                        borderColor: "blue",
                        borderWidth: 2,
                    },
                ],
            },
            options: {
                title: {
                    text: "Samsung Electronics Stock Price",
                },
                legend: {
                    display: false,
                },
                xAxis: {
                    title: {
                        text: "Date",
                    },
                },
                yAxis: {
                    title: {
                        text: "Price (won)",
                    },
                },
            },
        });
        const $topBtn = document.querySelector("#moveTopBtn");

        // 버튼 클릭 시 맨 위로 이동
        $topBtn.onclick = () => {
            window.scrollTo({ top: 0, behavior: "smooth" });
        };
    </script>
</html>
