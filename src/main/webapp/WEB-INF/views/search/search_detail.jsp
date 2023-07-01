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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script type="text/javascript">
	$(function() {
		let stock_code = ('000000'+${stock_code}).slice(-6);
		console.log(stock_code);
		//주식 상세 데이터 
		$.ajax({
			url : "searchByCode.do",
			type : "GET",
			data : {
				"stock_code" : stock_code
			},
			dataType : "JSON",
			success : function(data) {
				let tr = "<tr class='text-center'>";
				//현재날짜
				let today = new Date();
				let year = today.getFullYear();
				let month = ('0' + (today.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 1을 더함
				let day = ('0' + today.getDate()).slice(-2);
				tr += "<td>"+ year + "-" + month + "-" + day +"</td>";
				//시가
				let price = parseInt(data.output.stck_prpr).toLocaleString();
				tr += "<td>"+ price +"</td>";
				//전일종가
				let yesterdayLastPrice = parseInt(data.output.stck_prpr) - parseInt(data.output.prdy_vrss.substr(1));
				tr += "<td>"+ yesterdayLastPrice.toLocaleString() +"</td>";
				//최고가
				let high_price = parseInt(data.output.stck_hgpr).toLocaleString();
				tr += "<td class='text-danger'>"+ high_price +"</td>";
				//최저가
				let low_price = parseInt(data.output.stck_lwpr).toLocaleString();
				tr += "<td class='text-primary'>"+ low_price +"</td>";
				//전일 대비 & 전일 대비율
				let gap = parseInt(data.output.prdy_vrss);
				if(gap<0){
					tr += "<td class='text-primary'>▼"+ gap.toLocaleString() +"</td>";					
					tr += "<td class='text-primary'>▼"+ data.output.prdy_ctrt +"%</td>";
				}else {
					tr += "<td class='text-danger'>▲"+ gap.toLocaleString() +"</td>";										
					tr += "<td class='text-danger'>▲"+ data.output.prdy_ctrt +"%</td>";
				}
				//거래량
				let yesterdayVloume = (parseFloat(data.output.prdy_vrss_vol_rate) - 100.0).toFixed(2); //소수 둘째 자리 까지만
				if(yesterdayVloume<0){
					tr += "<td class='text-primary'>▼"+ yesterdayVloume +"%</td>";
				}else {
					tr += "<td class='text-danger'>▲"+ yesterdayVloume +"%</td>";
				}
				$('#day_tbody').append(tr);
			}
			
		});
		//차트 데이터 비동기 요청
		$('.chart_btn').on('click',function() {
			//기간 분류
			let category = $(this).val();
			console.log('기간 분류 : ' + category);
			let today = new Date();
			//종료일 설정
			let end_date;
			let end_year = today.getFullYear();
			let end_month = ('0' + (today.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 1을 더함
			let end_day = ('0' + today.getDate()).slice(-2);
			end_date = end_year + end_month + end_day;
			console.log('종료일 : ' + end_date);
			//시작일 설정
			let start_date;
			if(category === 'D') {
				today.setDate(today.getDate() - 7);
				let start_year = today.getFullYear();
				let start_month = String(today.getMonth() + 1).padStart(2, '0');
				let start_day = String(today.getDate()).padStart(2, '0');

				start_date = start_year + start_month + start_day;
				console.log('시작일 : ' + start_date);
			}else if(category === 'W') {
				today.setMonth(today.getMonth() - 3);
				let start_year = today.getFullYear();
				let start_month = String(today.getMonth() + 1).padStart(2, '0');
				let start_day = String(today.getDate()).padStart(2, '0');

				start_date = start_year + start_month + start_day;
				console.log('시작일 : ' + start_date);
			}else if(category === 'M') {
				today.setMonth(today.getMonth() - 6);
				let start_year = today.getFullYear();
				let start_month = String(today.getMonth() + 1).padStart(2, '0');
				let start_day = String(today.getDate()).padStart(2, '0');

				start_date = start_year + start_month + start_day;
				console.log('시작일 : ' + start_date);
			}else if(category === 'Y') {
				today.setFullYear(today.getFullYear() - 5);
				let start_year = today.getFullYear();
				let start_month = String(today.getMonth() + 1).padStart(2, '0');
				let start_day = String(today.getDate()).padStart(2, '0');

				start_date = start_year + start_month + start_day;
				console.log('시작일 : ' + start_date);
			}
			$.ajax({
				url : "searchForChart.do",
				type : "GET",
				data : {
					"stock_code" : stock_code,
					"category" : category,
					"start_date" : start_date,
					"end_date" : end_date					
				},
				dataType : "JSON",
				success : function(data) {
					console.log(data);
				}
			});
		});
	});
</script>
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
				<tr class="table-secondary text-center">
					<th>날짜</th>
					<th>시가</th>
					<th>전일종가</th>
					<th>최고가</th>
					<th>최저가</th>
					<th>전일 대비</th>
					<th>전일 대비율</th>
					<th>전일 대비 거래량</th>
			</thead>
			<tbody id="day_tbody">
			</tbody>
		</table>
		<div class="row">
			<div class="chart col-md-8">
				<div class="d-grid gap-2 d-md-block">
					<button type="button" class="btn btn-secondary btn-sm chart_btn" value="D"
						style="-bs-btn-padding-y: 0.25rem; - -bs-btn-padding-x: 1rem; - -bs-btn-font-size: 0.75rem;">
						일</button>
					<button type="button" class="btn btn-secondary btn-sm chart_btn" value="W"
						style="-bs-btn-padding-y: 0.25rem; - -bs-btn-padding-x: 1rem; - -bs-btn-font-size: 0.75rem;">
						주</button>
					<button type="button" class="btn btn-secondary btn-sm chart_btn" value="M"
						style="-bs-btn-padding-y: 0.25rem; - -bs-btn-padding-x: 1rem; - -bs-btn-font-size: 0.75rem;">
						월</button>
					<button type="button" class="btn btn-secondary btn-sm chart_btn" value="Y"
						style="-bs-btn-padding-y: 0.25rem; - -bs-btn-padding-x: 1rem; - -bs-btn-font-size: 0.75rem;">
						년</button>
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