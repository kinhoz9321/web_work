<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/pwd_updateform.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<div class="container">
	<nav>
		<ul class="breadcrumb">
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath}">Home</a>
			</li>
			<li class="breadcrumb-item">
			<a href="${pageContext.request.contextPath}/users/info.jsp">가입 정보 확인</a>
			</li>
		</ul>
	</nav>
</div>
<div class="container">
	<form action="pwd_update.jsp" method="post" id="myForm">
		<div class="form-group">
			<label for="pwd">기존 비밀번호</label>
			<input class="form-control" type="password" name="pwd" id="pwd"/>
		</div>
		<div class="form-group">
			<label for="newPwd">새 비밀번호</label>
			<input class="form-control" type="password" name="newPwd" id="newPwd" />
			<small class="form-text text-muted">비밀번호는 4글자 이상 입력해야 합니다.</small>
			<div class="invalid-feedback">사용가능한 비밀번호 입니다.</div>
		</div>
		<div class="form-group">
			<label for="newPwd2">새 비밀번호 확인</label>
			<input class="form-control" type="password" id="newPwd2"/>
			<div class="invalid-feedback">비밀번호가 다릅니다</div>
			<div class="valid-feedback">비밀번호를 확인하였습니다.</div>
		</div>
		<button class="btn btn-success" type="submit">수정하기</button>
		<button class="btn btn-success" type="reset">취소</button>
	</form>
</div>
<script>
	let isPwdValid=false;
	let isPwd2Valid=false;
	
	$("#myForm").on("submit",function(){
		if(!isPwdValid){
			return false;
		}
	});
	
	$("#newPwd, #newPwd2").on("input", function(){
		//input 이벤트가 언제 일어나는지 확인 해보기!!!
		//console.log("input!");
		
		//입력한 두 비밀번호를 읽어온다.
		let pwd=$("#newPwd").val();
		let pwd2=$("#newPwd2").val();
		
		//만약 비밀번호를 4글자 이상 입력하지 않았다면
		if(pwd.length<4){//pwd와 pwd2가 동일한지 확인할거니까 pwd의 길이만 확인하면 된다.
			//비밀번호가 유효하지 않는다고 표시하고
			$("#newPwd").addClass("is-invalid");
			isPwdValid=false;
			//함수를 여기서 종료
			return;
		}
		
		//일단 모든 검증 클래스를 제거하고
		$("#newPwd").removeClass("is-valid is-invalid");
		$("#newPwd2").removeClass("is-valid is-invalid");
		
		//두 비밀번호가 같은지 확인해서 
		if(pwd==pwd2){//만일 같으면
			//유효하다는 클래스를 추가
			$("#newPwd").addClass("is-valid");//addClass = 클래스를 추가
			$("#newPwd2").addClass("is-valid");
			isPwdValid=true;
			isPwd2Valid=true;
		}else{//다르면
			//유효하지 않다는 클래스를 추가
			$("#newPwd").addClass("is-invalid");
			$("#newPwd2").addClass("is-invalid");
			isPwdValid=false;
			isPwd2Valid=false;
		}
	});
	
</script>
</body>
</html>
<!-- 
새로운 비밀번호가 맞는지 자바스크립트로 확인하기
기존 비밀번호는 업데이트 시점에 확인해서 맞지 않으면 수정 실패 띄우기

버튼을 누르면
폼에는 submit 이벤트가 일어남.
버튼에는 click 이벤트가 일어남.

[정리]
폼 안에 있는 submit 버튼을 누르면 submit 이벤트가 일어난다.
submit이벤트가 일어났을 때 폼 전송을 막아버리겠다.
폼 전송을 막는 방법은 preventDefault() 사용

document.querySelector("#myForm")
	.addEventListener("submit", function(event){
		//새 비밀번호와 새 비밀번호 확인 값 읽어오기
		let pwd1=document.querySelector("#newPwd").value;
		let pwd2=document.querySelector("#newPwd2").value;
		
		//새 비밀번호와 새 비밀번호 확인이 일치하지 않으면 폼 전송을 막는다.
		if(pwd1!=pwd2){
			alert("비밀번호를 확인 하세요!");
			event.preventDefault();//폼 전송 막기
		}
		
	});
 -->