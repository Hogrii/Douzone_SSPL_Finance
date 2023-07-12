$(function() {

	  let save_id = localStorage.getItem("username");
	  let fail;
	  let path = window.location.pathname;
	  let pathSegments = path.split('/');
	  let extractedPart = pathSegments.slice(0,2).join('/');
	  // 페이지 로드 시 실행되는 코드
	  if (localStorage.getItem("remember_password") === "true") {
	    $("#user_id").val(localStorage.getItem("username"));
	    $("#remember_password").prop("checked", true);
	  }

	  // 에러 파라미터가 주소에 있는 경우 모달 창 띄우기
	  var urlParams = new URLSearchParams(window.location.search);
	  if (urlParams.has("error")) {
	    $("#resultMessage").empty();
	    $('#resultModal').modal('show');
	    $("#resultMessage").text("비밀번호 또는 아이디를 잘못 입력하셨습니다. 확인 후 다시 입력해주세요.");
	    fail = true;
	    console.log(urlParams);
	  }

	  // 로그인 폼 제출 시 실행되는 코드
	  $('form').submit(function(e) {
	    e.preventDefault();
	    console.log(!urlParams.has("error"));
	    let id = $('#user_id').val();
	    
	    $.ajax({
		      url: extractedPart + '/member/idcheck/' + id,
		      type: 'get',
		      contentType: 'application/json;charset=UTF-8',
		      dataType: 'json',
		      success: function(data) {
		    	  console.log(data.id);
			    if ($("#remember_password").is(":checked") && (data.id != null)) {
			    	  localStorage.setItem("username", data.id);
				      localStorage.setItem("remember_password", true);
				     
			    	if((fail && (data.id != null))){
			    	  localStorage.setItem("username", save_id);
				      localStorage.setItem("remember_password", true);	
				      fail = false;
			      }
			    } else if (!$("#remember_password").is(":checked")) {
			      localStorage.removeItem("username");
			      localStorage.removeItem("remember_password");	
			      fail = false;
			    }
		      },
		      error: function(xhr, status, error) {
		        console.error(error); // 에러 처리
		      }
		    });
	    
	    this.submit();
	  });
	  

	  // 모달 닫기 버튼 클릭 시 실행되는 코드
	  $('#resultModal').on('click', '[data-dismiss="modal"]', function() {
	    $('#resultModal').modal('hide');
	  });

	  // 페이지 새로고침 시 모달 창 띄우기 방지
	  if (performance.navigation.type === 1) {
	    if (urlParams.has("error")) {
	      history.replaceState(null, null, window.location.pathname);
	    }
	  }

});