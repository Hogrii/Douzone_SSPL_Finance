<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- bootstrap css-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" />
<!-- bootstrap js cdn-->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- boxicons js cdn -->
<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<!-- jQuery cdn -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<title>종목검색</title>
<style>
* {
	box-sizing: border-box;
	padding: 0px;
	margin: 0px;
}

box-icon {
	vertical-align: -5px;
}

hr {
	border-width: 0.125em;
}
</style>
<script type="text/javascript">
	$(function() {
		let keyword = '';
		$('#keyword').on('change', function() {
			keyword = $(this).val();
		});
		$('#search').on('click', function() {
			$.ajax({
				url : "searchKeyword.do",
				type : "GET",
				data : {
					"stock_name" : keyword
				},
				dataType : "JSON",
				success : function(data) {
					console.log(data);
					$("#tbody").empty();
					data.forEach(item => {
						let stock_code = item.stock_code;
						let stock_name = item.stock_name;
						let tr = "<tr id="+ stock_code +"></tr>";
						$('tbody').append(tr); 
						detail_data(stock_code, stock_name);
					});
				}
			});
		});
		function detail_data(stock_code, stock_name) {
			$.ajax({
				url : "searchByCode.do",
				type : "GET",
				data : { 
					"stock_code" : stock_code
				},
				dataType : "JSON",
				success : function(data) {
					let tr = $("#"+stock_code);
					let td;
					//현재가
					let price = data.output.stck_prpr;
					//전일대비
					let yesterday = data.output.prdy_vrss;
					//전일대비 부호
					let sign = data.output.prdy_vrss_sign;
					//전일대비율
					let per = data.output.prdy_ctrt;
					td += "<td><a href='searchDetail.do?stock_code="+stock_code+"'>" + stock_name + "</a></td>";
					if(parseInt(sign) < 3) {
					td += "<td class='text-danger'>" + parseInt(price).toLocaleString() + "</td>";
					td += "<td class='text-danger'>▲" + yesterday + "</td>";
					td += "<td class='text-danger'>+" + per + "</td>";						
					}else if(parseInt(sign) > 3) {
					td += "<td class='text-primary'>" + parseInt(price).toLocaleString() + "</td>";
					td += "<td class='text-primary'>▼" + yesterday + "</td>";
					td += "<td class='text-primary'>" + per + "</td>";												
					}else if(parseInt(sign) == 3){
					td += "<td class='text-danger'>" + parseInt(price).toLocaleString() + "</td>";
					td += "<td class='text-danger'>" + yesterday + "</td>";
					td += "<td class='text-danger'>" + per + "</td>";
					}
					tr.append(td);
				}
			});
		}
	});
</script>
</head>
<body>
	<!-- header 영역 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<!-- content 영역 -->
	<div class="container my-5">
		<div class="row">
			<div class="col-md-8 align-self-center">
				<h5>검색목록</h5>
			</div>
			<div class="col-md-4">
				<form action="searchKeyword.do">
					<div class="input-group mb-3">
						<input type="text" id="keyword" class="form-control"
							placeholder="검색어를 입력하세요" name="stock_name" value="" />
						<button type="button" id="search" class="btn btn-secondary">검색</button>
					</div>
				</form>
			</div>
		</div>
		<hr />
		<div class="row">
			<div class="col-md-12">
				<table class="table">
					<thead class="bg-secondary text-dark bg-opacity-25">
						<tr>
							<th>종목명</th>
							<th>현재가</th>
							<th>전일대비</th>
							<th>등락률</th>
						</tr>
					</thead>
					<tbody id="tbody">
					<!-- 
						<tr>
							<td>삼성화재</td>
							<td>229,000</td>
							<td class="text-danger">▲2000</td>
							<td class="text-danger">+0.88%</td>
						</tr>
						<tr>
							<td>삼성제약</td>
							<td>3,160</td>
							<td class="text-primary">▼5</td>
							<td class="text-primary">-0.16%</td>
						</tr>
						<tr>
							<td><a href="searchDetail.do">삼성전자</a></td>
							<td>72,700</td>
							<td class="text-danger">▲100</td>
							<td class="text-danger">+0.14%</td>
						</tr>
						<tr>
							<td>삼성SDI</td>
							<td>657,000</td>
							<td class="text-primary">▼21,000</td>
							<td class="text-primary">-3.10%</td>
						</tr>
					 -->
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<!-- footer 영역 -->
</body>
</html>