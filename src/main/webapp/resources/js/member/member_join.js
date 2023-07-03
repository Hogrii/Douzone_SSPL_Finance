$(function() {

	  let focusdata = '';
	  let message = '';
	  let id_check = 0;

	  $('#id_check').on('click', function() {
	    let id = $('#user_id').val();
	    console.log(id);

	    $.ajax({
	      url: '/sspl_finance/member/idcheck/' + id,
	      type: 'get',
	      contentType: 'application/json;charset=UTF-8',
	      dataType: 'json',
	      success: function(data) {
	        let idRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,12}$/;
	        if (data.id != null) {
	          message = '이미 존재한 아이디입니다';
	        } else if (!idRegex.test(id)) {
	          message = '아이디는 6자 이상 12자 이하의 영문과 숫자를 포함해야 합니다.';
	        } else {
	          message = '사용 가능한 아이디입니다';
	          id_check = 1;
	          focusdata = '';
	        }
	        $('#resultMessage').empty();
	        $('#resultModal').modal('show');
	        $('#resultMessage').text(message);
	      },
	      error: function(xhr, status, error) {
	        console.error(error); // 에러 처리
	      }
	    });
	  });

	  $('#form').submit(function(e) {
	    e.preventDefault(); // 폼의 기본 동작인 페이지 새로고침을 방지

	    let password = $('#password').val();
	    let password_ok = $('#password_ok').val();

	    // Validate name
	    let nameRegex = /^[가-힣]{2,4}$/;
	    let name = $('#name').val();
	    if (!nameRegex.test(name)) {
	      $('#resultModal').modal('show');
	      $('#resultMessage').text('이름은 2자 이상 4자 이하의 한국어만 입력 가능합니다.');
	      focusdata = '#name'; // Set the focusdata variable for name input field
	      return;
	    }

	    // Validate ID
	    if (id_check === 0) {
	      $('#resultModal').modal('show');
	      $('#resultMessage').text('아이디 중복 검사를 먼저해주세요');
	      focusdata = '#user_id'; // Set the focusdata variable for user_id input field
	      return;
	    }

	    // Validate password
	    let passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,15}$/;
	    if (!passwordRegex.test(password)) {
	      $('#resultModal').modal('show');
	      $('#resultMessage').text('비밀번호는 8자 이상 15자 이하의 영문, 숫자, 특수문자를 포함해야 합니다.');
	      focusdata = '#password'; // Set the focusdata variable for password input field
	      return;
	    }

	    if (password !== password_ok) {
	      $('#resultModal').modal('show');
	      $('#resultMessage').text('비밀번호 서로 다르게 입력하셨습니다.');
	      focusdata = '#password_ok'; // Set the focusdata variable for password_ok input field
	      return;
	    }

	    // Validate email
	    let emailRegex = /^[A-Za-z\d]+@[A-Za-z\d]+\.[A-Za-z\d]+$/;
	    let email = $('#email').val();
	    if (!emailRegex.test(email)) {
	      $('#resultModal').modal('show');
	      $('#resultMessage').text('올바른 이메일 주소를 입력하세요.');
	      focusdata = '#email'; // Set the focusdata variable for email input field
	      return;
	    }

	    // Validate phone number
	    let phoneRegex = /^(010|011|016|017|018|019)[^0][0-9]{3,4}[0-9]{4}$/;
	    let phone_number = $('#phone_number').val();
	    if (!phoneRegex.test(phone_number)) {
	      $('#resultModal').modal('show');
	      $('#resultMessage').text('올바른 휴대폰 번호를 입력하세요.');
	      focusdata = '#phone_number'; // Set the focusdata variable for phone_number input field
	      return;
	    }

	    let formData = $(this).serialize();

	    console.log(formData);
	    $.ajax({
	      url: '/sspl_finance/member/joinOk',
	      type: 'POST',
	      contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
	      data: formData,
	      dataType: 'json',
	      success: function(data) {
	        console.log(data);
	        $('#resultMessage').empty();
	        $('#resultModal').modal('show');
	        $('#resultMessage').text(data.message);
	        message = data.message;
			  $('#resultModal').on('hidden.bs.modal', function() {
			    nextPage(message);
			  });
	      },
	      error: function(xhr, status, error) {
	        console.error(error); // 에러 처리
	      }
	    });
	  });

	  // 모달 닫기 버튼 클릭 이벤트 처리
	  $('#resultModal').on('click', '[data-dismiss="modal"]', function() {
	    $('#resultModal').modal('hide');

	    $('#resultModal').on('hidden.bs.modal', function() {
	      focusOn(focusdata); // Set focus on the input field stored in focusdata variable
	    });
	  });

	  function nextPage(message) {
	    if (message.includes('성공')) {
	      location.href = "/sspl_finance/";
	    } else if (message.includes('@')) {
	      focusdata = '#email';
	      focusOn(focusdata);
	    } else if (message.includes('01')) {
	      focusdata = '#phone_number';
	      focusOn(focusdata);
	    } else if (message.includes('아이디')) {
	      focusdata = '#user_id';
	      focusOn(focusdata);
	    }
	  }

	  function focusOn(elementId) {
	    console.log(elementId);
	    $(elementId).focus();
	  }

	});