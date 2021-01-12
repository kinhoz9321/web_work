<%@page import="test.file.dao.FileDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="test.file.dto.FileDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	final int PAGE_ROW_COUNT=5;
	final int PAGE_DISPLAY_COUNT=5;
	
	int pageNum=1;
	String strPageNum=request.getParameter("pageNum");
	if(strPageNum!=null){
		pageNum=Integer.parseInt(strPageNum);
	}
	
	int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
	int endRowNum=pageNum*PAGE_ROW_COUNT;
	
	/*
		[검색 키워드에 관련된 처리]
		- 검색 키워드가 파라미터로 넘어올 수도 있고, 안 넘어 올수도 있다.
	*/
	String keyword=request.getParameter("keyword");
	String condition=request.getParameter("condition");
	//만일 키워드가 넘어오지 않는다면
	if(keyword==null){
		//키워드와 검색 조건에 빈 문자열을 넣어준다.
		//클라이언트 웹브라우저에 출력할 때 "null"을 출력되지 않게 하기 이해서
		keyword="";//키워드
		condition="";//검색조건
	}
	
	
	FileDto dto=new FileDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	
	//ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
	List<FileDto> list=null;
	
	//전체 row의 갯수를 담을 지역변수를 미리 만든다.
	int totalRow=0;
	
	//만일 검색 키워드가 넘어온다면 (3개의 블럭) 메소드 총 6개 추가하기
	if(!keyword.equals("")){//오늘의 로직처리 부분!(키워드가 있을때 어떻게 달라지는지!)
		//검색 조건이 무엇이냐에 따라 분기하기
		if(condition.equals("title_filename")){//제목+파일명 검색인 경우
			//검색 키워드를 FileDto에 담아서 전달한다.
			dto.setTitle(keyword);
			dto.setOrgFileName(keyword);
			
		}else if(condition.equals("title")){//제목 검색인 경우
			dto.setTitle(keyword);
		
		}else if(condition.equals("writer")){//작성자 검색인 경우
			dto.setWriter(keyword);
			
		}//다른 검색 조건을 추가하고 싶다면 아래에 else if() 를 계속 추가하면 된다.
	}else{//검색 키워드가 넘어오지 않는다면 (1개의 블럭)
		//키워드가 없을때 호출하는 메소드를 이용해서 파일 목록을 얻어온다.
		list=FileDao.getInstance().getList(dto);
		//키워드가 없을때 호출하는 메소드를 이용해서 전체 row의 갯수를 얻어온다.
		totalRow=FileDao.getInstance().getCount();
	}
	/*
	각각의 블럭에서 하는 일
	- 검색 조건에 맞는 글 목록과 글의 갯수 얻어오기
	
	[팁]
	컨트롤 누른 상태에서 filedao 클릭하면 바로 filedao로 넘어갈 수 있다.
	*/
	int startPageNum=1+((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
	int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
	if(endPageNum > totalPageCount){
		endPageNum=totalPageCount;
	}
	
	//로그인된 아이디가 있는지 읽어와본다.(로그인을 하지 않았으면 null 이다.)
	String id=(String)session.getAttribute("id");
	
%>
<!-- 
ctrl+f 해서 replace 하기
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/file/list.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="file" name="thisPage"/>
</jsp:include>
<div class="container">
	<nav>
		<ul class="breadcrumb">
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath}">Home</a>
			</li>
			<li class="breadcrumb-item">자료실 목록</li>
		</ul>
	</nav>
</div>
<div class="container">
	<button class="btn btn-success">
		<a href="private/upload_form.jsp" style="color:white">업로드 하러가기</a>
	</button>
	<table class="table table-striped">
		<thead class="table-warning">
			<tr>
				<th>번호</th>
				<th>작성자</th>
				<th>제목(파일에 대한 설명)</th>
				<th>파일명</th>
				<th>크기</th>
				<th>등록일</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
		<%for(FileDto tmp : list){ %>
			<tr>
				<td><%=tmp.getNum() %></td>
				<td><%=tmp.getWriter() %></td>
				<td><%=tmp.getTitle() %></td>
				<!-- GET 방식 파라미터로 파일번호를 들고 갈 수 있게 해줌 -->
				<td><a href="download.jsp?num=<%=tmp.getNum()%>"><%=tmp.getOrgFileName() %></a></td>
				<td><%=tmp.getFileSize() %></td>
				<td><%=tmp.getRegdate() %></td>
				<td>
				<td>
				<%if(tmp.getWriter().equals(id)){ %>
					<a href="javascript:deleteConfirm(<%=tmp.getNum() %>)">삭제</a>
				<%} %>
				</td>
			</tr>
		<%} %>
		</tbody>
	</table>
	<nav>
		<ul class="pagination pagination justify-content-center">
			<%if(startPageNum!=1){ %>
				<li class="page-item">
					<a class="page-link" href="list.jsp?pageNum=<%=startPageNum-1%>">prev</a>
				</li>
			<%} %>
			<%for(int i=startPageNum; i<=endPageNum; i++){ %>
				<%if(i==pageNum){ %>
					<li class="page-item active">
						<a class="page-link" href="list.jsp?pageNum=<%=i%>"><%=i %></a>
					</li>
				
				<%}else{ %>
					<li class="page-item">
						<a class="page-link" href="list.jsp?pageNum=<%=i%>"><%=i %></a>
					</li>
				<%} %>
			<%} %>
			<%if(endPageNum < totalPageCount){ %>
				<li class="page-item">
					<a class="page-link" href="list.jsp?pageNum=<%=endPageNum+1%>">Next</a>
				</li>
			<%} %>
		</ul>
	</nav>
	<!-- filedao dynamic query 사용해야함. -->
	<form class="row g-3 justify-content-center" action="list.jsp" method="get">
		<div class="col-auto">
			<label for="condition">검색조건</label>
		</div>
		<div class="col-auto">
			<select class="form-control" style="width:200px" name="condition" id="condition">
				<option value="title_filename">제목+파일명</option>
				<option value="title">제목</option>
				<option value="writer">작성자</option>
			</select>
		</div>
		<div class="col-auto">
			<input class="form-control" style="width:500px" type="text" name="keyword" placeholder="검색어"/>
		</div>
		<div class="col-auto">
			<button class="btn btn-success" type="submit">검색</button>
		</div>
	</form>
	<br />
	<button class="btn btn-warning">
		<a href="${pageContext.request.contextPath}/index.jsp" style="color:white">인덱스로 돌아가기</a>
	</button>
</div>
<script>
	function deleteConfirm(num){
		let isDelete=confirm(num+"번 파일을 삭제 하시겠습니까?");
		if(isDelete){
			location.href="private/delete.jsp?num="+num;
		}
	}
</script>
</body>
</html>