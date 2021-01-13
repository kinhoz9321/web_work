<%@page import="test.gallery.dao.GalleryDao"%>
<%@page import="test.gallery.dto.GalleryDto"%>
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
	int sizeLimit=1024*1024*10; //50 MByte
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
	//gallery/list.jsp 리다일렉트 되는거 만들기
	/*폼에 파라미터명 name속성이 caption과 name으로 되어있기 때문에 이렇게 씀.*/
	//이미지 설명
	String caption=mr.getParameter("caption");
	//원본파일명
	String orgFileName=mr.getOriginalFileName("image");
	//upload 폴더에 저장된 파일명
	String saveFileName=mr.getFilesystemName("image");//이미지를 출력하기 위해서는 이게 중요
	
	//업로드한 클라이언트의 아이디
	String writer=(String)session.getAttribute("id");
	//업로드된 파일 정보를 GalleryDto에 담아서
	GalleryDto dto=new GalleryDto();
	dto.setCaption(caption);
	dto.setImagePath("/upload/"+saveFileName);
	dto.setWriter(writer);
	//DB에 저장
	GalleryDao.getInstance().insert(dto);
	//목록 보기로 리다일렉트 이동 응답
	String cPath=request.getContextPath();
	response.sendRedirect(cPath+"/gallery/list.jsp");
%>