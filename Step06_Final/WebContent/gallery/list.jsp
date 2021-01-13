<%@page import="test.gallery.dao.GalleryDao"%>
<%@page import="test.gallery.dto.GalleryDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//Gallery 목록 얻어오기
	List<GalleryDto> list=GalleryDao.getInstance().getList();
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
	<a href="private/upload_form.jsp">사진 업로드 하러 가기</a>
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
			<a href="detail.jsp?num=<%=tmp.getNum()%>">
				<div class="card mb-3"><!-- mb-3 갤러리에 아래 위 공간 -->
					<div class="img-wrapper"><!-- id를 부여하면 안된다. -->
						<img class="card-img-top" src="${pageContext.request.contextPath }<%=tmp.getImagePath() %>" />
					</div>
					<div class="card-body">
						<h2 class="card-text"><%=tmp.getCaption() %></h2>
						<p class="card-text"> 작성자 : <strong><%=tmp.getWriter() %></strong></p>
						<p class="card-text"><%=tmp.getRegdate() %></p>
					</div>
				</div>
			</a>
		</div>
		<%} %>
	</div>
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
 -->