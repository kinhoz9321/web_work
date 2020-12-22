package test.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.net.httpserver.HttpsServer;

@WebServlet("/ya")// /를 빼먹는 실수를 많이 한다. /없으면 서버가 시작도 안한다. / 반드시 있어야 함.
public class YaServlet extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//문자열을 출력할 때 getWriter , printWriter로 받아준다.
		PrintWriter pw=resp.getWriter();
		pw.print("ho"); //println 은 개행기호를 같이 출력해준다.
		
		/*
		 * flush는 close 하면 flush 안된게 자동으로 flush 한 다음 닫는다.
		 * 따라서 close 할거면 flush는 생략 가능
		 */
		pw.flush();
		pw.close();
		
	}
}
/*
 * 서버가 스타트 되어있는 상태에서 코딩을 하면 서버는 모른다.
 * 시작되는 시점에 저 코딩이 없었으니까
 * 그러니 서버를 껐다가 다시 시작해야 함. 
 *
 */