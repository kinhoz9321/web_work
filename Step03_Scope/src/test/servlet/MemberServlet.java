package test.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import test.member.dto.MemberDto;

@WebServlet("/member")
public class MemberServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//1. 회원 1명의 정보를 얻어오는 비즈니스 로직을 수행했다고 가정하자
		MemberDto dto=new MemberDto();
		dto.setNum(1);
		dto.setName("김구라");
		dto.setAddr("노량진");
		//2. 로직 수행결과 데이터(모델)을 request scope 에 담기
		//"dto" 라는 키값으로 MemberDto 객체 담기 *키값 중요!*
		//어떤 키값으로 어떤 타입의 값을 담았는지 기억할 것
		req.setAttribute("dto", dto);//오브젝트 타입으로 받아짐 (어떤 타입이든 다 가능)
		//3. jsp 페이지로 forward 이동해서 응답
		RequestDispatcher rd=req.getRequestDispatcher("/test/member.jsp");//forward 이동할 페이지 주소
		rd.forward(req, resp);//forward 이동할 때는 2개의 참조값을 전달해주어야 한다.
	}
}
