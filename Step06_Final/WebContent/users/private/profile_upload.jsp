<%@page import="test.users.dto.UsersDto"%>
<%@page import="test.users.dao.UsersDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
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
	int sizeLimit=1024*1024*5; //5 MByte(메가바이트)
	
	MultipartRequest mr=new MultipartRequest(request,
			realPath, //신경써야 하는 것 , 나머지는 그냥 전달하면 되는 것
			sizeLimit,
			"utf-8",
			new DefaultFileRenamePolicy());//알아서 파일명을 바꿔주는 객체
	
	//업로드된 이미지의 원본 파일명
	String orgFileName=mr.getOriginalFileName("image");
	//upload 폴더에 실제 저장된 파일명
	String saveFileName=mr.getFilesystemName("image");
	
	//로그인된 아이디
	String id=(String)session.getAttribute("id");
	//저장된 파일명을 이용해서 프로필 이미지 경로를 구성한다.
	String profile="/upload/"+saveFileName;
	//UsersDto 객체에 담아서
	UsersDto dto=new UsersDto();
	dto.setId(id);
	dto.setProfile(profile);
	//DB에 반영하기
	UsersDao.getInstance().updateProfile(dto);
	
	//개인정보 수정 페이지로 리다일렉트 (바로 프로필 사진이 들어가면서 개인정보 수정 페이지로 리다일렉트 된다.)
	String cPath=request.getContextPath();
	response.sendRedirect(cPath+"/users/private/updateform.jsp");
%>
<!-- 
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
	//MultipartRequest 이 객체가 잘 생성이 되면 업로드가 되고 업로드 된 정보는 mr(MultipartRequest())객체를 통해서 얻어오면 된다.)
	
	C:\Users\kinhoz\Desktop\web_work\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Step06_Final\upload
-톰캣이 진짜 사용하는 경로. 물리적 웹컨텐트. 이쪽에 파일이 저장됨.
 -->