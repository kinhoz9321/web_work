<%@page import="test.gallery.dao.GalleryDao"%>
<%@page import="test.gallery.dto.GalleryDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한페이지에 몇개씩 표시할 것인지 (변화줘보기) 상수로 변경 (member list에서 복사 붙여넣기 한페이지 몇개 표시할 것이지 수정)
	//int pageRowCount=5;
	final int PAGE_ROW_COUNT=12;
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
<!-- jsp 도 자바 코드. 하지만 거슬리지 않는다. EL 과 jsp 로 해결하기 -->
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
	<div class="row"><!-- row 안에 칼럼의 크기를 만들고 있다. -->
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
	<nav>
		<ul class="pagination pagination justify-content-center">
			<%if(startPageNum!=1){ %>
				<li class="page-item">
					<a class="page-link" href="list.jsp?pageNum=<%=startPageNum-1 %>">Prev</a>
				</li>
			<%}else{ %>
			<!-- 
			disabled 존재하지만 누를 수 없게 만듦 javascript: 자바스크립트를 비워두겠다. 동작하지 않도록. 
			출력은 하지만 동작하지 않음.
			-->
				<li class="page-item disabled">
					<a class="page-link" href="javascript:">Prev</a>
				</li>
			<%} %>
			<%for(int i=startPageNum; i<=endPageNum; i++){ %><!-- 반복문 돌면서 li가 총 5개 만들어짐 (s1-e5)-->
				<%if(i==pageNum){ %><!-- i가 현재페이지 번호와 같으면 active가 들어가야 한다. -->
					<li class="page-item active"><!-- class 자동 부트스트랩 효과 추가 -->
						<a class="page-link" href="list.jsp?pageNum=<%=i %>"><%=i %></a>
						<!-- i가 1이 찍혀있으면 pageNum도 1이 찍혀 있어야 한다. -->
					</li>
				<%}else{ %><!-- i가 현재페이지 번호와 같지 않으면 active가 안들어간다. -->
					<li class="page-item"><!-- class 자동 부트스트랩 효과 추가 -->
						<a class="page-link" href="list.jsp?pageNum=<%=i %>"><%=i %></a>
					</li>
				<%} %>
			<%} %>
			<%if(endPageNum < totalPageCount){ %>
				<li class="page-item">
					<a class="page-link" href="list.jsp?pageNum=<%=endPageNum+1 %>">Next</a>
				</li>
			<%}else{ %>
			<!-- 
			disabled 존재하지만 누를 수 없게 만듦 javascript: 자바스크립트를 비워두겠다. 동작하지 않도록. 
			출력은 하지만 동작하지 않음.
			-->
				<li class="page-item disabled">
					<a class="page-link" href="javascript:">Next</a>
				</li>
			<%} %>
		</ul>
	</nav>
</div>
<script>
	//card 이미지의 부모 요소를 선택해서 imgLiquid 동작(jquery plugin 동작) 하기
	$(".img-wrapper").imgLiquid();
	//자바스크립트에는 원래 없다. imgLiquid.js 를 추가했기 때문에 사용 가능한 것
</script>
</body>
</html>
<!-- 
.card .card-text{ /*내용이 한줄을 넘어가면 .. 으로 표시되는 css*/
		display:block;
		white-space:nowrap;
		text-overflow:ellipsis;
		overflow:hidden;
		}
		
[id를 부여하면 안되는 이유]
반복문을 돌기 때문에
id는 onlyone이니까. 반복문안에서 id를 부여하면 안된다.
알아두기! 중요! 실수 많이하는 부분!

html
javacode 
jsp페이지에서 javacode 없애기
javacode를 태그 형태로 바꿀 것
 -->