<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/regular_ex.jsp</title>
</head>
<body>
<h1>Regular Expression (정규 표현식) 테스트</h1>
<input type="text" id="id" placeholder="아이디 입력..."/>
<button id="checkBtn">가입</button>
<p>영문자 소문자로 시작하고 5~10글자 이내, 특수문자를 하나이상 입력 하세요</p>
<a href="regular_ex2.jsp">다음예제</a>
<script src="${pageContext.request.contextPath }/js/jquery-3.5.1.js"></script>
<script>
	// /XXXX/ 안에 작성법을 배우는 게 regular expression $는 특별한 표현 정규 표현식 객체는 /로 감싸서 만듦.
	//영문자 소문자로 시작하는지 여부를 알아 낼수 있는 정규 표현식 객체
	var reg1=/^[a-z]/;
	//문자가 최소 5글자 최대 10 글자 인지 여부를 검증할수 있는 정규 표현식 객체
	var reg2=/^.{5,10}$/;
	//특수 문자가 포함되어 있는지 여부를 검증할수 있는 정규 표현식 객체 
	/*
	시작과 끝이 없음. 
	어떤 문자열이 포함되있는지 알아낼때는 시작과 끝을 명시하지 않는다.
	한글도 특수문자
	[^ ]not
	특수문자가 있기만 하면 됨. 
	아래 예시 2가지의 차이 알아두기
	*/
	var reg3=/[^a-zA-Z0-9]/;
	var r3=/^[^a-zA-Z0-9]$/; //true가 나오려면 특수문자 한글자여야 한다. 검증할 문자열이 반드시 한글자이면서 특수문자여야 한다.
	
	//영문자 소문자 시작 + 최소 5글자 최대 10글자 인지 여부를 검증할수 있는 정규 표현식 객체
	/*
	**영문자 소문자 로 시작 최소 4글자 최대 9글자. 근데 앞에 소문자가 들어가니까 최소 5글자 최대 10글자.**
	시작과 끝을 명시한것과 안한것은 큰 차이가 있다.
	r4.test("AAAAabcd1234BBB") = true
	*/
	var reg4=/^[a-z].{4,9}$/;
	var r4=/[a-z].{4.9}/;
	
	
	//버튼을 클릭했을때 실행할 함수 등록 
	$("#checkBtn").on("click", function(){
		//1. 입력한 문자열을 읽어와서
		var str=$("#id").val();
		//2. 검증한다.
		var result1=reg1.test(str);
		if(result1){
			alert("영문자 소문자로 시작 했군요!");
		}
		//최소 5글자~최대 10글자 를 검증한다.
		var result2=reg2.test(str);
		if(result2){
			alert("최소 5글자~최대 10글자 이군요!");
		}
		//특수 문자가 포함되어 있는지를 검증한다.
		var result3=reg3.test(str);
		if(result3){
			alert("특수문자가 포함 되어 있군요!");
		}
		
		if(reg4.test(str)==false){//first 매치가 없다는 것
			alert("영문자 소문자로 시작을 하고 최소 5글자~최대 10글자 이내로 작성해 주세요!");
		}
		if(!reg4.test(str)){
			alert("영문자 소문자로 시작을 하고 최소 5글자~최대 10글자 이내로 작성해 주세요!");
		}
	});
</script>
</body>
</html>
<%--
test() 메서드는 주어진 문자열이 정규 표현식을 만족하는지 판별하고, 그 여부를 true 또는 false 로 반환합니다.
- 주어진 문자열이 여러 문자열 중에 들어가기만 하면 true 반환

ex1)
let r1=/abc/;
r1.test("123") => false
r1.test("ab") => false
r1.test("abc") => true
r1.test("abcd") => true

ex2)
let r2=/@/;
r2.test("123!") => false
r2.test("%!#$") => false
r2.test("@") => true
r2.test("123@aaa") => true
 --%>











