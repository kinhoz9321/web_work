package test.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/send")//3.웹서버가 이런 요청을 하게 되면
public class SendServlet extends HttpServlet{//1.
	//2. 응답은 여기서 한다.
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//클라이언트가 요청과 함께 전송한 문자열을 추출하기
		String line=req.getParameter("msg");
		System.out.println("클라이언트가 전송한 문자열 : "+line);
		/*
		 * 클라이언트가 폼을 활용해서 문자열을 전송할 수 있음을 확인
		 * action="send" - @WebServlet("/send")
		 * name="msg" - req.getParameter("msg");
		 * 연관성 알아두기
		 * 
		 * 액션 속성의 value 가 요청명이 된다. 
		 */
		
		//간단한 문자열 응답하기
		PrintWriter pw=resp.getWriter();
		pw.println("/send okay~");
		pw.close();
	}
}
/*
 * 내가 서버역할인지 클라이언트인지 확실히 구분하기
 * 그래야 나중에 두가지가 합쳐진 이상한 코딩을 하지 않는다.
 * 
 * 클라이언트가 요청 뿐만 아니라 hello라는 문자열도 전송을 했다.
 * 그걸 서블릿이 추출할 수 있지 않을까? 가능.
 * 
 * *기억하기*
 * 폼전송은 Servlet에서도 추출할 수가 있고,
 * jsp에서도 추출할 수가 있다.
 * 
 * 폼 전송 자체가 페이지 이동을 야기시킨다.
 * 폼 전송을 하는 것 자체가 페이지 이동이 필요하다.
 * 
 * 
 */
