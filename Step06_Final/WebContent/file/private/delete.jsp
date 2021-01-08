<%@page import="java.io.File"%>
<%@page import="test.file.dao.FileDao"%>
<%@page import="test.file.dto.FileDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1. GET 방식 전달되는 삭제할 파일 번호를 읽어온다.
	int num=Integer.parseInt(request.getParameter("num"));
	//2. DB 에서 해당 파일의 정보를 읽어온다.
	FileDto dto=FileDao.getInstance().getData(num);
	
	//만일 로그인된 아이디와 글 작성자가 다르면 에러를 응답한다. (필터로도 할 수 있고, 직접 할 수도 있다.)
	String id=(String)session.getAttribute("id"); //로그인된 아이디를 읽어온다.
	if(!dto.getWriter().equals(id)){
		response.sendError(HttpServletResponse.SC_FORBIDDEN, "남의 파일 지우면 혼난당!");//(숫자, 오류메세지)403 금지된 코드(남의 파일을 지우면 안되기 때문)
		return;//메소드 종료
	}
	//3. DB 에서 파일 정보를 삭제한다.
	FileDao.getInstance().delete(num);
	//4. 파일 시스템(upload 폴더)에 저장된 파일을 삭제한다.
	//삭제할 파일의 절대 경로
	String path=application.getRealPath("/upload")+File.separator+File.separator+dto.getSaveFileName();
	
	//삭제할 파일을 access 할 수 있는 File 객체 생성
	File file=new File(path);
	if(file.exists()){
		file.delete();
	}
	//5. 응답한다.
	String cPath=request.getContextPath();
	response.sendRedirect(cPath+"/file/list.jsp");//리다일렉트 응답을 하기 때문에 HTML 문서는 필요가 없다.
%>

<%--
어떻게 하면 아무나 삭제하는 걸 방지할 수 있을까?

"\" - 윈도우 \xxxx\xxxx\upload\xxx.jpg
"/" - 리눅스 /xxxx/xxxx/upload/xxx.jpg
스테틱 필드 File.separator - 운영체제에 맞게끔 알아서 파일 구분자를 반환한다.(오류가 나지 않도록)
--%>