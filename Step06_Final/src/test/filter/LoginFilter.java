package test.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//web.xml 필터 설정 대신에 annotation 을 활용해서 필터를 동작하게 할 수도 있다. web.xml 로그인 필터 설정 삭제하고 만듦. 필터 동작 확인.
//로그인 해야만 응답하는 필터
@WebFilter(urlPatterns = {"/users/private/*","/cafe/private/*","/file/private/*"})
public class LoginFilter implements Filter{
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	//필터가 동작되면 호출되는 메소드
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException{
		//1. 로그인된 클라이언트인지 확인한다. (부모타입이라 request.getsession 을 찾을 수 없으니 캐스팅 해야한다.)
		
		//부모 type을 자식 type으로 casting!
		HttpServletRequest req=(HttpServletRequest)request;
		//자식 type을 이용해서 HttpSession 객체의 참조값을 얻어낸다.
		HttpSession session=req.getSession();
		//로그인된 아이디가 있는지 읽어와 본다.
		String id=(String)session.getAttribute("id");
		//만일 로그인 된 상태라면
		
		if(id!=null) {
			//2. 만일 로그인을 했으면 관여하지 않고 요청의 흐름을 이어간다.
			chain.doFilter(request, response);
		}else {
			//3. 로그인을 하지 않았으면 로그인 폼으로 이동할 수 있도록 *리다일렉트 응답*을 준다.
			String cPath=req.getContextPath();
			//ServletResponse type을 HttpServletResponse type 으로 casting
			HttpServletResponse res=(HttpServletResponse)response;
			res.sendRedirect(cPath+"/users/loginform.jsp");//리다일렉트 객체(요청을 다시 하라는 응답)
			//다시 요청할 경로를 주고 있음
			//sendRedirect() 자체가 응답.
			//로그인 성공 후에 가야할 목적지 정보를 갖고가는 로직처리를 해야함.
		}
	}
		

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		
	}
	
}
