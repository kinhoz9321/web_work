<%@page import="test.gallery.dao.GalleryDao"%>
<%@page import="java.util.List"%>
<%@page import="test.gallery.dto.GalleryDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//한페이지에 몇개씩 표시할 것인지 (변화줘보기) 상수로 변경 (member list에서 복사 붙여넣기 한페이지 몇개 표시할 것이지 수정)
	//int pageRowCount=5;
	final int PAGE_ROW_COUNT=8;
	//하단 페이지를 몇개씩 표시할 것인지
	final int PAGE_DISPLAY_COUNT=5;
	
	//ajax 요청 파라미터 pageNum 읽어오기 (pageNum은 무조건 넘어온다.)
	int pageNum=Integer.parseInt(request.getParameter("pageNum"));
	
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
%>
<%-- 
보여줄 페이지에 해당되는 div를 반복문 돌면서 응답하겠다. 
페이지 소스보기를 확인하면 반복문 돌면서 목록을 찍어내는 걸 알 수 있다. 
--%>
<%for(GalleryDto tmp:list){ %>
<div class="col-6 col-md-4 col-lg-3">
	<div class="card mb-3"><!-- mb-3 갤러리에 아래 위 공간 -->
		<a href="detail.jsp?num=<%=tmp.getNum()%>">
			<div class="img-wrapper"><!-- id를 부여하면 안된다. id=onlyone 여기는 for문 안. -->
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