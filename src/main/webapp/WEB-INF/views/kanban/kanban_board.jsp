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
.red-text {
    color: red;
}

.blue-text {
    color: blue;
}

.default-text {
    color : black;
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
	  let change_data;
	  $.ajax({
	    url: '/sspl_finance/kanban/kanban_board/' + id,
	    type: 'get',
	    contentType: 'application/json;charset=UTF-8',
	    dataType: 'json',
	    success: function(data) {
	      console.log(data);
	      $.each(data, function(index) {
	        detail_data(data[index].stock_code, data[index].stock_name);
	      });

	      // 데이터 배열을 lookup_list_order를 기준으로 오름차순으로 정렬
	      data.sort((a, b) => a.lookup_list_order - b.lookup_list_order);

	      // 데이터 배열을 반복하며 동적으로 칸반 카드 생성
	      data.forEach((item) => {
	    	  
	    	  //제목 글자 수 치환
	        let change_name = item.stock_name; 
	        	
	        if (change_name.length > 12) {
	        	 console.log(change_name.length);
	        	 console.log(change_name);
	        	 change_name = change_name.substring(0, 12) + '...';
	        	 console.log(change_name);
			  }
	    	  
	        // 칸반 카드 요소 생성
	        let xbtn = $('<button>')
				  .addClass('btn btn-secondary btn-sm')
				  .attr('type', 'button')
				  .attr('id', 'xbtn')
				  .text('X')
				  .css({
				    position: 'absolute',
				    top: '5px',
				    right: '5px',
				    withd: '15px'
				  });
				
				let cardContent = $('<div>')
				  .html('<span class="card-text fs-6"><b>['  + change_name + ']</b></span><hr class="my-2">');
				  
				let card = $('<div>')
				  .addClass('card')
				  .attr('id', item.stock_code)
				  .attr('lookup_list_num', item.lookup_list_num)
				  .attr('lookup_category_num', item.lookup_category_num)
				  .attr('lookup_list_order', item.lookup_list_order)
				  .css({
				    position: 'relative'
				  });


	        // lookup_category_num을 기준으로 대상 컬럼 결정
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

	        // 카드를 대상 컬럼에 추가
	        
	        $(columnId).append(card);
	        card.append(xbtn, cardContent);
	        $('#'+item.stock_code).prepend(xbtn);
			
	        // 카드를 클릭했을 때 detail_data 함수 호출
	        card.on("click", function() {
	          detail_data(item.stock_code, item.stock_name);
	        });
	      });

	      // 칸반 카드를 드래그 및 정렬 가능하도록 설정
	      $(".sortable").sortable({
	    	    connectWith: ".sortable",
	    	    placeholder: "card-placeholder",
	    	    receive: function (event, ui) {
	    	      // 드롭된 카드 가져오기
	    	      let droppedCard = ui.item;

	    	      // 대상 컬럼 ID 가져오기
	    	      let targetColumnId = droppedCard.closest('.column')
	    	      let sortableElement = droppedCard.parent();
	    	      //let targetId = sortableElement.id;
	    	      let targetId = sortableElement[0].id;
				 
	    	      console.log(sortableElement);
	    	      // 카드의 위치 정보 변경
	    	      let cards = droppedCard.parent().children(".card");
	    	      cards.each(function (index) {
	    	        let card = $(this);
	    	        card.attr("lookup_category_num", getCategoryNumber(targetId));
	    	        card.attr("lookup_list_order", index);
	    	      });

	    	      
	    	      
	    	      // 변경된 카드 정보 수집
	    	      let change_data = [];
	    	      $(".sortable").each(function () {
	    	          let column = $(this);
	    	          let columnId = column.attr("id");
	    	          let categoryNumber = getCategoryNumber(columnId);
						
	    	          column.children(".card").each(function (index) {
	    	            let card = $(this);
	    	            let cardData = {
	    	              user_id : id,		
	    	              lookup_list_num: card.attr("lookup_list_num"),
	    	              lookup_category_num: card.attr("lookup_category_num"),
	    	              lookup_list_order: index
	    	            };
	    	            change_data.push(cardData);
	    	          });
	    	        });

	    	      // change_data 변수에 저장된 변경된 카드 정보 출력
	    	      console.log(change_data);
	    	      update_data(change_data)
	    	    }
	    	  });	
	    },
	    error: function(xhr, status, error) {
	      console.error(error); // 에러 처리
	    }
	  });

	  $(document).on( 'click' , '#xbtn' , function() { $(this).parent().remove()} )
	  
	  $(document).on('dblclick', '.card' function() {
		 	let   
	  });
	  
	  
	  // 컬럼 ID를 기준으로 카테고리 번호를 가져오는 함수
	  function getCategoryNumber(columnId) {
		  console.log("진입"+columnId);
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

	 
	  function update_data(change_data) {
		    console.log("업데이트"+change_data);
		    console.log("변환"+JSON.stringify(change_data));
		    $.ajax({
		        url: "/sspl_finance/kanban/kanban_update",
		        type: "put",
		        contentType: 'application/json;charset=UTF-8',
		        data: JSON.stringify(change_data),
		        dataType: "JSON",
		        success: function (data) {
		     		console.log(data.msg);
		        }
		    });
		}
	  

	  function detail_data(stock_code, stock_name) {
		    
		    $.ajax({
		        url: "/sspl_finance/search/searchByCode.do",
		        type: "GET",
		        contentType: 'application/json;charset=UTF-8',
		        data: {
		            "stock_code": stock_code
		        },
		        dataType: "JSON",
		        success: function (data) {
		     
		            let cardId = "#" + stock_code;
		            let card = $(cardId);

		            // 기존의 상세 정보 삭제
		            card.children(".card-details").remove();

		            // 상세 정보 요소 생성  
		            let currentPrice = $("<div>").text("현재가: " + parseInt(data.output.stck_prpr).toLocaleString());
		            let priceChangeRate = $("<div>").text("전일대비율: " + data.output.prdy_ctrt);

		            // 조건부 CSS 설정
		            let sign = data.output.prdy_vrss_sign;
		            if (parseInt(sign) < 3) {
		                priceChangeRate.addClass("red-text");
		            } else if (parseInt(sign) > 3) {
		                priceChangeRate.addClass("blue-text");
		            } else if (parseInt(sign) === 3) {
		                priceChangeRate.addClass("default-text");
		            }

		            // 상세 정보를 위한 컨테이너 div 생성
		            let cardDetails = $("<div>")
		                .addClass("card-details")
		                .append(currentPrice, priceChangeRate);

		            // 카드에 상세 정보 추가
		            card.append(cardDetails);
		        }
		    });
		}
	});
</script>
</body>
</html>