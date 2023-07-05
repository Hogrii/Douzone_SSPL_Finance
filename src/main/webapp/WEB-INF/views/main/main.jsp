<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags" %>
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
<!-- jQuery cdn -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<title>메인페이지(mainpage)</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/global.css"
	rel="stylesheet" type="text/css">
<style>
#moveTopBtn {
	position: fixed;
	bottom: 1rem;
	right: 1rem;
	width: 4rem;
	height: 4rem;
}
</style>
<script type="text/javascript">
	$(function() {
		
		console.log("문의글 시작");
		// 문의 글
		$.ajax({
			url : "main/qnaGetList.do",
			type : "GET",
			dataType : "JSON",
			success : function(data) {
				data.forEach(item => {
					console.log("qna : " + item);
					let li = "";
					li = "<li class='list-group-item'><a href='qna/qnaDetail.do?qna_seq="+item.qna_seq+"'>"+item.qna_title+"</a></li>";
					$('#qnaList').append(li);
				});
				//<ul class="list-group list-group-flush">
				//<li class="list-group-item">1. An item</li>
			}
		})
		
		$.ajax({
			url : "main/commGetList.do",
			type : "GET",
			dataType : "JSON",
			success : function(data) {
				data.forEach(item => {
					let li = "";
					li = "<li class='list-group-item'><a href='community/detail.do?comm_seq="+item.comm_seq+"'>"+item.comm_title+"</a></li>";
					$('#commList').append(li);
				});
			}
		})
		
		
		let user_id = $('#login_id').val();
		//거래량 순위 테이블
		$.ajax({
			url : "main/searchForMainRankTable.do",
			type : "GET",
			dataType : "JSON",
			success : function(data) {
				let items = data.output;
				for(let i = 0; i < 15; i++) {
					let tr = "<tr class='text-center'>";
					//거래 순위
					tr += "<td>" + items[i].data_rank + "</td>";
					//종목명
					tr += "<td><a href='search/searchDetail.do?user_id=" + user_id + "&stock_code=" + items[i].mksc_shrn_iscd + "&stock_name=" + items[i].hts_kor_isnm + "'>" + items[i].hts_kor_isnm + "</a></td>";
					//현재가
					tr += "<td>" + parseInt(items[i].stck_prpr).toLocaleString() + "</td>";
					//등락률
					tr += "<td>" + items[i].prdy_ctrt + "</td>";
					//거래량 증가율
					tr += "<td>" + items[i].vol_inrt + "</td>";
					//전일 거래량
					tr += "<td>" + parseInt(items[i].prdy_vol).toLocaleString() + "</td>";
					//평균 거래량
					tr += "<td>" + parseInt(items[i].avrg_vol).toLocaleString() + "</td>";
					tr += "</td>";
					$('#trading_volume_ranking').append(tr);
				}
			}
		});
		
		//날짜 설정
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
		today.setDate(today.getDate() - 14);
		let start_year = today.getFullYear();
		let start_month = String(today.getMonth() + 1).padStart(2, '0');
		let start_day = String(today.getDate()).padStart(2, '0');
		start_date = start_year + start_month + start_day;
		console.log('시작일 : ' + start_date);
		//코스피 지수 차트 (업종번호 : 0001)
		$.ajax({
			url : "main/searchForMainChart.do",
			type : "GET",
			data : {
				"industry_code" : "0001",
				"start_date" : start_date,
				"end_date" : end_date
			},
			dataType : "JSON",
			success : function(data) {
				console.log(data);
				let ctx = document.getElementById("myChart1").getContext("2d");
				let chart_data = [];
		        $.each(data.output2.reverse(), function(index, item) {
		        	  let date = item.stck_bsop_date.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
		        	  console.log(date);
		        	  let price = item.bstp_nmix_prpr;
		        	  let each_data = [date, price];
		        	  chart_data.push(each_data);
		        });
		        let lineChart = new Chart(ctx, {
		            type: "line",
		            data: {
		                labels: chart_data.map(function (x) {
		                    return x[0];
		                }),
		                datasets: [
		                    {
		                    	label: 'KOSPI',
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
		                    text: "KOSPI 차트",
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
		//코스닥 지수 차트 (업종번호 : 11001)
		$.ajax({
			url : "main/searchForMainChart.do",
			type : "GET",
			data : {
				"industry_code" : "1001",
				"start_date" : start_date,
				"end_date" : end_date
			},
			dataType : "JSON",
			success : function(data) {
				console.log(data);
				let ctx = document.getElementById("myChart2").getContext("2d");
				let chart_data = [];
		        $.each(data.output2.reverse(), function(index, item) {
		        	  let date = item.stck_bsop_date.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
		        	  console.log(date);
		        	  let price = item.bstp_nmix_prpr;
		        	  let each_data = [date, price];
		        	  chart_data.push(each_data);
		        });
		        let lineChart = new Chart(ctx, {
		            type: "line",
		            data: {
		                labels: chart_data.map(function (x) {
		                    return x[0];
		                }),
		                datasets: [
		                    {
		                    	label: 'KOSDAQ',
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
		                    text: "KOSDAQ 차트",
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
</script>
</head>
<body>
	<se:authentication property="name" var="LoginUser"/>
	<input id="login_id" type="hidden" value="${LoginUser}">
	<!-- header 영역 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	<!-- content 영역 -->
	<main class="container my-5">
		<div class="row">
			<div class="col-md-8 align-self-center">
				<h5><b>오늘의 증시</b></h5>
			</div>
			<div class="col-md-4">
				<form action="search/searchList.do">
					<div class="input-group mb-3">
						<input type="text" id="keyword" class="form-control"
							placeholder="검색어를 입력하세요" name="stock_name" value="" />
						<input type="submit" id="search" class="btn btn-secondary" value="검색">
					</div>
				</form>
			</div>
		</div>
		<hr class="my-2 gy-5" />
		<div class="py-3 py-md-3">
		 <div class="row">
        <div class="col-xxl-6 col-xl-12">
            <div class="chart">
                <canvas id="myChart1" class="w-100 h-100"></canvas>
            </div>
        </div>
        <div class="col-xxl-6 col-xl-12">
            <div class="chart" id="chartContainer">
                <canvas id="myChart2" class="w-100 h-100"></canvas>
            </div>
        </div>
    </div>
		</div>
		<h5 class="py-3 py-md-3"><b>거래량순위</b></h5>
		<hr class="my-2 gy-5" />
		<div class="row py-3 py-md-3">
			<div class="col-md-12">
				<table class="table table-hover text-center">
					<thead class="bg-secondary text-dark bg-opacity-25">
						<tr>
							<th>순위</th>
							<th>종목명</th>
							<th>현재가</th>
							<th>등락률</th>
							<th>거래량 증가율</th>
							<th>전일 거래량</th>
							<th>평균 거래량</th>
						</tr>
					</thead>
					<tbody id="trading_volume_ranking">
						
					</tbody>
				</table>
			</div>
		</div>
		
		<div class="mainboard row d-flex flex-row justify-content-evenly">
			<div id="board1" class="col-md-5">
				<div class="py-3 py-md-3"><h5><b>커뮤니티</b></h5></div>
				<ul class="list-group list-group-flush" id="commList"></ul>
			</div>
			<div id="board2" class="col-md-5">
				<div class="py-3 py-md-3"><h5><b>문의</b></h5></div>
				<ul class="list-group list-group-flush" id="qnaList"></ul>
			</div>
		</div>
	</main>
	<a id="moveTopBtn"><img
		src="${pageContext.request.contextPath}/resources/img/topbutton.png"
		style="width: 38px; height: 38px" /></a>
	<!-- footer 영역 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	
</body>

<script>
        const $topBtn = document.querySelector("#moveTopBtn");

        // 버튼 클릭 시 맨 위로 이동
        $topBtn.onclick = () => {
            window.scrollTo({ top: 0, behavior: "smooth" });
        };
    </script>
</html>

