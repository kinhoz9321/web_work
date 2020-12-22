package test.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 *	/hello 요청에 대해 응답을 할 서블릿 정의하기
 *	1. HttpServlet 클래스를 상속 받는다. (원칙)
 *	2. service() 메소드를 오버라이드 한다. ser ctrl+space
 *	3. 어떤 요청을 처리할지 어노테이션(@WebService)을 클래스 위에 작성한다.
 */

//("/hello") 라는 요청이 들어오면 오버라이드 메소드 안에서 응답하겠다., 요청 경로.
@WebServlet("/hello")
public class HelloServlet extends HttpServlet{
	
	//HttpServlet 상속 받아서 노란색 service 메소드 찾기
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//인자가 2개 있는데 어떤 동작을 할지만 우리가 결정한다.
		
		//클라이언트에게 문자열을 출력할 수 있는 객체의 참조값 얻어오기
		PrintWriter pw=resp.getWriter();
		
		//클라이언트에게 문자열 출력하기
		pw.print("2 dong ryul"); //나중에는 DB에 있는 내용도 끌어다가 입력을 할것. form 전송도 가능.
		
		/*
		 * 클라이언트가 요청만 하는 게 아니고 어떤 것을 전송도 한다.
		 * 그러면 전송한 것을 읽어내서 insert, update, delete 해야하기도 한다.
		 * sql, javascript 다 복습해야함. 바쁘네...?ㅠ
		 * 전송과 응답 배울 것. 
		 * 부분 프로그래밍.
		 * 호출뿐만이 아니라 필요한 객체의 참조값도 전달한다.
		 * 인자. 필요한 도구를 사용해라. 그러면 전달해줄게.
		 * 우리는 도구의 사용법을 배워서 쓴다. 
		 * 우리의 자유도는 초록색 박스 안. 자동차 부품을 납품하는 일. 설계도만 납품.
		 * 우리는 헤드라이트를 만드는데
		 * 헤드라이트 안의 전구는 service 메소드라고 볼 수 있다. 
		 * main 메소드가 존재하는 건 처음부터 다 만드는 것
		 * 
		 * 예를 들어 채팅시스템이라고 치면 나머지 다 빼고
		 * actionPerformed 만 작성하는 느낌
		 * 일부분의 미완성을 채워넣는다고 생각하면 된다. 
		 */
		
		pw.flush();//flush 가 뭔가?
		pw.close();
		
	}
}
/*
 * 이제 우리는 main 메소드를 쓰지 않는다.
 * 서버를 실행하면 시작되는데, 굳이 알 필요가 없다.
 * 
 * 우리가 만든 servlet이 톰캣서버에서 특별한 일을 해야한다.
 * servlet=클라이언트의 요청을 처리할 수 있는 객체
 * 
 * 우리가 만든 서블릿이 웹브라우저의 부품이 되게 해야한다.
 * 그러므로 마음대로 만들 수 없고, 형식에 맞게 만들어야 한다.
 * 
 * 규격을 맞추는 방법
 * implements 를 구현하거나, class를 extends(상속) 받는 것.
 * 
 * 우리는 중요한 부품의 설계도를 납품한다고 생각하면 된다.
 * 
 * 서버 우클릭 add and remove를 통해서 서비스를 실행하기도 하고, 실행하지 못하게 하기도 한다. 
 * 
 * http://localhost:8888/Hello/index.html - 주소창 분해! 알아두기!
 * 1. localhost:8888 : 특정 컴퓨터를 찾아가기
 * 2. /Hello : context path 프로젝트를 찾아가기 위한 경로
 * 3. /index.html : 순수 요청 경로
 * 
 *	/hello 를 요청했을 때 응답을 했다는 것은
 *	누군가 
 *	HttpServlet s=new HelloServlet();
 *	s.service( );
 *	을 했다는 것
 *	누군가=톰캣
 *
 *	HttpServletRequest req, HttpServletResponse resp 사용법 배우기
 */
