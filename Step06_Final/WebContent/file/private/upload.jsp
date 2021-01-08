<%@page import="java.io.File"%>
<%@page import="test.file.dao.FileDao"%>
<%@page import="test.file.dto.FileDto"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//Tomcat 서버를 실행했을 때 WebContent/upload 폴더의 실제 경로 얻어오기
	//운영체제마다 경로가 달라진다. 하지만 application.getRealPath()메소드를 사용하면 알아서 리턴해준다. 
	String realPath=application.getRealPath("/upload"); //realPath 설정! ** 신경쓰자 **
	System.out.println("realPath:"+realPath);
	
	File f=new File(realPath);
	if(!f.exists()){
		f.mkdir();
	}
	//최대 업로드 사이즈 설정
	int sizeLimit=1024*1024*50; //50 MByte
	/*
		WEB-INF/lib/cos.jar 라이브러리가 있으면 아래의 객체를 생성할 수 있다.
		//5개 인자 전달
		new MultipartRequest(HttpServletRequest 객체,
				업로드된 파일을 저장할 절대경로,
				최대 업로드 사이즈 제한,
				인코딩 설정,
				DefaultFileRenamePolicy 객체)
		
		MultipartRequest 객체가 성공적으로 생성이 된다면 업로드된 파일에 대한 정보도 추출할 수 있다.
		
		파일을 추출할 때는 꼭 MultipartRequest 객체를 이용한다.
		mr.getParameter("title") vs request.getParameter("title")
	*/
	//<form enctype="multipart/form-data"> 로 전송된 값은 아래의 객체를 이용해서 추출한다.
	MultipartRequest mr=new MultipartRequest(request,
			realPath, //신경써야 하는 것 , 나머지는 그냥 전달하면 되는 것
			sizeLimit,
			"utf-8",
			new DefaultFileRenamePolicy());//알아서 파일명을 바꿔주는 객체
	//폼전송된 내용 추출하기
	String title=mr.getParameter("title");
	String orgFileName=mr.getOriginalFileName("myFile");//원본파일명
	String saveFileName=mr.getFilesystemName("myFile");//저장된 파일명
	long fileSize=mr.getFile("myFile").length();//파일의 크기(byte 타입 - byte 타입은 꽤 크기 때문에 long 타입을 쓴다.)

	System.out.println("title:"+title);
	System.out.println("orgFileName:"+orgFileName);//파일 목록을 저장할 때 사용
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
cos.jar 에 있는 것 *** 중요!

C:\Users\kinhoz\Desktop\web_work\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Step06_Final\upload
-톰캣이 진짜 사용하는 경로. 물리적 웹컨텐트.

같은 파일을 여러번 넣으면 원본파일명과 저장된 파일명이 달라진다. 파일이 여러개 생기면서 test1.png, test2.png 이런 식으로 번호가 붙음.

파일은 upload 폴더에 저장을 하고, 정보는 DB에 저장을 하겠다.

보여지는건 originalfilename이고 서버에 저장되는건 중복명일경우엔 다른 명칭으로 저장된다.
String orgFileName=mr.getOriginalFileName("myFile");//원본파일명
String saveFileName=mr.getFilesystemName("myFile");//저장된 파일명

*강사님 그림 참고 - 머릿속에 그림 이해하기*
HDD(하드 디스크) 가 file system이다. (SSD) HDD랑 같은 말인가?

클라이언트 컴퓨터 파일시스템에 있는 어떤 파일이 서버 컴퓨터의 파일시스템에 저장된다.
클 컴 파일시스템에 파일을 웹브라우저로 읽어내서 멀티파트리퀘스트로 읽어내고 
파일은 파일시스템(upload폴더)에 저장하고, 파일의 업로드에 대한 정보는 DB에 저장한다.

(목적 : 클라이언트 컴에 있는 파일을 서버 컴에 저장 한다. 
input type파일이 있는 폼을 통해서 옮기고, 추출하는 객체
(ex. mr.getParameter, request.getParameter)를 이용해서 추출 및 저장한다.)

응답은 저장성공, 저장실패. 이런 걸 해준다는 뜻.

--%>