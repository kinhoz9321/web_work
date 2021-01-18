<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/signup_form.jsp</title>
<!-- jquery 로딩이 포함됨 -->
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>
<div class="container">
	<nav>
		<ul class="breadcrumb">
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath}">Home</a>
			</li>
			<li class="breadcrumb-item">회원가입</li>
		</ul>
	</nav>
</div>
<div class="container">
	<!-- 
		[ novalidate 는 웹브라우저 자체의 검증기능 사용하지 않기 ]
		<input type="email" /> 같은 경우 웹브라우저가 직접 개입하기도 한다.
		해당 기능 사용하지 않기 위해서는 novalidate를 form 에 명시해야 한다.
	 -->
	<form action="signup.jsp" method="post" id="myForm" novalidate>
		<div class="form-group">
			<label for="id">아이디</label>
			<input class="form-control" type="text" name="id" id="id"/>
			<small class="form-text text-muted">아이디는 영문자 소문자로 시작하고 5~10글자 이내로 입력하세요.</small>
			<div class="invalid-feedback">사용할 수 없는 아이디 입니다.</div>
			<div class="valid-feedback">사용 가능한 아이디 입니다.</div>
		</div>
		<div class="form-group">
			<label for="pwd">비밀번호</label>
			<!-- 비밀번호, 비밀번호 확인이 같지 않을 때 is-invalid / 같을 때 is-valid 자바스크립트로 조건부 출력하게 만든다. -->
			<input class="form-control" type="password" name="pwd" id="pwd"/>
			<small class="form-text text-muted">비밀번호는 5~10글자 이내로 입력하세요.</small>
			<div class="invalid-feedback">사용가능한 비밀번호 입니다.</div>
		</div>
		<div class="form-group">
			<label for="pwd2">비밀번호 확인</label>
			<input class="form-control" type="password" name="pwd2" id="pwd2"/>
			<div class="invalid-feedback">비밀번호가 다릅니다</div>
			<div class="valid-feedback">비밀번호를 확인하였습니다.</div>
		</div>
		<div class="form-group">
			<label for="email">이메일</label>
			<input class="form-control" type="email" name="email" id="email"/>
			<small class="form-text text-muted">이메일의 형식을 확인하세요.</small>
			<div class="invalid-feedback">이메일 형식을 확인하세요.</div>
			<div class="valid-feedback"></div>
		</div>
		<button type="submit" class="btn btn-success" style="color:white">가입</button>
	</form>
