package test.todo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import test.todo.dto.TodoDto;
import test.util.DbcpBean;

/*
 * application 전역에 대해서 Dao 객체는 * 오직 한번만 생성 *되는 구조로 바꾸어야 한다.
 * 웹 어플리케이션은 여러 Client 의 요청을 빠르게 처리해야하기 때문에 
 * 불필요한 Dao의 중복 생성은 웹 어플리케이션의 성능에 영향을 주기 때문이다.
 */

public class TodoDao {//이 3가지 원칙만 지키면 dao객체는 오직 한번만 생성되는 구조가 된다.
	//1. 자신의 객체를 담을 static 필드 선언
	private static TodoDao dao;
	
	//2. 외부에서 객체 생성이 불가 하도록 생성자의 접근 지정자를 private로 
	private TodoDao() {} //TodoDao new 불가 ,TodoDao dao=TodoDao.getInstance(); 해서 받아가야함.
	
	//3. 자신의 참조값을 리턴해주는 public static 메소드 정의
	public static TodoDao getInstance() {
		if(dao==null) {//getInstance()메소드가 최초 호출되는 경우
			dao=new TodoDao();//객체를 생성해서 참조값을 static 필드에 저장한다.
		}
		//static 필드에 저장된 참조값을 리턴해준다.
		return dao;
	}
	//참조값을 Instance라고도 부른다.
	
	//할일 목록을 리턴해주는 메소드
	public List<TodoDto> getList(TodoDto dto){
		
		List<TodoDto> list=new ArrayList<TodoDto>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();//DbcpBean()을 설계한다면 여기서 DB를 추출한다. 이거 빼고는 Dao 작성법과 똑같음. 
			//select 문 작성
			String sql = "SELECT *" + 
					"	FROM" + 
					"		(SELECT result1.*, ROWNUM AS rnum" + 
					"		FROM" + 
					"			(SELECT num,content,regdate" + 
					"			FROM todo" + 
					"			ORDER BY num DESC) result1)" + 
					"	WHERE rnum BETWEEN ? AND ?";
			pstmt=conn.prepareStatement(sql);
			//? 에 바인딩 할 게 있으면 여기서 바인딩 한다.
			pstmt.setInt(1, dto.getStartRowNum());
			pstmt.setInt(2, dto.getEndRowNum());
			//select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			//while문 혹은 if문에서 ResultSet으로부터 data 추출
			/*
			 * 로우가 1개면 if문
			 * 여러개면 while문
			 */
			while (rs.next()) {
				TodoDto tmp=new TodoDto();
				tmp.setNum(rs.getInt("num"));
				tmp.setContent(rs.getString("content"));
				tmp.setRegdate(rs.getString("regdate"));
				list.add(tmp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {

			}
		}
		
		return list;
	}
	
	//전체 row의 갯수를 리턴하는 메소드
	public int getCount() {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();//DbcpBean()을 설계한다면 여기서 DB를 추출한다. 이거 빼고는 Dao 작성법과 똑같음. 
			//select 문 작성 (별칭두는 이유 갖고올때 칼럼명으로 가져가야 함)
			String sql = "select nvl(max(rownum),0) as num" + 
					" from todo";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩 할 게 있으면 여기서 바인딩 한다.

			//select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			//while문 혹은 if문에서 ResultSet으로부터 data 추출
			/*
			 * 로우가 1개면 if문
			 * 여러개면 while문
			 */
			if (rs.next()) {
				count=rs.getInt("num");//별칭 칼럼명 적기
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {

			}
		}
		return count;
	}
	
	//할일 목록 1개를 리턴하는 메소드
	public TodoDto getData(int num) {
		TodoDto dto=null;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			conn=new DbcpBean().getConn();
			String sql="SELECT content, regdate"
					+ " FROM todo"
					+ " WHERE num=?";
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto=new TodoDto();
				dto.setNum(num);
				dto.setContent(rs.getString("content"));
				dto.setRegdate(rs.getString("regdate"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		return dto;
	}
	
	//할일 목록 추가하기
	public boolean insert(TodoDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;

		try {
			conn = new DbcpBean().getConn();
			//실행할 insert, update, delete 문 구성
			String sql = "INSERT INTO todo (num, content, regdate) VALUES(todo_seq.NEXTVAL,?,SYSDATE)";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 바인딩 한다.
			pstmt.setString(1, dto.getContent());
			flag = pstmt.executeUpdate();//sql 문 실행하고 변화된 row 갯수 리턴 받기
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		if (flag > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	//할일 목록 수정하기
	public boolean update(TodoDto dto) {
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		int flag=0;
		
		try {
			conn=new DbcpBean().getConn();
			String sql="UPDATE todo"
					+ " SET content=?, regdate=SYSDATE"
					+ " WHERE num=?";
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getContent());
			pstmt.setInt(2, dto.getNum());
			
			flag=pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			}catch(Exception e) {}
		}
		if(flag>0) {
			return true;
		}else {
			return false;
		}
	}
	
	//할일 목록 삭제하기
	public boolean delete(TodoDto dto) {
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		int flag=0;
		
		try {
			conn = new DbcpBean().getConn();
			String sql = "DELETE from todo WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getNum());
			flag = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		if (flag > 0) {
			return true;
		} else {
			return false;
		}
	}

}
