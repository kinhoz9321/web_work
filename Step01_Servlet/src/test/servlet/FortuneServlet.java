package test.servlet;
/*
 * 오늘의 운세를 html 형식으로 출력하는 서블릿을 만들어 보세요.
 * 오늘의 운세는 필드에 저장된 배열의 내용 중에서 1개가 랜덤하게 출력되도록 하세요.
 * 
 * - hint
 * Random ran=new Random();
 * int index=ran.nextInt(5);
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/sub/fortune")//sub라는 폴더는 존재하지 않지만 sub폴더 안에 있는 fortune.html 같은 느낌을 준다.
public class FortuneServlet extends HttpServlet{
	String[] list= {
			"동쪽으로 가면 2 동렬을 만나요",
			"서쪽으로 가면 3 동렬을 만나요",
			"남쪽으로 가면 4 동렬을 만나요",
			"북쪽으로 가면 5 동렬을 만나요",
			"로또를 사면 2등이 당첨되요"
	};
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//응답 인코딩 설정
		resp.setCharacterEncoding("utf-8"); 
		resp.setContentType("text/html;charset=utf-8");
		
		//클라이언트에게 출력할 수 있는 객체의 참조값 얻어오기
		PrintWriter pw=resp.getWriter();
		pw.println("<!doctype html>");
		pw.println("<html>");
		pw.println("<head>");
		pw.println("<meta charset='utf-8'/>");
		pw.println("<title>오늘의 운세</title>");
		pw.println("</head>");
		pw.println("<body>");
		
		//배열의 인덱스로 사용할 정수를 랜덤하게 얻어낸다.(랜덤 객체 만들기) 
		Random ran=new Random();
		//0~4 사이의 랜덤한 정수
		int index=ran.nextInt(5);//? nextInt?
		//오늘의 운세
		String fortuneToday=list[index]; 
		//String type 으로 안받고 list[index]를 바로 fortuneToday 자리에 넣어줘도 된다.
		pw.println("<p>오늘의 운세 : "+fortuneToday+" </p>");
		//상대경로로 kim1.png 이미지를 출력하도록 해보세요.
		pw.println("<img src='../images/kim1.png'/>");
		
		/*
		 * "/sub/fortune"
		 * /sub/ 때문에 상위경로로 나가서 가져와야 한다.
		 * ../ 한단계 위로 올라가기 - root 로 간다.
		 * 두단계 위로 올라가기 ../../
		 * images/kim1.png'
		 * 그냥 이렇게 하게 되면 sub 폴더 안의 image 파일을 찾게 된다. 서버가.
		 * 
		 * sub는 가상의 폴더? 뎁스? 경로에 있는 이름이 반드시 폴더로 존재하는 건 아니다.*중요!*
		 * 
		 * <img src='../images/kim1.png'/> 이게 왜 이미지인가?
		 * 웹브라우저가 요청해서 다시 출력 받아와서 현상하는 것 이라고 이해하기
		 * 
		 */
		
		pw.println("</body>");
		pw.println("</html>");
		pw.close();
	}
	
}
/*
 * http://localhost:8888/Step01_Servlet/sub/fortune
 * sub라는 폴더는 존재하지 않지만 sub폴더 안에 있는 fortune.html 같은 느낌을 준다.
 * 
 * Java Server Page = jsp
 * java+html
 * 
 * 회색 동그라미 L은 지역변수라는 의미
 */
