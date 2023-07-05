<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="se"
	uri="http://www.springframework.org/security/tags"%>
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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script type="text/javascript">
	$(function() {
		//let stock_code = ('000000000'+${stock_code}).slice(-6);
		let stock_code = $('#stock_code').text();
		//주식 상세 데이터 
		$
				.ajax({
					url : "searchByCode.do",
					type : "GET",
					data : {
						"stock_code" : stock_code
					},
					dataType : "JSON",
					success : function(data) {
						let tr = "<tr class='text-center'>";
						console.log(stock_code);
						//현재날짜
						let today = new Date();
						let year = today.getFullYear();
						let month = ('0' + (today.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 1을 더함
						let day = ('0' + today.getDate()).slice(-2);
						tr += "<td>" + year + "-" + month + "-" + day + "</td>";
						//현재가
						let price = parseInt(data.output.stck_prpr)
								.toLocaleString();
						tr += "<td>" + price + "</td>";
						//전일종가
						let yesterdayLastPrice = parseInt(data.output.stck_prpr)
								- parseInt(data.output.prdy_vrss.substr(1));
						tr += "<td>" + yesterdayLastPrice.toLocaleString()
								+ "</td>";
						//최고가
						let high_price = parseInt(data.output.stck_hgpr)
								.toLocaleString();
						tr += "<td class='text-danger'>" + high_price + "</td>";
						//최저가
						let low_price = parseInt(data.output.stck_lwpr)
								.toLocaleString();
						tr += "<td class='text-primary'>" + low_price + "</td>";
						//전일 대비 & 전일 대비율
						let gap = parseInt(data.output.prdy_vrss);
						if (gap < 0) {
							tr += "<td class='text-primary'>▼"
									+ gap.toLocaleString() + "</td>";
							tr += "<td class='text-primary'>▼"
									+ data.output.prdy_ctrt + "%</td>";
						} else {
							tr += "<td class='text-danger'>▲"
									+ gap.toLocaleString() + "</td>";
							tr += "<td class='text-danger'>▲"
									+ data.output.prdy_ctrt + "%</td>";
						}
						//거래량
						let yesterdayVloume = (parseFloat(data.output.prdy_vrss_vol_rate) - 100.0)
								.toFixed(2); //소수 둘째 자리 까지만
						if (yesterdayVloume < 0) {
							tr += "<td class='text-primary'>▼"
									+ yesterdayVloume + "%</td>";
						} else {
							tr += "<td class='text-danger'>▲" + yesterdayVloume
									+ "%</td>";
						}
						$('#day_tbody').append(tr);
						//연중 최고가
						let highPrice_year = "<td>"
								+ parseInt(data.output.stck_dryy_hgpr)
										.toLocaleString() + "</td>";
						$('#highPrice_year').append(highPrice_year);
						//연중 최저가
						let lowPrice_year = "<td>"
								+ parseInt(data.output.stck_dryy_lwpr)
										.toLocaleString() + "</td>";
						$('#lowPrice_year').append(lowPrice_year);
						//자본금
						let capital = "<td>"
								+ parseInt(data.output.cpfn).toLocaleString()
								+ "</td>";
						$('#capital').append(capital);
						//상장주식수
						let listed_stocks = "<td>"
								+ parseInt(data.output.lstn_stcn)
										.toLocaleString() + "</td>";
						$('#listed_stocks').append(listed_stocks);
						//시가총액
						let market_capitalization = "<td>"
								+ parseInt(data.output.hts_avls)
										.toLocaleString() + "</td>";
						$('#market_capitalization').append(
								market_capitalization);
						//외국인 소진율 hts_frgn_ehrt
						let foreigner_exhaustion_rate = "<td>"
								+ data.output.hts_frgn_ehrt + "%</td>";
						$('#foreigner_exhaustion_rate').append(
								foreigner_exhaustion_rate);
						//PER/EPS per, eps
						let pereps = "<td>" + data.output.per + " / "
								+ data.output.eps + "</td>";
						$('#pereps').append(pereps);
					}

				});
		//차트 데이터 비동기 요청
		$('.chart_btn')
				.on(
						'click',
						function() {
							$('.chart').empty();
							$('.chart')
									.html(
											'<canvas id="myChart" class="w-100 h-100"></canvas>');
							//기간 분류
							let category = $(this).val();
							console.log('기간 분류 : ' + category);
							let today = new Date();
							//종료일 설정
							let end_date;
							let end_year = today.getFullYear();
							let end_month = ('0' + (today.getMonth() + 1))
									.slice(-2); // 월은 0부터 시작하므로 1을 더함
							let end_day = ('0' + today.getDate()).slice(-2);
							end_date = end_year + end_month + end_day;
							console.log('종료일 : ' + end_date);
							//시작일 설정
							let start_date;
							if (category === 'D') {
								today.setDate(today.getDate() - 7);
								let start_year = today.getFullYear();
								let start_month = String(today.getMonth() + 1)
										.padStart(2, '0');
								let start_day = String(today.getDate())
										.padStart(2, '0');

								start_date = start_year + start_month
										+ start_day;
								console.log('시작일 : ' + start_date);
							} else if (category === 'W') {
								today.setMonth(today.getMonth() - 3);
								let start_year = today.getFullYear();
								let start_month = String(today.getMonth() + 1)
										.padStart(2, '0');
								let start_day = String(today.getDate())
										.padStart(2, '0');

								start_date = start_year + start_month
										+ start_day;
								console.log('시작일 : ' + start_date);
							} else if (category === 'M') {
								today.setMonth(today.getMonth() - 6);
								let start_year = today.getFullYear();
								let start_month = String(today.getMonth() + 1)
										.padStart(2, '0');
								let start_day = String(today.getDate())
										.padStart(2, '0');

								start_date = start_year + start_month
										+ start_day;
								console.log('시작일 : ' + start_date);
							} else if (category === 'Y') {
								today.setFullYear(today.getFullYear() - 5);
								let start_year = today.getFullYear();
								let start_month = String(today.getMonth() + 1)
										.padStart(2, '0');
								let start_day = String(today.getDate())
										.padStart(2, '0');

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
					let ctx = document.getElementById("myChart").getContext("2d");
			        let chart_data = [];
			        $.each(data.output2.reverse(), function(index, item) {
			        	  let date = item.stck_bsop_date.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
			        	  let price = item.stck_clpr;
			        	  let each_data = [date, price];
			        	  chart_data.push(each_data);
			        });
			        /*
			        let last_date = end_date.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
			        let last_price = data.output1.stck_prpr;
			        let last_data = [last_date ,last_price];
			        chart_data.push(last_data);
			        */
			        let stock_name = $('#stock_name').text();
			        let lineChart = new Chart(ctx, {
			            type: "line",
			            data: {
			                labels: chart_data.map(function (x) {
			                    return x[0];
			                }),
			                datasets: [
			                    {
			                    	label : stock_name,
			                        data: chart_data.map(function (x) {
			                            return x[1];
			                        }),
			                        borderColor: "blue",
			                        borderWidth: 4,
			                    },
			                ],
			            },
			            options: {
			                title: {
			                    text: "주가 차트",
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
			                    }
			                },animation: {
			                    duration: 1000,  // 애니메이션 지속 시간 (밀리초)
			                    easing: 'easeInOutQuart'  // 애니메이션 속도 곡선
			                }
			            },
			        });
				}
			});
		});
		$('#first_btn').click();
		let user_id = $('#login_id').val();
		//즐겨찾기 버튼
		$('#favorite')
				.on(
						'click',
						function() {
							let lookup_category_num = $('#favorite').val();
							console.log('lookup_category_num : '
									+ lookup_category_num);
							//즐겨찾기 등록
							if (lookup_category_num == 1) {
								$('#favorite').removeClass('btn-light')
										.addClass('btn-secondary').val(0).text(
												'해제');
							} else {//즐겨찾기 해제
								$('#favorite').removeClass('btn-secondary')
										.addClass('btn-light').val(1)
										.text('등록');
							}
							$.ajax({
								url : "updateFavorite.do",
								type : "GET",
								data : {
									"user_id" : user_id,
									"stock_code" : stock_code,
									"lookup_category_num" : lookup_category_num
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
	<se:authentication property="name" var="LoginUser" />
	<input id="login_id" type="hidden" value="${LoginUser}">
	<!-- header 영역 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<!-- content 영역 -->
	<div class="container my-5">
		<div class="d-flex flex-row">
			<h4><b id="stock_name">${stock_name}</b> (<span class="mx-1" id="stock_code">${stock_code}</span>)</h4>
			<c:choose>
				<c:when test="${lookup_category_num == 0}">
					<button id="favorite" type="button" class="btn btn-light mx-3"
						value="1">등록</button>
				</c:when>
				<c:otherwise>
					<button id="favorite" type="button" class="btn btn-secondary mx-3"
						value="0">해제</button>
				</c:otherwise>
			</c:choose>
		</div>
		<hr class="my-4" />
		<table class="table my-5" id="detail_table">
			<thead>
				<tr class="table-secondary text-center">
					<th>날짜</th>
					<th>현재가</th>
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
			<div class="col-xxl-8 col-xl-12">
				<div class="d-grid gap-2 d-md-block">
					<button type="button" class="btn btn-secondary btn-sm chart_btn"
						value="D" id="first_btn"
						style="-bs-btn-padding-y: 0.25rem; - -bs-btn-padding-x: 1rem; - -bs-btn-font-size: 0.75rem;">
						일</button>
					<button type="button" class="btn btn-secondary btn-sm chart_btn"
						value="W"
						style="-bs-btn-padding-y: 0.25rem; - -bs-btn-padding-x: 1rem; - -bs-btn-font-size: 0.75rem;">
						주</button>
					<button type="button" class="btn btn-secondary btn-sm chart_btn"
						value="M"
						style="-bs-btn-padding-y: 0.25rem; - -bs-btn-padding-x: 1rem; - -bs-btn-font-size: 0.75rem;">
						월</button>
					<button type="button" class="btn btn-secondary btn-sm chart_btn"
						value="Y"
						style="-bs-btn-padding-y: 0.25rem; - -bs-btn-padding-x: 1rem; - -bs-btn-font-size: 0.75rem;">
						년</button>
				</div>
				<div class="chart" id="chartContainer">
					<canvas id="myChart"></canvas>
				</div>
			</div>
			<div class="col-xxl-4 col-xl-12">
				<table class="table text-center h-100 align-middle" id="chart_table"
					border="1">
					<tbody>
						<tr id="highPrice_year">
							<th>연중 최고</th>
						</tr>
						<tr id="lowPrice_year">
							<th>연중 최저</th>
						</tr>
						<tr id="capital">
							<th>자본금(억)</th>
						</tr>
						<tr id="listed_stocks">
							<th>상장주식수(전주)</th>
						</tr>
						<tr id="market_capitalization">
							<th>시가총액(백만)</th>
						</tr>
						<tr id="foreigner_exhaustion_rate">
							<th>외국인소진율</th>
						</tr>
						<tr id="pereps">
							<th>PER/EPS</th>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<!-- footer 영역 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>

</body>
<!-- 
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/detail_chart.js"></script>
 -->
</html>