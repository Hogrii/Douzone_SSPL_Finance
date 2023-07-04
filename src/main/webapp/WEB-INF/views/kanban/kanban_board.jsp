<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
	integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous" />
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
<style>
.container {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
}

form {
	width: 275px;
}

.board {
	display: flex;
}

.column {
	flex: 1;
	margin: 10px;
	padding: 10px;
	background-color: #f2f2f2;
}

.column-header {
	font-weight: bold;
	margin-bottom: 10px;
	pointer-events: none;
}

.card {
	padding: 10px;
	background-color: #fff;
	margin-bottom: 10px;
	cursor: pointer;
}

.card-placeholder {
	background-color: #ccc;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script
	src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link
	href="${pageContext.request.contextPath }/resources/css/global.css"
	rel="stylesheet" type="text/css" />
</head>
<body>
	<se:authentication property="name" var="LoginUser" />
	<input type="hidden" name="id" id="id" value="${LoginUser}">
	
	<header>
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	</header>
	<div class="board">
		<div class="column sortable">
			<div class="column-header">조회</div>
			<div class="sortable" id="todo" connectWith=".sortable"></div>
		</div>
		<div class="column sortable">
			<div class="column-header">즐겨찾기</div>
			<div class="sortable" id="inProgress" connectWith=".sortable"></div>
		</div>
		<div class="column sortable">
			<div class="column-header">매수</div>
			<div class="sortable" id="done" connectWith=".sortable"></div>
		</div>
		<div class="column sortable">
			<div class="column-header">매도</div>
			<div class="sortable" id="newColumn" connectWith=".sortable"></div>
		</div>
	</div>
	<script>

			$(function () {
				let id = $('#id').val();

				$.ajax({
					url: '/sspl_finance/kanban/kanban_board/' + id,
					type: 'get',
					contentType: 'application/json;charset=UTF-8',
					dataType: 'json',
					success: function(data) {
						console.log(data);
						/*  $.each(data, function(index){
							 	console.log(data);
								detail_data(data[index].stock_code);
						 }); */
						
						
						// Sort the data array in ascending order based on lookup_list_order
						data.sort((a, b) => a.lookup_list_order - b.lookup_list_order);

						// Iterate over the data array and create the Kanban cards dynamically
						data.forEach((item) => {
							// Create the Kanban card element
							let card = $("<div>")
								.addClass("card")
								.attr('id', item.stock_code)             
								.text(item.stock_name);

							// Determine the target column based on lookup_category_num
							let columnId = "";
							switch (item.lookup_category_num) {
								case 0:
									columnId = "#todo";
									break;
								case 1:
									columnId = "#inProgress";
									break;
								case 2:
									columnId = "#done";
									break;
								case 3:
									columnId = "#newColumn";
									break;
								default:
									break;
							}

							// Append the card to the target column
							//$(cadr).append();
							$(columnId).append(card);
							
						});

						// Make the Kanban cards draggable and sortable
						$(".sortable").sortable({
							connectWith: ".sortable",
							placeholder: "card-placeholder",
							receive: function (event, ui) {
								// Get the card that was dropped
								let droppedCard = ui.item;

								// Get the target column id
								let targetColumnId = droppedCard.parent().attr("id");

								// Get the card's data
								let cardData = {
									lookup_list_num: droppedCard.data("lookup-list-num"),
									lookup_category_num: getCategoryNumber(targetColumnId),
								};

								// Update the card's category number in the data array
								let index = data.findIndex(
									(item) => item.lookup_list_num === cardData.lookup_list_num
								);
								if (index !== -1) {
									data[index].lookup_category_num = cardData.lookup_category_num;
								}

								// Save the new data array
								saveData();
							},
						});
					},
					error: function(xhr, status, error) {
						console.error(error); // 에러 처리
					}
				});

				// Function to get the category number based on column id
				function getCategoryNumber(columnId) {
					switch (columnId) {
						case "todo":
							return 0;
						case "inProgress":
							return 1;
						case "done":
							return 2;
						case "newColumn":
							return 3;
						default:
							return -1;
					}
				}

				// Function to save the data array (dummy implementation)
				function saveData() {
					console.log(data);
					// Implement your logic to save the data array to the server
				}
				
				function detail_data(stock_code) {
					console.log(stock_code);
					$.ajax({
						url : "/sspl_finance/search/searchByCode.do",
						type : "GET",
						data : { 
							"stock_code" : stock_code
						},
						dataType : "JSON",
						success : function(data) {
							console.log(data);
							 let tr = $("#"+stock_code);
							let stck_code = data.stck_shrn_iscd
;
							//현재가
							let price = data.output.stck_prpr;
							//전일대비
							let yesterday = data.output.prdy_vrss;
							//전일대비 부호
							let sign = data.output.prdy_vrss_sign;
							//전일대비율
							let per = data.output.prdy_ctrt;
							if(parseInt(sign) < 3) { //전일 대비 상승일 경우
												
							}else if(parseInt(sign) > 3) { //전일 대비 하락일 경우
								
							}else if(parseInt(sign) == 3){ //전일과 동일한 경우
							
							}
							 
						}
					});
				}
				
			});
	</script>
</body>
</html>