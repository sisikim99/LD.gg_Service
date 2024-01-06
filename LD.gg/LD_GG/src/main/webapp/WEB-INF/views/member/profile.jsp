<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.3.js"
	integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
	crossorigin="anonymous"></script>
<body>
	<h1>프로필 - 개인정보수정 페이지</h1>

	<br>
	<a href="/member/dropMember">회원탈퇴</a>

	<h3 id="userTypeText"></h3>
	<button id="userTypeChange">전환하기</button>
	<input class="input" type="password" id="password" name="password"
		placeholder="비밀번호 적으라우">
	<span id="result"></span>

</body>
<script type="text/javascript">
	const userType = ${sessionScope.user_type};
	if(userType == 1){
		document.getElementById("userTypeText").innerHTML = "멘토회원으로 전환하기";
	}else if(userType == 2){
		document.getElementById("userTypeText").innerHTML = "일반회원으로 전환하기";
	}else{
		document.getElementById("userTypeText").innerHTML = "로그인 후 이용할 수 있습니다";
	}
	
	document.getElementById("userTypeChange").addEventListener("click", function() {
		let changeType = 0;
		let password = document.getElementById('password').value;
		
		if(userType == 1){
			changeType = 2;
		}else if(userType == 2){
			changeType = 1;
		}else{
			alert("로그인 후 이용해주세요")
		}
		
		if(changeType != 0){
			$.ajax({
		        method: 'post',
		        url: '/member/change_usertype',
		        data: {email:'${sessionScope.email}',password:password, user_type:changeType},
		      }).done(res=>{
		        console.log(res);
		        if (res) {
		        	  console.log()
		        	  location.href = '/member/testMain';
		        	} else {
		        	  console.log(res)
		        	  document.getElementById("result").innerHTML = "유저타입 변경 실패";
		        	  document.getElementById("result").style.color = "red";
		        	} 
		      }).fail(err=>{
		        console.log(err);
		      }); 
		}else{
			alert("유저타입 변경 실패");
		}
	});
</script>
</html>