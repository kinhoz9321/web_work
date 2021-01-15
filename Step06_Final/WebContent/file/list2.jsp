<%@page import="test.file.dao.FileDao"%>
<%@page import="java.util.List"%>
<%@page import="test.file.dto.FileDto"%>
<%@page import="java.net.URLEncoder"%>
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
	
	//특수기호를 인코딩한 키워드를 미리 준비한다.
	String encodedK=URLEncoder.encode(keyword);
	
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
			//제목+파일명 검색일 때 호출하는 메소드를 이용해서 목록 얻어오기
			list=FileDao.getInstance().getListTF(dto);
			//제목+파일명 검색일 때 호출하는 메소드를 이용해서 row 의 갯수 얻어오기
			totalRow=FileDao.getInstance().getCountTF(dto);
			
		}else if(condition.equals("title")){//제목 검색인 경우
			dto.setTitle(keyword);
			list=FileDao.getInstance().getListT(dto);
			totalRow=FileDao.getInstance().getCountT(dto);
		
		}else if(condition.equals("writer")){//작성자 검색인 경우
			dto.setWriter(keyword);
			list=FileDao.getInstance().getListW(dto);
			totalRow=FileDao.getInstance().getCountW(dto);
			
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
	
	//request 영역에 담아서 활용
	request.setAttribute("list", list);
	request.setAttribute("pageNum", pageNum);
	request.setAttribute("startPageNum", startPageNum);
	request.setAttribute("endPageNum", endPageNum);
	request.setAttribute("totalPageCount", totalPageCount);
	request.setAttribute("condition", condition);
	request.setAttribute("keyword", keyword);
	request.setAttribute("encodedK", encodedK);
	request.setAttribute("totalRow", totalRow);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
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
				<a href="${pageContext.request.contextPath }/">Home</a>
			</li>
			<li class="breadcrumb-item active">자료실 목록</li>
		</ul>
	</nav>
	<a href="private/upload_form.jsp">업로드 하러가기</a>
	<h1>자료실 목록 입니다.</h1>
	<table class="table table-striped">
		<thead class="thead-dark">
			<tr>
				<th>번호</th>
				<th>작성자</th>
				<th>제목(설명)</th>
				<th>파일명</th>
				<th>크기</th>
				<th>등록일</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="tmp" items="${requestScope.list }">
			<tr>
				<td>${tmp.num }</td>
				<td>${tmp.writer }</td>
				<td>${tmp.title }</td>
				<td><a href="download.jsp?num=${tmp.num }">${tmp.orgFileName }</a></td>
				<td>${tmp.fileSize }</td>
				<td>${tmp.regdate }</td>
				<td>
					<c:if test="${tmp.writer eq sessionScope.id }">
						<a href="javascript:deleteConfirm(${tmp.num });">삭제</a>
					</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<nav>
		<ul class="pagination justify-content-center">
			<c:choose>
				<c:when test="${startPageNum ne 1 }">
					<li class="page-item">
						<a class="page-link" href="list2?pageNum=${startPageNum-1 }&condition=${condition }&keyword=${encodedK }">Prev</a>
					</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
						<a class="page-link" href="javascript:">Prev</a>
					</li>
				</c:otherwise>
			</c:choose>
			<c:forEach var="i" begin="${startPageNum }" end="${endPageNum }">
				<c:choose>
					<c:when test="${i eq pageNum }">
						<li class="page-item active">
							<a class="page-link" href="list2?pageNum=${i }&condition=${condition }&keyword=${encodedK }">${i }</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a class="page-link" href="list2?pageNum=${i }&condition=${condition }&keyword=${encodedK }">${i }</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:choose>
				<c:when test="${endPageNum lt totalPageCount }">
					<li class="page-item">
						<a class="page-link" href="list2?pageNum=${endPageNum+1 }&condition=${condition }&keyword=${encodedK }">Next</a>
					</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
						<a class="page-link" href="javascript:">Next</a>
					</li>
				</c:otherwise>
			</c:choose>
		</ul>
	</nav>
	<form action="flie/list2" method="get">
		<label for="condition">검색조건</label>
		<select name="condition" id="condition">
			<option value="title_filename" ${condition eq 'title_filename' ? 'selected' : '' }>제목+파일명</option>
			<option value="title" ${condition eq 'title' ? 'selected' : '' }>제목</option>
			<option value="writer" ${condition eq 'writer' ? 'selected' : '' }>작성자</option>
		</select>
		<input type="text" name="keyword" placeholder="검색어..." value="${keyword }"/>
		<button type="submit">검색</button>
	</form>
	<%-- 만일 검색 키워드가 존재한다면 몇개의 글이 검색 되었는지 알려준다. --%>
	<c:if test="${not empty keyword }">
		<div class="alert alert-success">
			<strong>${totalRow }</strong> 개의 자료가 검색되었습니다.
		</div>
	</c:if>
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