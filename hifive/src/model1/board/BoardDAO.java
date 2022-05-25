package model1.board;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBCConnect;

public class BoardDAO extends JDBCConnect {
	public BoardDAO(ServletContext application) {
		super(application);
	}
	
	// 검색 조건에 맞는 게시물의 개수를 반환
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0; // 결과(게시물 수)를 담을 변수
		
		// 게시물 수를 얻어오는 쿼리문 작성
		String query = "SELECT COUNT(*) FROM board";
		if (map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " " + " LIKE '%" + map.get("searchWord") + "%'";
		}
		
		try {
			stmt = con.createStatement(); // 정적 쿼리문 생성
			rs = stmt.executeQuery(query); // 쿼리 실행
			rs.next(); // 커서를 첫 번째 행으로 이동, 게시물 개수를 추출
			totalCount = rs.getInt(1); // 첫 번째 컬럼 값을 가져옴
		} catch (Exception e) {
			System.out.println("게시물 수를 구하는 중 예외 발생");
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	// 검색 조건에 맞는 게시물 목록 반환
	public List<BoardDTO> selectList(Map<String, Object> map) {
		List<BoardDTO> bbs = new Vector<BoardDTO>(); // 결과(게시물 목록)를 담을 변수
		
		String query = "SELECT * FROM board";
		if (map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " LIKE '%" + map.get("searchWord") + "%' ";
		}
		query += " ORDER BY num DESC";
		
		try {
			stmt = con.createStatement(); // 쿼리문 생성
			rs = stmt.executeQuery(query); // 쿼리 실행
			
			while (rs.next()) { // 결과를 순회하며
				BoardDTO dto = new BoardDTO(); // 한 행(게시물 하나)의 내용을 DTO에 저장
				
				dto.setNum(rs.getString("num")); // 일련번호
				dto.setTitle(rs.getString("title")); // 제목
				dto.setContent(rs.getString("content")); // 내용
				dto.setPostdate(rs.getDate("postdate")); // 작성일
				dto.setId(rs.getString("id")); // 작성자 아이디
				dto.setVisitcount(rs.getString("visitcount")); // 조회수
				
				bbs.add(dto); // 결과 목록에 저장
			}
		} catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		return bbs;	
	}
	
	// 검색 조건에 맞는 게시물 목록을 반환(페이징 기능 지원)
	public List<BoardDTO> selectListPage(Map<String, Object> map) {
		List<BoardDTO> bbs = new Vector<BoardDTO>(); // 결과(게시물 목록)를 담을 변수
		
		// 쿼리문 템플릿
		String query = " SELECT * FROM ( "
					+ " 	SELECT Tb.*, ROWNUM rNum FROM ( "
					+ " 		SELECT * FROM board ";
		
		// 검색 조건 추가
		if (map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " LIKE '%" + map.get("searchWord") + "%' ";
		}
		
		query += " 		ORDER BY num DESC"
				+ " 	) Tb"
				+ " ) "
				+ " WHERE rNum BETWEEN ? AND ?";
		
		try {
			// 쿼리문 완성
			psmt = con.prepareStatement(query);
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			
			// 쿼리문 실행
			rs = psmt.executeQuery();
			
			while (rs.next()) { // 결과를 순회하며
				BoardDTO dto = new BoardDTO(); // 한 행(게시물 하나)의 내용을 DTO에 저장
				
				dto.setNum(rs.getString("num")); // 일련번호
				dto.setTitle(rs.getString("title")); // 제목
				dto.setContent(rs.getString("content")); // 내용
				dto.setPostdate(rs.getDate("postdate")); // 작성일
				dto.setId(rs.getString("id")); // 작성자 아이디
				dto.setVisitcount(rs.getString("visitcount")); // 조회수
				
				bbs.add(dto); // 반환할 결과 목록에 게시물 추가
			}
		} catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		//목록 반환
		return bbs;	
	}
	
	// 게시글 데이터를 받아 DB에 추가
	public int insertWrite(BoardDTO dto) {
		int result = 0;
		
		try {
			// INSERT 쿼리문 작성
			String query = "INSERT INTO board ( "
					+ " num, title, content, id, visitcount) "
					+ " VALUES ( "
					+ "seq_board_num.NEXTVAL, ?, ?, ?, 0)";
			
			psmt = con.prepareStatement(query); //동적 쿼리
			psmt.setNString(1,  dto.getTitle());
			psmt.setNString(2,  dto.getContent());
			psmt.setNString(3,  dto.getId());
			
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	// 지정한 게시물을 찾아 내용을 반환
	public BoardDTO selectView(String num) {
		BoardDTO dto = new BoardDTO();
		
		// 쿼리문 준비
		String query = "SELECT B.*, M.name "
				+ " FROM member M INNER JOIN board B "
				+ " ON M.id=B.id "
				+ "WHERE num=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num); // 인파라미터를 일련번호로 설정
			rs = psmt.executeQuery(); // 쿼리 실행
			
			// 결과 처리
			if (rs.next()) {
				dto.setNum(rs.getString(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString(6));
				dto.setName(rs.getString("name"));
			}
		} catch (Exception e){
			System.out.println("게시물 상세보기 중 예외 발생");
			e.printStackTrace();
		}
		return dto;
	}
	
	// 지정한 게시물의 조회수를 1 증가시킴
	public void updateVisitCount(String num) {
		// 쿼리문 준비
		String query = "UPDATE board SET "
				+ " visitcount=visitcount+1 "
				+ " WHERE num=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num); // 인파라미터를 일련번호로 설정
			psmt.executeQuery(); // UPDATE 쿼리는 executeUpdate()를 사용하지만, 여기서는 적용된 행의 개수를 알 필요가 없기 때문에 executeQuery() 사용
		} catch (Exception e) {
			System.out.println("게시물 조회수 증가 중 예외 발생");
			e.printStackTrace();
		}
	}
	
	// 지정한 게시물을 수정
	public int updateEdit(BoardDTO dto) {
		int result = 0;
		
		// 쿼리문 준비
		String query = "UPDATE board SET "
				+ " title=?, content=? "
				+ " WHERE num=?";
		
		try {
			psmt = con.prepareStatement(query);
			
			// 쿼리문 완성
			psmt.setString(1, dto.getTitle());
			psmt.setString(2,  dto.getContent());
			psmt.setString(3, dto.getNum());
			
			// 쿼리문 실행
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("게시물 수정 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 지정한 게시물을 삭제
	public int deletePost(BoardDTO dto) {
		int result = 0;
		try {
			// 쿼리문 템플릿
			String query = "DELETE FROM board WHERE num=?";
			
			// 쿼리문 완성
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getNum());
			
			// 쿼리문 실행
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("게시물 삭제 중 예외 발생");
			e.printStackTrace();
		}
		return result; // 결과 반환
	}
}
