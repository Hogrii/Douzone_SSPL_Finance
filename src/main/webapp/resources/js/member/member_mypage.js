document.addEventListener('DOMContentLoaded', function() {
	  let form = document.querySelector('form');
	  form.addEventListener('submit', function(e) {
	    e.preventDefault();
		let path = window.location.pathname;
	  	let pathSegments = path.split('/');
	 	 let extractedPart = pathSegments.slice(0,2).join('/');
	    let formData = new FormData(form);
	    let password = formData.get('password');

	    fetch(extractedPart + '/member/passwordCheck', {
	      method: 'POST',
	      headers: {
	        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
	      },
	      body: new URLSearchParams(formData)
	    })
	    .then(function(response) {
	      return response.text();
	    })
	    .then(function(data) {
	      console.log(data);
	      if (data === "true") {
	        location.href = extractedPart + "/member/member_modify";
	      } else if (data === "false") {
	        let resultMessage = document.querySelector('#resultMessage');
	        resultMessage.innerHTML = "비밀번호를 잘못 입력하셨습니다.";
	        let resultModal = new bootstrap.Modal(document.getElementById('resultModal'));
	        resultModal.show();
	      }
	    })
	    .catch(function(error) {
	      console.error(error);
	    });

	    $('#resultModal').on('click', '[data-dismiss="modal"]', function() {
		   	 $('#resultModal').modal('hide');

		    $('#resultModal').on('hidden.bs.modal', function() {
		    	$('#password').focus(); // Set focus on the input field stored in focusdata variable
		    });
		  });
	  });
	});
