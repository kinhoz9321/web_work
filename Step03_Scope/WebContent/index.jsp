<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>
</head>
<body>
	<h1>인덱스 페이지 입니다.</h1>
	<ul>
		<li><a href="fortune">오늘의 운세</a></li>
		<li><a href="member">회원 한명의 정보 보기</a></li>
		<li><a href="test/fortune.jsp">서블릿을 거치지 않고 fortune.jsp</a></li>
		<li><a href="test/member.jsp">서블릿을 거치지 않고 member.jsp</a></li>
		<li><a href="test/play.jsp">저장된 닉네임 확인하러 가기</a></li>
	</ul>
	<h3>폼을 jsp 페이지에 전송</h3>
	<form action="test/save.jsp" method="post">
		<input type="text" name="nick" placeholder="닉네임 입력"/>
		<button type="submit">닉네임 기억 시키기</button>
	</form>
	<br />
	<h3>폼을 Servlet 에 전송</h3>
	<form action="test/save" method="post">
		<input type="text" name="nick" placeholder="닉네임 입력"/>
		<button type="submit">닉네임 기억 시키기</button>
	</form>
</body>
</html>
<!-- 
서블릿 거쳐가면 내용이 나오고,
jsp 직접가면 내용이 null임 (일회성 데이터)
이것은 리퀘스트에 담은 것은 응답하고 나면 사라진다는 것을 알아야 함. (요청할때마다 다른 응답을 해야하기 때문에 유지할 필요 없음)

*중요!*
나중에는 servlet에서는 (복잡한)logic 처리 (로직처리 결과 데이터(모델))를 하고
(로직처리 결과는 데이터를 끌어온 것이나, 계산해서 계산의 값을 담은 것을 사용한것 등..)
jsp 페이지에서는 응답에만 집중할 것
분업화 시키기
클라이언트에게 요청받은 것을 servlet에서 로직처리를 하고 
결과를 request 에 담고 (setAttribute, getAttribute) - 오브젝트로 이동하기 때문에 캐스팅이 필요.
(서블릿과 jsp 의 로직결과의 이동을 위해 set,get을 사용한다.) - 장점 : jsp 페이지는 단순화 되고 응답에만 집중할 수 있다. jsp 코드는 단순해짐.
request가 그대로 forward되어서 jsp로 간다.
html 작성이 불편하기 때문에
jsp로 응답을 미룬다(위임).

서블릿과 jsp 는 1개씩만 만들어짐.

request 는 필요한 데이터를 전달하는 방법 forward를 사용 - 주로 그렇게 사용한다.

세션 영역 session(Httpsession)
로그인 처리를 할 때 사용함 (응답을 처리하고도 어느 정도 유지가 됨.)
- 로그인을 한번만 해도 다른 페이지로 이동을 마음껏 할 수 있다. request에 담으면 페이지를 이동할때마다 로그인을 해야한다. (큰 차이 기억)
ex) 뱅킹 로그인
- 어떤 서버에 여러 클라이언트들이(불특정 시점에) 로그인을 했을 때 세션에 저장해두면 서버에서 로직으로 판단을 할 수 있다. (로그인했네, 안했네)
- 다음번 요청(ex, 페이지 이동, 새로고침 등..의 행동) 때 세션을 뒤져보면 로그인의 유무를 확인할 수 있음.
 -->