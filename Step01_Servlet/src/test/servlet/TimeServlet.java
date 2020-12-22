package test.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/time")//new TimeServlet 을 요청함으로 응답함.
public class TimeServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//응답 인코딩 설정
		resp.setCharacterEncoding("utf-8"); //한글 설정
		
		//응답 컨텐츠 type 설정 (웹브라우저에 어떤 컨텐츠를 응답할 것인지 알려서 준비를 시킨다.)
		resp.setContentType("text/html;charset=utf-8"); //html 파일을 응답할 것이다. 알려줘야함. 준비하고 받아라.
		
		
		//클라이언트에게 출력할 수 있는 객체의 참조값 얻어오기
		PrintWriter pw=resp.getWriter();
		pw.println("<!doctype html>");
		pw.println("<html>");
		pw.println("<head>");
		pw.println("<meta charset='utf-8'/>");
		pw.println("<title>현재 시간 페이지</title>");
		pw.println("</head>");
		pw.println("<body>");
		//날짜 객체를 생성해서 (다이나믹한 부분) 틀은 정해져있는데 그 틀 안의 내용은 다이나믹 하다. 
		//저 다이나믹한 부분을 우리가 자바 jsp로 하겠다. 
		Date d=new Date();
		//현재(service() 메소드가 호출되는 시점) 날짜시간 정보를 문자열로 얻어낸다.
		String info=d.toString();
		//얻어낸 문자열을 html 문서에 끼워넣어서 출력한다.
		//info 참조값얻어내서 저기에 껴주는거까지 톰캣이 한 것. 이클립스는 코딩 편집을 도와주는 것 뿐.
		//어떤 로직의 결과 데이터를 html 문서의 원하는 위치에 끼워넣어서 출력을 할 수 있다. info 처럼.
		/* 
		 * 그 얘기는 얼마든지 DB에 있는 내용을 Select해서 호출되는 시점에 넣어줄 수 도 있다는 것.
		 * html 문서(index.html)에서는 자바 코딩을 할 수 없다. 하게되면 그냥 문자열로 출력됨.
		 * servlet은 자바 코딩을 할 수 있다는데에 의의가 있다. 
		 * 웹페이지의 바뀌는 부분은 dynamic. DB에 있다. 
		 * DB에 있는 내용을 select 해서 출력하고 있는 것.
		 * 그러기 위해선 프로그래밍 언어가 필요하다.
		 * 내용을 바꾸려면 DB가 필요하다. 
		 * 안바뀌는 부분보다 바뀌는 부분이 더 많다. 
		 */
		pw.println("<p>현재 시간 : "+info+" </p>");
		
		//상대 경로로 /WebContent/images/kim1.png 출력하기
		pw.println("<img src='images/kim1.png'/>");//최상위 경로 기준
		/* 
		 * 톰캣 서버가 img src='images/kim1.png' 문자열을 웹브라우저에게 주었다.
		 * 하지만 웹브라우저는 이미지로 출력함. 
		 * 웹브라우저가 경로를 찾아서 파일을 가져간다?
		 * 
		 * 톰캣서버가 html string 으로 이미지 파일을 준다. 이미지는 바이트 알갱이로 이루어져 있다.
		 * 웹브라우저는 자동으로 톰캣에서 요청한다.
		 * 현재 경로 /time 대신에 /images/kim.png를 요청한다.
		 * WebContent/
		 * 톰캣은 웹브라우저에게 images 바이트 알갱이를 가져다 준다.
		 * 시간이 걸린다. 이미지 큰 것들은 조금조금씩 완성되기도 하잖아. 바이트를 옮겨오고 있기 때문임.
		 * 웹브라우저는 해석하면서도 뒤로 서버에게 다시 요청하기도 한다.
		 * ex)이미지
		 * http://localhost:8888/Step01_Servlet/images/kim1.png
		 * 톰캣서버는 김구라 이미지만 응답해준다. 물리적 파일을 읽어줌.
		 * 
		 * http://localhost:8888/Step01_Servlet/css/bootstrap.css
		 * /css/bootstrap.css 서버에 이런 요청을 해서 받아냄.
		 */
		pw.println("</body>");
		pw.println("</html>");
		pw.close();
		
	}
}
/*
 * 여기서 run 하는 건 아니다. index에서 run하기.
 * ??는 한글이 깨졌다는 뜻.
 * 
 * 
 */
