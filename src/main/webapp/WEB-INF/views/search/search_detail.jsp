<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>종목검색(상세페이지)</title>
<!-- bootstrap css-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" />
<!-- bootstrap js cdn-->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- jQuery cdn -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
* {
	box-sizing: border-box;
	padding: 0px;
	margin: 0px;
}

#chart_table th {
	background-color: #5e5e5e31;
	border-bottom: 1px solid white;
}
</style>
</head>
<body>
	<!-- header 영역 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<!-- content 영역 -->
	<div class="container my-5">
		<h5>삼성전자</h5>
		<hr class="my-4" />
		<table class="table my-5" id="detail_table">
			<thead>
				<tr class="table-secondary">
					<th>날짜</th>
					<th>시가</th>
					<th>최고가</th>
					<th>최저가</th>
					<th>종가</th>
					<th>전일 대비</th>
					<th>전일 대비율</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>2023-06-29</td>
					<td>73,100</td>
					<td>73,400</td>
					<td>72,800</td>
					<td>72,700</td>
					<td class="text-danger">▲300</td>
					<td class="text-danger">+0.41%</td>
				</tr>
			</tbody>
		</table>
		<div class="row">
			<div class="chart col-md-8">
				<div class="d-grid gap-2 d-md-block">
					<button type="button" class="btn btn-secondary btn-sm"
						style="-bs-btn-padding-y: 0.25rem; - -bs-btn-padding-x: 1rem; - -bs-btn-font-size: 0.75rem;">
						1일</button>
					<button type="button" class="btn btn-secondary btn-sm"
						style="-bs-btn-padding-y: 0.25rem; - -bs-btn-padding-x: 1rem; - -bs-btn-font-size: 0.75rem;">
						1개월</button>
					<button type="button" class="btn btn-secondary btn-sm"
						style="-bs-btn-padding-y: 0.25rem; - -bs-btn-padding-x: 1rem; - -bs-btn-font-size: 0.75rem;">
						3개월</button>
					<button type="button" class="btn btn-secondary btn-sm"
						style="-bs-btn-padding-y: 0.25rem; - -bs-btn-padding-x: 1rem; - -bs-btn-font-size: 0.75rem;">
						1년</button>
				</div>
				<div class="chart">
					<canvas id="myChart"></canvas>
				</div>
			</div>
			<div class="col-md-4">
				<table class="table text-center h-100 align-middle" id="chart_table"
					border="1">
					<tbody>
						<tr>
							<th>연중 최고</th>
							<td>73,400</td>
						</tr>
						<tr>
							<th>연중 최저</th>
							<td>54,500</td>
						</tr>
						<tr>
							<th>자본금(억)</th>
							<td>7,780</td>
						</tr>
						<tr>
							<th>상장주식수(전주)</th>
							<td>5,969,783</td>
						</tr>
						<tr>
							<th>시가총액(백만)</th>
							<td>433,406,213</td>
						</tr>
						<tr>
							<th>외국인보유비중</th>
							<td>52.73%</td>
						</tr>
						<tr>
							<th>PER/EPS</th>
							<td>8.99/8,057</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<!-- footer 영역 -->
</body>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/detail_chart.js"></script>
</html>