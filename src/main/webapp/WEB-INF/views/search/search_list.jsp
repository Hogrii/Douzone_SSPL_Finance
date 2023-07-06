<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags" %>
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

.list_data {
      max-height: 600px;
      overflow-y: auto;
}
.sticky-top {
      position: sticky;
      top: 40px; /* 상단에 고정할 높이를 지정합니다. */
      padding: 10px; /* 내부 여백을 추가할 수 있습니다. */
      z-index: 999; /* 필요한 경우 z-index 값을 조정합니다. */
}
</style>
<script type="text/javascript">
	$(function() {
		$('#search').on('click', function() {
			let keyword = $('#keyword').val();
			if(keyword==null || keyword === "") { //검색어가 공백인 경우
				$('#tbody').empty();
				let tr = "<tr>";
				tr += "<td class='text-center' colspan='4'>검색어를 입력해 주세요.</td>";
				tr += "</tr>";
				$('#tbody').append(tr);	
			}else{ //검색어가 공백이 아닌 경우
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
						if(data.length == 0) { //검색 결과가 없는 경우
							let tr = "<tr>";
							tr += "<td class='text-center' colspan='4'>검색 결과가 없습니다.</td>";
							tr += "</tr>";
							$('#tbody').append(tr);	
						}else { //검색 결과가 있는 경우
							//pageNation(data);
							data.forEach(item => {
								let stock_code = item.stock_code;
								let stock_name = item.stock_name;
								let tr = "<tr id="+ stock_code +"></tr>";
								$('tbody').append(tr); 
								detail_data(stock_code, stock_name);
							});
						}
					}
				});
			}
		});
		
		$("#search").click();		
		$("#keyword").on('keypress', function(e) {
		    if (e.which === 13) { // 엔터 키를 눌렀을 때
		      $("#search").click(); // id가 "search"인 버튼 클릭
		    }
		  });
		let user_id = $('#login_id').val();
		//검색 결과 데이터 가공 함수
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
					td += "<td><a href='searchDetail.do?user_id=" + user_id + "&stock_code="+stock_code+"&stock_name="+stock_name+"'>" + stock_name + "</a></td>";
					if(parseInt(sign) < 3) { //전일 대비 상승일 경우
					td += "<td class='text-danger'>" + parseInt(price).toLocaleString() + "</td>";
					td += "<td class='text-danger'>▲" + parseInt(yesterday).toLocaleString() + "</td>";
					td += "<td class='text-danger'>+" + per + "</td>";						
					}else if(parseInt(sign) > 3) { //전일 대비 하락일 경우
					td += "<td class='text-primary'>" + parseInt(price).toLocaleString() + "</td>";
					td += "<td class='text-primary'>▼" + parseInt(yesterday).toLocaleString() + "</td>";
					td += "<td class='text-primary'>" + per + "</td>";												
					}else if(parseInt(sign) == 3){ //전일과 동일한 경우
					td += "<td class='text-danger'>" + parseInt(price).toLocaleString() + "</td>";
					td += "<td class='text-danger'>" + parseInt(yesterday).toLocaleString() + "</td>";
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
	<se:authentication property="name" var="LoginUser"/>
	<input id="login_id" type="hidden" value="${LoginUser}">
	<!-- header 영역 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<!-- content 영역 -->
	<div class="container my-5">
		<div class="row">
			<div class="col-md-8 align-self-center">
				<h5>검색목록</h5>
			</div>
			<div class="col-md-4">
				<div class="input-group mb-3">
					<input type="text" id="keyword" class="form-control"
						placeholder="검색어를 입력하세요" name="stock_name" value="${stock_name}" />
					<button type="button" id="search" class="btn btn-secondary">검색</button>
				</div>
			</div>
		</div>
		<hr />
		<div class="row">
			<div class="col-md-12 list_data">
				<table class="table">
					<thead class="bg-secondary text-white sticky-top">
						<tr>
							<th>종목명</th>
							<th>현재가</th>
							<th>전일대비</th>
							<th>등락률</th>
						</tr>
					</thead>
					<tbody id="tbody">
					</tbody>
				</table>
			</div>
		</div>
	</div>	
	<!-- footer 영역 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>	
</body>
</html>