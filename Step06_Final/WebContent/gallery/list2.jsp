<%@page import="test.gallery.dao.GalleryDao"%>
<%@page import="test.gallery.dto.GalleryDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한페이지에 몇개씩 표시할 것인지 (변화줘보기) 상수로 변경 (member list에서 복사 붙여넣기 한페이지 몇개 표시할 것이지 수정)
	//int pageRowCount=5;
	final int PAGE_ROW_COUNT=8;
	//하단 페이지를 몇개씩 표시할 것인지
	final int PAGE_DISPLAY_COUNT=5;

	//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
	int pageNum=1;
	//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
	String strPageNum=request.getParameter("pageNum");
	//만일 페이지 번호가 파라미터로 넘어 온다면 (파라미터가 안넘어오면 null 1페이지를 보여준다.)
	if(strPageNum != null){
		//숫자로 바꿔서 보여줄 페이지 번호로 저장한다.
		pageNum=Integer.parseInt(strPageNum);
	}
	
	//보여줄 페이지의 시작 ROWNUM
	int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
	//보여줄 페이지의 끝 ROWNUM
	int endRowNum=pageNum*PAGE_ROW_COUNT;
	
	//startRowNum 과 endRowNum 을 GalleryDto 객체에 담고
	GalleryDto dto=new GalleryDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	
	//GalleryDao 객체를 이용해서 회원 목록을 얻어온다. getList에 startRowNum 과 endRowNum 을 담은 GalleryDto 전달
	List<GalleryDto> list=GalleryDao.getInstance().getList(dto);
	//여기 있는 내용을 반복문 돌면서 table row를 얻어내면 된다.
	
	//하단 페이지 이동 ui를 최대 몇개씩 표시할지에 대한 값
	//int pageDisplayCount=5; //(변화주기)
	
	//하단 시작 페이지 번호
	int startPageNum = 1+((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;//정수를 정수로 나누면 정수밖에 안나온다. 0.1,0.2 = 0 소수점은 다 잘림.
	//하단 끝 페이지 번호
	int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
	/*
	12345
	678910
	넣어서 확인
	윗줄은 
	1
	6
	아랫줄은 
	5
	10 
	나옴
	*/
	
	//전체 row의 갯수
	int totalRow=GalleryDao.getInstance().getCount();
	//전체 페이지의 갯수 구하기
	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
	//정수로 캐스팅, 올림연산(n.o), 소수점자리까지 구하기 위해 double 캐스팅
	//끝페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
	if(endPageNum > totalPageCount){
		endPageNum=totalPageCount; //보정해준다.
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/gallery/list.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<!-- 
	jquery 플러그인 imgLiquid.js 로딩하기
	- 반드시 jquery.js 가 먼저 로딩이 되어 있어야지만 동작한다.
	- 사용법은 이미지의 부모 div 의 크기를 결정하고 이미지를 선택해서 .imgLiquid() 동작을 하면 된다.
 -->
<script src="${pageContext.request.contextPath}/js/imgLiquid.js"></script>
<style>
	/*card 이미지 부모요소의 높이 지정*/
	.img-wrapper{/*width=100% div니까*/
		height: 250px;
		/*
		transform 을 적용할 때 0.3s 동안 순차적으로 적용시키기 (사진이 커지는 모습이 부드럽고, 안부드럽고 차이)
		변화시킬때 시간 텀을 두고 변화시키는 게 transition
		all은 전부 (transform, background-color)
		*/
		transition: all 0.3s ease-out;
		
	}
	/*.img-wrapper 에 마우스가 hover 되었을때 적용할 css*/
	.img-wrapper:hover{
		/*transform: rotateZ(10deg) scale(1.1); - 화면이 돌아감*/
		/*원본크기의 1.1배로 확대 시키기*/
		transform: scale(1.05);
		background-color:orange;
	}
	
	.card .card-text{ /*내용이 한줄을 넘어가면 .. 으로 표시되는 css*/
		display:block;
		white-space:nowrap;
		text-overflow:ellipsis;
		overflow:hidden;
	}
	
	/* img 가 가운데 정렬 되도록 */
	.back-drop{/*전체 화면을 덮어버리는 것 백드랍 아무것도 누를 수 없음*/
		/*일단 숨겨 놓는다.*/
		display:none;
	
		/*화면 전체를 투명도가 있는 회색으로 덮기 위한 css*/
		position: fixed;
		top: 0;
		right: 0;
		bottom: 0;
		left: 0;
		background-color:white;
		padding-top: 300px;
		z-index: 10000;
		opacity: 0.5; /*투명도 조절*/
		text-align: center;
	}
	
	.back-drop img{
		width: 100px;
		opacity: 1;/*로딩 이미지만 선명하게 하려고 했는데 안되네?*/
		/*rotationAnimation 이라는 키프레임을 2초 동안 일정한 비율로 적용하기*/
		animation: rotateAnimation 2s ease-out infinite;/*3, infinite(무한반복)=@keyframes rotateAnimation 반복횟수*/
		/*
		transform 1s ease-out;
		linear(선형) :n초 동안 일정한 비율 (속도)로 돌리겠다.
		ease-out : 빠르게 돌다가 끝에 부드럽게 느려진다.
		타이밍 펑션(timing function)
		*/
	}
	/*
	.back-drop img:hover{
		transform : rotate(360deg);
	}
	*/
	/*
	프론트앤드 영역
	회전하는 rotateAnimation 이라는 이름의 키프레임 정의하기
	@keyframes css3 사용중
	*/
	@keyframes rotateAnimation{
		0%{
			transform: rotate(0deg);
		}
		100%{
			transform: rotate(360deg);
		}
	}
</style>
</head>
<body>
<!-- navbar 목록에 추가시키기 위해 만드는 것 -->
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="gallery" name="thisPage"/>
</jsp:include>
<div class="container">
	<button class="btn btn-success">
		<a href="private/upload_form.jsp">사진 업로드 하러 가기</a>
	</button>
	<button class="btn btn-warning">
		<a href="private/ajax_form.jsp">사진 업로드 하러 가기2</a>
	</button>
	<h1>갤러리 목록 입니다.</h1>
	<div class="row" id="galleryList"><!-- row 안에 칼럼의 크기를 만들고 있다. -->
		<%for(GalleryDto tmp:list){ %>
		<!-- 
			*col-6 col-md-3 col-lg-4 의미*
			[칼럼의 폭을 반응형으로 만들기!]
			device 폭 768px 미만에서 칼럼의 폭 => 6/12 (50%)
			device 폭 768px ~ 992px 에서 칼럼의 폭 => 4/12 (25%)
			device 폭 992px 이상에서 칼럼의 폭 3/12 (33.333%)
			4 -> 3 -> 2 로 갤러리 화면 달라짐
		 -->
		<div class="col-6 col-md-4 col-lg-3">
			<div class="card mb-3"><!-- mb-3 갤러리에 아래 위 공간 -->
				<a href="detail.jsp?num=<%=tmp.getNum()%>">
					<div class="img-wrapper"><!-- id를 부여하면 안된다. -->
						<img class="card-img-top" src="${pageContext.request.contextPath }<%=tmp.getImagePath() %>" />
					</div>
				</a>
				<div class="card-body">
					<h2 class="card-text"><%=tmp.getCaption() %></h2>
					<p class="card-text"> 작성자 : <strong><%=tmp.getWriter() %></strong></p>
					<p class="card-text"><%=tmp.getRegdate() %></p>
				</div>
			</div>
		</div>
		<%} %>
	</div>
</div>
<div class="back-drop">
	<img src="${pageContext.request.contextPath}/svg/spinner-solid.svg" />
</div>
<script>
	//card 이미지의 부모 요소를 선택해서 imgLiquid 동작(jquery plugin 동작) 하기
	$(".img-wrapper").imgLiquid();
	//자바스크립트에는 원래 없다. imgLiquid.js 를 추가했기 때문에 사용 가능한 것
	
	//페이지가 처음 로딩될 때 1page 를 보여주기 때문에 초기값을 1 로 지정한다.
	let currentPage=1; //화면상에 로딩된 최신 페이지 번호를 저장할 변수
	
	//현재 페이지가 로딩중인지 여부를 저장할 변수 
	let isLoading=false;
	
	//웹브라우저의 창을 스크롤 할 때 마다 호출되는 함수 등록
	$(window).on("scroll",function(){
		console.log("scroll!");//스크롤 이벤트가 일어날 때 마다 실행순서가 이리로 들어온다.
		//최 하단까지 (바닥까지) 스크롤 되었는지 조사해본다.
	
		//위로 스크롤된 길이
		let scrollTop=$(window).scrollTop();
		//웹브라우저 창의 높이
		let windowHeight=$(window).height();
		//문서 전체의 높이
		let documentHeight=$(document).height();
		
		//바닥까지 스크롤 되었음을 알 수 있는 수식
		let isBottom = scrollTop+windowHeight +10 >= documentHeight;//1도 가능하지만 10을 하면 약간의 옵셋?을 줘서 미리 로딩시키는 것
		if(isBottom){
			console.log("바닥입니당!");
			
			//만일 현재 마지막 페이지라면 
			<%--만약 15페이지까지 있다면 <%=totalPageCount %>=15 페이지 소스보기에서 확인 가능--%>
			if(currentPage == <%=totalPageCount %> || isLoading){//마지막페이지거나 로딩중이면 실행순서 끝냄
				return; //함수를 여기서 끝낸다.
			}
			<%--이 조건을 if(isBottom)에 넣을 수도 있다--%>
			
			//현재 로딩중이라고 표시한다.
			isLoading=true;
			<%--
			*2페이지까지만 나오는 이유 (중복 로딩을 방지하기 위해 짠 로직의 버그)
			
			isLoading 초기값 false
			실행순서 false니까 if 건너뜀
			isLading true로 바뀜.
			페이지 요청 1번 함 (2페이지)
			2번째 요청 들어왔을 때 isLoading=true; 
			if(currentPage == <%=totalPageCount %> || isLoading){//마지막페이지거나 로딩중이면 실행순서 끝냄
				return; //함수를 여기서 끝낸다.
			}
			--%>
			
			//로딩바를 띄우고
			$(".back-drop").show();
			
			//요청할 페이지 번호를 1 증가 시킨다. 연산자!
			currentPage++;
			
			//추가로 받아올 페이지를 서버에 ajax 요청을 하고
			//$.ajax(); 요청에 대한 응답은 {}로 요청
			$.ajax({
				url:"ajax_page.jsp",//요청
				method:"GET",
				data:"pageNum="+currentPage,//페이지는 동적으로 달라져야 함. 변수값을 놓고 변수값을 증가시키면서 들어가게 해야한다. 연결 연산자! {pageNum:correntPage} 오브젝트도 가능. 쿼리문자열을 써도 되고 오브젝트를 써도 된다.
				success:function(data){//응답은 data 함수로 들어옴. 
					console.log(data); //data=>string 응답된 문자열은 html 형식이다.
					//해당 문자열을 #galleryList div 에 html 로 해석하라고 추가한다.
					$("#galleryList").append(data); //= jquery
					//document.querySelector("#galleryList").append(data); = javascript
					
					//응답이 오면 로딩바 숨기기
					$(".back-drop").hide();
					
					//클래스명이 img-wrapper 인 요소를 모두 찾아서 imgLiquid() 동작하기
					//$(".img-wrapper").imgLiquid();
					
					//현재 추가된 img 요소의 부모 div를 선택해서 imgLiquid()동작하기
					$(".page-"+currentPage).imgLiquid();
					//로딩중이 아니라고 표시한다.
					isLoading = false; //2페이지까지만 나오는 버그 해결
				}
			});
			//응답이 오면 응답된 컨텐츠를 body에 추가하고 
			
			//로딩바를 숨긴다.
		}
	});
</script>
</body>
</html>
<%-- 
web browser window
document

scrolltop
windowheight
documentheight


scrolltop+windowheight==documentheight 바닥까지 스크롤 했을 때

소스코드를 전부 외울 필요는 없지만, 어떻게 사용해야 하는지, 어떻게 처리해야 하는지 등등...
방법에 대한 건 숙지해야한다. 단계적 공부에서 많이 익혀둘 것.

ajax 형태
$.ajax({
	url:"ajax_page.jsp",
	method:"GET",
	data:"pageNum=2",
	success:function(data){}
});

연산자에 대해 좀 더 공부 필요. 자연스럽게 쓰기!

$(".img-wrapper").imgLiquid();
추가된 것만 저 동작을 하게 하기

주석때문에 동작하지 않는 경우가 많다. 주석을 잘 처리할 것.

논리적으로 생각하는 힘 키우기.
--%>