<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
	integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l"
	crossorigin="anonymous" />
<link
            rel="stylesheet"
            href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"
/>
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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/member/member_join.js"></script>
<link
	href="${pageContext.request.contextPath }/resources/css/global.css"
	rel="stylesheet" type="text/css" />

</head>


<body>
	<header>
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	</header>


	     <div class="board">
            <div class="column">
                <div class="column-header">조회</div>
                <div class="sortable" id="todo" connectWith=".sortable"></div>
            </div>
            <div class="column">
                <div class="column-header">즐겨찾기</div>
                <div
                    class="sortable"
                    id="inProgress"
                    connectWith=".sortable"
                ></div>
            </div>
            <div class="column">
                <div class="column-header">매수</div>
                <div class="sortable" id="done" connectWith=".sortable"></div>
            </div>
            <div class="column">
                <div class="column-header">매도</div>
                <div
                    class="sortable"
                    id="newColumn"
                    connectWith=".sortable"
                ></div>
            </div>
        </div>


	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
		integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
		integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
		crossorigin="anonymous"></script>
	 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script>
            let data = [
                {
                    lookup_list_num: 1,
                    user_id: "shs1991",
                    lookup_category_num: 0,
                    lookup_list_date: 20230626,
                    lookup_list_name: "삼성전자",
                    lookup_list_order: 0,
                },
                {
                    lookup_list_num: 2,
                    user_id: "shs1991",
                    lookup_category_num: 0,
                    lookup_list_date: 20230626,
                    lookup_list_name: "더존비즈온1",
                    lookup_list_order: 1,
                },
                {
                    lookup_list_num: 3,
                    user_id: "shs1991",
                    lookup_category_num: 3,
                    lookup_list_date: 20230625,
                    lookup_list_name: "우리은행",
                    lookup_list_order: 0,
                },
                {
                    lookup_list_num: 4,
                    user_id: "shs1992",
                    lookup_category_num: 1,
                    lookup_list_date: 20230627,
                    lookup_list_name: "더존비즈온2",
                    lookup_list_order: 1,
                },
                {
                    lookup_list_num: 5,
                    user_id: "shs1994",
                    lookup_category_num: 2,
                    lookup_list_date: 20230626,
                    lookup_list_name: "삼성전자",
                    lookup_list_order: 0,
                },
                {
                    lookup_list_num: 4,
                    user_id: "shs1992",
                    lookup_category_num: 0,
                    lookup_list_date: 20230627,
                    lookup_list_name: "더존비즈온3",
                    lookup_list_order: 2,
                },
            ];
                

            $(function () {
            	
            	/*  $.ajax({
                     url: '/sspl_finance/member/userData/',
                     type: 'get',
                     contentType: 'application/json;charset=UTF-8',
                     data : {"id" : id},
                     dataType: 'json',
                     success: function(data) {
                         $('#name').val(data.name);
                         $('#email').val(data.email);
                         $('#phone_number').val(data.phone_number);
                         b_userData.name = data.name;
                         b_userData.email = data.email;
                         b_userData.phone_number = data.phone_number
                     },
                     error: function(xhr, status, error) {
                       console.error(error); // 에러 처리
                     }
                }); */
            	
            	
                // Sort the data array in ascending order based on lookup_list_order
                data.sort((a, b) => a.lookup_list_order - b.lookup_list_order);

                // Iterate over the data array and create the Kanban cards dynamically
                data.forEach((item) => {
                    // Create the Kanban card element
                    var card = $("<div>")
                        .addClass("card")
                        .text(item.lookup_list_name);

                    // Determine the target column based on lookup_category_num
                    var columnId = "";
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
                    $(columnId).append(card);
                });

                // Make the Kanban cards draggable and sortable
                $(".sortable").sortable({
                    connectWith: ".sortable",
                    placeholder: "card-placeholder",
                    receive: function (event, ui) {
                        // Get the card that was dropped
                        var droppedCard = ui.item;

                        // Get the target column id
                        var targetColumnId = droppedCard.parent().attr("id");

                        // Get the card's data
                        var cardData = {
                            lookup_list_num: droppedCard.data("lookup-list-num"),
                            lookup_category_num: getCategoryNumber(targetColumnId),
                        };

                        // Update the card's category number in the data array
                        var index = data.findIndex(
                            (item) => item.lookup_list_num === cardData.lookup_list_num
                        );
                        if (index !== -1) {
                            data[index].lookup_category_num = cardData.lookup_category_num;
                        }

                        // Save the new data array
                        saveData();
                    },
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

                // Function to save the data array
                function saveData() {
                    // You can use AJAX or any other method to send the updated data to the server
                    console.log("Data saved:", data);
                }
            });
        </script>

</body>
</html>