</div>
<script>
	/*상황에 따라 정규표현식을 바꾸면 된다.*/
	
	//아이디를 검증할 정규 표현식
	//영문자 소문자로 시작하고 5~10 글자 이내인지 검증
	let reg_id=/^[a-z].{4,9}$/;
	
	//비밀번호를 검증할 정규 표현식
	//5~10글자 이내인지 검증
	let reg_pwd=/^.{5,10}$/;
	let reg_pwd2=/^.{5,10}$/;
	
	//이메일을 검증할 정규 표현식 (정확히 검증하려면 javascript 이메일 정규 표현식 검색해서 사용!)
	//@ 가 포함되어 있는지 검증
	let reg_email=/@/;
	
	//아이디의 유효성 여부를 관리할 변수 만들고 초기값 부여하기
	let isIdValid=false;
	
	//비밀번호 유효성 여부를 관리할 변수 만들고 초기값 부여하기
	let isPwdValid=false;
	let isPwd2Valid=false;
	
	//이메일 유효성 여부를 관리할 변수 만들고 초기값 부여하기
	let isEmailValid=false;
	
	//폼 전체의 유효성 여부를 관리할 변수 만들고 초기값 부여하기 (모든게 유효해야만 true)
	let isFormValid=false;
	
	//폼에 submit 이벤트가 일어났을 때 jquery 를 활용해서 폼에 입력한 내용 검증하기
	
	//id가 myForm 인 요소에 submit 이벤트가 일어났을 때 실행할 함수 등록
	$("#myForm").on("submit",function(){
		//폼 전체의 유효성 여부를 얻어낸다.
		isFormValid = isIdValid && isPwdValid && isEmailValid; //어느 하나라도 만족하지 못하면 폼 전송을 막아버리겠다.
		//만일 폼이 유효하지 않는다면
		if(!isFormValid){
			return false;
		}
	});
	
	//id 가 pwd 와 pwd2 인 요소에 input(입력) 이벤트가 일어 났을 때 실행할 함수 등록 (콘솔창에 input 출력)
	$("#pwd, #pwd2").on("input", function(){
		//입력한 두 비밀번호를 읽어온다.
		var pwd=$("#pwd").val();
		var pwd2=$("#pwd2").val();
		
		//만약 비밀번호를 4글자 이상 입력하지 않았다면
		if(!reg_pwd.test(pwd)){//pwd와 pwd2가 동일한지 확인할거니까 pwd의 길이만 확인하면 된다.
			//비밀번호가 유효하지 않는다고 표시하고
			$("#pwd").addClass("is-invalid");
			isPwdValid=false;
			//함수를 여기서 종료
			return;
		}
		
		//일단 모든 검증 클래스를 제거하고
		$("#pwd").removeClass("is-valid is-invalid");
		$("#pwd2").removeClass("is-valid is-invalid");
		
		//두 비밀번호가 같은지 확인해서 
		if(reg_pwd.test(pwd)==reg_pwd2.test(pwd2)){//만일 같으면
			//유효하다는 클래스를 추가
			$("#pwd").addClass("is-valid");//addClass = 클래스를 추가
			$("#pwd2").addClass("is-valid");
			isPwdValid=true;
			isPwd2Valid=true;
		}else{//다르면
			//유효하지 않다는 클래스를 추가
			$("#pwd").addClass("is-invalid");
			$("#pwd2").addClass("is-invalid");
			isPwdValid=false;
			isPwd2Valid=false;
		}
	});
	
	//이메일 확인란
	//email 가 pwd 와 pwd2 인 요소에 input(입력) 이벤트가 일어 났을 때 실행할 함수 등록 (콘솔창에 input 출력)
	$("#email").on("input", function(){
		//입력한 두 비밀번호를 읽어온다.
		var email=$("#email").val();
		
		//만약 비밀번호를 4글자 이상 입력하지 않았다면
		if(!reg_email.test(email)){//pwd와 pwd2가 동일한지 확인할거니까 pwd의 길이만 확인하면 된다.
			//비밀번호가 유효하지 않는다고 표시하고
			$("#email").addClass("is-invalid");
			isEmailValid=false;
			//함수를 여기서 종료
			return;
		}
		
		//일단 모든 검증 클래스를 제거하고
		$("#email").removeClass("is-valid is-invalid");
		
		//이메일이 검증되면
		if(reg_email.test(email)){
			//유효하다는 클래스를 추가
			$("#email").addClass("is-valid");//addClass = 클래스를 추가
			isEmailValid=true;
		}else{//다르면
			//유효하지 않다는 클래스를 추가
			$("#email").addClass("is-invalid");
			isEmailValid=false;
		}
	});
	
	//아이디 입력란에 입력했을 때 실행할 함수 등록
	$("#id").on("input", function(){
		//1. 입력한 아이디를 읽어와서
		var inputId=$("#id").val();
		
		//2. 서버에 ajax 요청으로 보내서 사용 가능 여부를 응답 받아서 반응을 보여준다.
		//일단 모든 검증 클래스를 제거하고
		$("#id").removeClass("is-valid is-invalid");
		
		//만일 문자열의 길이가 4보다 작으면
		if(!reg_id.test(inputId)){
			//아이디가 유효하지 않다고 표시하고
			$("#id").addClass("is-invalid");
			//함수를 여기서 종료한다.
			return; //서버에 보내지도 않는다.
		}
		$.ajax({
			url:"checkid.jsp",
			method:"GET",
			data:"inputId="+inputId,//paramName=paramValue
			success:function(responseData){
				
				console.log(responseData);
				if(responseData.isExist){//이미 존재하는 아이디인 경우
					$("#id").addClass("is-invalid");
					isIdValid=false;
				}else{//존재하지 않는 아이디 즉 사용가능한 아이디인 경우
					$("#id").addClass("is-valid");
					//아이디가 유효하다고 표시한다.
					isIdValid=true;
					//isIdValid가 false로 쭉 내려오다가 모든 조건이 맞으면 마지막에 isIdValid=true; 가 되면서 폼 전송이 된다.
				}
			}
		});//jquery 이용
	});
</script>
</body>
</html>