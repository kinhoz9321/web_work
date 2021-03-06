<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%-- json 응답할 때는 application/json 주석 ! 쓰면 에러남. json 에러. 주의하기 --%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
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
	//업로드 된 이미지 파일의 저장 경로만 json으로 응답하면 된다.
	String saveFileName=mr.getFilesystemName("image");
	String imagePath="/upload/"+saveFileName;
%>
{"imagePath":"<%=imagePath %>"}