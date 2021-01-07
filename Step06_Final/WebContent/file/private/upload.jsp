<%@page import="test.file.dao.FileDao"%>
<%@page import="test.file.dto.FileDto"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//Tomcat 서버를 실행했을 때 WebContent/upload 폴더의 실제 경로 얻어오기
	String realPath=application.getRealPath("/upload");
	System.out.println("realPath:"+realPath);
	//최대 업로드 사이즈 설정
	int sizeLimit=1024*1024*50; //50 MByte
	/*
		WEB-INF/lib/cos.jar 라이브러리가 있으면 아래의 객체를 생성할 수 있다.
		
		new MultipartRequest(HttpServletRequest 객체,
				업로드된 파일을 저장할 절대경로,
				최대 업로드 사이즈 제한,
				인코딩 설정,
				DefaultFileRenamePolicy 객체)
		
		MultipartRequest 객체가 성공적으로 생성이 된다면 업로드된 파일에 대한 정보도 추출할 수 있다.
	*/
	//<form enctype="multipart/form-data"> 로 전송된 값은 아래의 객체를 이용해서 추출한다.
	MultipartRequest mr=new MultipartRequest(request,
			realPath,
			sizeLimit,
			"utf-8",
			new DefaultFileRenamePolicy());//알아서 파일명을 바꿔주는 객체
	//폼전송된 내용 추출하기
	String title=mr.getParameter("title");
	String orgFileName=mr.getOriginalFileName("myFile");
	String saveFileName=mr.getFilesystemName("myFile");
	long fileSize=mr.getFile("myFile").length();
	System.out.println("title:"+title);
	System.out.println("orgFileName:"+orgFileName);//파일을 저장할 때 사용
	System.out.println("saveFileName:"+saveFileName);//파일을 다운로드 할 때 사용
	System.out.println("fileSize:"+fileSize);
	//작성자(로그인해야만 작성자을 할 수 있으니까 세션에서 찾기)
	String writer=(String)session.getAttribute("id");
	//업로드된 파일의 정보를 FileDto에 담고
	FileDto dto=new FileDto();
	dto.setWriter(writer);
	dto.setTitle(title);
	dto.setOrgFileName(orgFileName);
	dto.setSaveFileName(saveFileName);
	dto.setFileSize(fileSize);
	//DB에 저장하고
	boolean isSuccess=FileDao.getInstance().insert(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/file/upload.jsp</title>
</head>
<body>
	<%if(isSuccess){ %>
		<p>
			<%=writer %> 님이 업로드한 <%=orgFileName %> 파일을 저장했습니다.
			<a href="${pageContext.request.contextPath}/file/list.jsp">목록보기</a>
		</p>
	<%}else{ %>
		<p>
			업로드 실패
			<a href="upload_form.jsp">다시 시도</a>
		</p>
	<%} %>
</body>
</html>
<%--
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
cos.jar 에 있는 것

C:\Users\kinhoz\Desktop\web_work\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Step06_Final\upload
-톰캣이 진짜 사용하는 경로. 물리적 웹컨텐트.

같은 파일을 여러번 넣으면 원본파일명과 저장된 파일명이 달라진다. 파일이 여러개 생기면서 test1, test2 이런 식으로 번호가 붙음.

파일은 upload 폴더에 저장을 하고, 정보는 DB에 저장을 하겠다.
--%>