<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/regular_ex8.jsp</title>
</head>
<body>
<script>
	//아래의 두 정규 표현식은 같다 
	var reg1=/[0-9]/;
	var reg12=/[\d]/;//decimal \d숫자 한글자
	
	//아래의 두 정규 표현식은 같다 
	var reg2=/[^0-9]/;
	var reg22=/[\D]/; // \d 와 \D 는 반대 개념 \D는 숫자가 아닌 한글자
	
	//아래의 두 정규 표현식은 같다
	var reg3=/[a-zA-Z0-9]/;
	var reg32=/[\w]/; //특수문자가 아닌 것 한글자
	
	//아래의 두 정규 표현식은 같다
	var reg4=/[^a-zA-Z0-9]/;
	var reg42=/[\W]/; //특수문자 한글자
	
	//공백(띄어쓰기, tab, 개행기호)를 찾는 정규 표현식 
	var reg5=/[\s]/; //space 공간을 찾는 것
	//공백(띄어쓰기, tab, 개행기호)이 아닌 문자를 찾는 정규 표현식
	var reg6=/[\S]/; //공간이 아닌 것을 찾는 것
	
	// new 를 이용한 정규 표현식 객체 생성 
	var reg7=/^[a-z].{4,9}$/;
	var reg72=new RegExp("^[a-z].{4,9}$"); //정규 표현식 문자열 전달
	
	// abc 문자를 global 로 찾는 정규 표현식 객체  
	var reg8=/abc/g;
	var reg82=new RegExp("abc", "g"); //global 두번째 인자로 전달
	
	var reg9=/^[\w]+$/;
	var reg92=new RegExp("^[\\w]+$"); //역슬래시 하나를 찍기 위해서는 두개를 찍어야 한다. 문자열로 만들 때는. \\w 두개가 하나의 역할을 함.
	
	/*
	let a="abc\123";
	a => "abcS"
	
	let b="abc\\123";
	b => "abc\123"
	*/
</script>
</body>
</html>




