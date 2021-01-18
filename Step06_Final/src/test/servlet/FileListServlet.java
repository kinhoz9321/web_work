package test.servlet;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import test.file.dao.FileDao;
import test.file.dto.FileDto;

@WebServlet("/file/list3")
public class FileListServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		//한 페이지에 몇개씩 표시할 것인지
		final int PAGE_ROW_COUNT=5;
		//하단 페이지를 몇개씩 표시할 것인지
		final int PAGE_DISPLAY_COUNT=5;

		//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
		int pageNum=1;
		//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
		String strPageNum=request.getParameter("pageNum");
		//만일 페이지 번호가 파라미터로 넘어 온다면
		if(strPageNum != null){
			//숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
			pageNum=Integer.parseInt(strPageNum);
		}

		//보여줄 페이지의 시작 ROWNUM
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지의 끝 ROWNUM
		int endRowNum=pageNum*PAGE_ROW_COUNT;

		/*
			[ 검색 키워드에 관련된 처리 ]
			-검색 키워드가 파라미터로 넘어올수도 있고 안넘어 올수도 있다.		
		*/
		String keyword=request.getParameter("keyword");
		String condition=request.getParameter("condition");
		//만일 키워드가 넘어오지 않는다면 
		if(keyword==null){
			//키워드와 검색 조건에 빈 문자열을 넣어준다. 
			//클라이언트 웹브라우저에 출력할때 "null" 을 출력되지 않게 하기 위해서  
			keyword="";
			condition=""; 
		}

		//특수기호를 인코딩한 키워드를 미리 준비한다. 
		String encodedK=URLEncoder.encode(keyword);

		//startRowNum 과 endRowNum  을 FileDto 객체에 담고
		FileDto dto=new FileDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);

		//ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
		List<FileDto> list=null;
		//전체 row 의 갯수를 담을 지역변수를 미리 만든다.
		int totalRow=0;
		//만일 검색 키워드가 넘어온다면 
		if(!keyword.equals("")){
			//검색 조건이 무엇이냐에 따라 분기 하기
			if(condition.equals("title_filename")){//제목 + 파일명 검색인 경우
				//검색 키워드를 FileDto 에 담아서 전달한다.
				dto.setTitle(keyword);
				dto.setOrgFileName(keyword);
				//제목+파일명 검색일때 호출하는 메소드를 이용해서 목록 얻어오기 
				list=FileDao.getInstance().getListTF(dto);
				//제목+파일명 검색일때 호출하는 메소드를 이용해서 row  의 갯수 얻어오기
				totalRow=FileDao.getInstance().getCountTF(dto);
			}else if(condition.equals("title")){ //제목 검색인 경우
				dto.setTitle(keyword);
				list=FileDao.getInstance().getListT(dto);
				totalRow=FileDao.getInstance().getCountT(dto);
			}else if(condition.equals("writer")){ //작성자 검색인 경우
				dto.setWriter(keyword);
				list=FileDao.getInstance().getListW(dto);
				totalRow=FileDao.getInstance().getCountW(dto);
			} // 다른 검색 조건을 추가 하고 싶다면 아래에 else if() 를 계속 추가 하면 된다.
		}else{//검색 키워드가 넘어오지 않는다면
			//키워드가 없을때 호출하는 메소드를 이용해서 파일 목록을 얻어온다. 
			list=FileDao.getInstance().getList(dto);
			//키워드가 없을때 호출하는 메소드를 이용해서 전제 row 의 갯수를 얻어온다.
			totalRow=FileDao.getInstance().getCount();
		}

		//하단 시작 페이지 번호 
		int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		//하단 끝 페이지 번호
		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;


		//전체 페이지의 갯수 구하기
		int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
		//끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
		if(endPageNum > totalPageCount){
			endPageNum=totalPageCount; //보정해 준다. 
		}	

		// jsp 페이지에서 필요한 데이터를 request 영역에 담고 
		request.setAttribute("list", list);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("startPageNum", startPageNum);
		request.setAttribute("endPageNum", endPageNum);
		request.setAttribute("totalPageCount", totalPageCount);
		request.setAttribute("condition", condition);
		request.setAttribute("keyword", keyword);
		request.setAttribute("encodedK", encodedK);
		request.setAttribute("totalRow", totalRow);
		// jsp 페이지로 forward 이동해서 응답한다.
		RequestDispatcher rd=request.getRequestDispatcher("/file/list3.jsp");
		rd.forward(request, response);
	}
}