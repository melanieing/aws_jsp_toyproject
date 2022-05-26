package membership;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBCConnect;

public class MemberDAO extends JDBCConnect {
	
	public MemberDAO() {
		super();
	}
	public MemberDAO(ServletContext application) {
		super(application);
	}
	// 명시한 DB로의 연결이 완료된 MemberDAO 객체를 생성함
	public MemberDAO(String drv, String url, String id, String pw) {
		super(drv, url, id, pw); // 매개변수 4개짜리 JDBCConnect 생성자 호출
	}
	
	// 명시한 (회원 아이디, 비밀번호)와 일치하는 회원정보를 반환
	public MemberDTO getMemberDTO(String memId, String memPwd) {
		MemberDTO dto = new MemberDTO(); // 회원 정보 DTO 객체 생성
		String query = "SELECT * FROM member WHERE memId=? and memPwd=?"; // 쿼리문 템플릿
		
		try {
			// 쿼리 실행
			psmt = con.prepareStatement(query); // 인파라미터가 있는 동적 쿼리문 실행하기 위한 PreparedStatement 객체 생성 // con : JDBCConnect에서 정의한 멤버 변수(DB와의 연결객체)
			psmt.setString(1, memId);
			psmt.setString(2, memPwd);

			rs = psmt.executeQuery(); // 실행한 결과 레코드를 ResultSet 객체에 담아 반환
		
			// 결과 처리
			if (rs.next()) { // 쿼리 결과로 얻은 회원 정보를 DTO 객체에 저장
				dto.setMemNum(rs.getString("memNum"));
				dto.setMemId(rs.getString("memId"));
				dto.setMemPwd(rs.getString("memPwd"));
				dto.setMemAge(rs.getString("memAge"));
				dto.setMemGender(rs.getString("memgender"));
			}
		} catch (Exception e) {
			System.out.println("회원 정보를 구하는 중 예외 발생");
			e.printStackTrace();
		}
		return dto;
	}
	
	// 검색 조건에 맞는 회원의 수를 반환
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0; // 결과(회원 수)를 담을 변수
		
		// 게시물 수를 얻어오는 쿼리문 작성
		String query = "SELECT COUNT(*) FROM member";
		if (map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " " + " LIKE '%" + map.get("searchWord") + "%'";
		}
		
		try {
			stmt = con.createStatement(); // 정적 쿼리문 생성
			rs = stmt.executeQuery(query); // 쿼리 실행
			rs.next(); // 커서를 첫 번째 행으로 이동, 게시물 개수를 추출
			totalCount = rs.getInt(1); // 첫 번째 컬럼 값을 가져옴
		} catch (Exception e) {
			System.out.println("회원 수를 구하는 중 예외 발생");
			e.printStackTrace();
		}
		return totalCount;
	}
	
	// 검색 조건에 맞는 회원 목록 반환
	public List<MemberDTO> selectMdtoList(Map<String, Object> map) {
		List<MemberDTO> ml = new Vector<MemberDTO>(); // 결과(게시물 목록)를 담을 변수
		
		String query = "SELECT * FROM member";
		if (map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " LIKE '%" + map.get("searchWord") + "%' ";
		}
		query += " ORDER BY memNum DESC";
		
		try {
			stmt = con.createStatement(); // 쿼리문 생성
			rs = stmt.executeQuery(query); // 쿼리 실행
			
			while (rs.next()) { // 결과를 순회하며
				MemberDTO dto = new MemberDTO(); // 한 행(회원 하나)의 내용을 DTO에 저장
				
				dto.setMemNum(rs.getString("memNum")); // 일련번호
				dto.setMemId(rs.getString("memId")); // 아이디
				dto.setMemAge(rs.getString("memAge")); // 비밀번호
				dto.setMemGender(rs.getString("memGender")); // 성별

				ml.add(dto); // 결과 목록에 저장
			}
		} catch (Exception e) {
			System.out.println("회원 목록 조회 중 예외 발생");
			e.printStackTrace();
		}
		return ml;	
	}

	// 검색 조건에 맞는 회원 목록을 반환(페이징 기능 지원)
	public List<MemberDTO> selectMdtoListPage(Map<String, Object> map) {
		List<MemberDTO> ml = new Vector<MemberDTO>(); // 결과(회원 목록)를 담을 변수
		
		// 쿼리문 템플릿
		String query = " SELECT * FROM ( "
					+ " 	SELECT Tb.*, ROWNUM rNum FROM ( "
					+ " 		SELECT * FROM member ";
		
		// 검색 조건 추가
		if (map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " LIKE '%" + map.get("searchWord") + "%' ";
		}
		
		query += " 		ORDER BY memNum DESC"
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
				MemberDTO dto = new MemberDTO(); // 한 행(회원 하나)의 내용을 DTO에 저장
				
				dto.setMemNum(rs.getString("memNum")); // 일련번호
				dto.setMemId(rs.getString("memId")); // 아이디
				dto.setMemAge(rs.getString("memAge")); // 비밀번호
				dto.setMemGender(rs.getString("memGender")); // 성별

				ml.add(dto); // 결과 목록에 저장
			}
		} catch (Exception e) {
			System.out.println("페이징 기능이 있는 회원목록 조회 중 예외 발생");
			e.printStackTrace();
		}
		//목록 반환
		return ml;	
	}

	// (회원 아이디, 회원 비밀번호, 회원 나이, 회원 성별)을 받아 DB에 업데이트하고 0 or 1 반환
	public int insertMember(String memId, String memPwd, String memAge, String memGender) {
		int result = 0;
		
		try {
			// INSERT 쿼리문 작성
			String query = "INSERT INTO member ( "
					+ " memNum, memId, memPwd, memAge, memGender) "
					+ " VALUES ( "
					+ "seq_member_num.NEXTVAL, ?, ?, ?, ?)";
			
			psmt = con.prepareStatement(query); //동적 쿼리
			psmt.setString(1,  memId);
			psmt.setString(2,  memPwd);
			psmt.setString(3,  memAge);
			psmt.setString(4,  memGender);
			
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("회원 등록 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	// 명시한 회원 고유번호에 해당하는 회원정보를 반환
	public MemberDTO getMdtoByMemNum(String memNum) {
		MemberDTO dto = new MemberDTO();
		
		// 쿼리문 준비
		String query = "SELECT * FROM member WHERE memNum=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, memNum); // 인파라미터를 일련번호로 설정
			rs = psmt.executeQuery(); // 쿼리 실행
			
			// 결과 처리
			if (rs.next()) {
				dto.setMemNum(rs.getString("memNum")); // 고유번호
				dto.setMemId(rs.getString("memId")); // 아이디
				dto.setMemPwd(rs.getString("memPwd")); // 비밀번호
				dto.setMemAge(rs.getString("memAge")); // 나이
				dto.setMemGender(rs.getString("memGender")); // 성별
			}
		} catch (Exception e){
			System.out.println("명시한 회원 고유번호에 해당하는 회원정보를 반환 중 예외 발생");
			e.printStackTrace();
		}
		return dto;
	}
		
	// 명시한 회원 아이디에 해당하는  회원정보를 반환
	public MemberDTO getMdtoByMemId(String memId) {
		MemberDTO memInfo = null;
		String query = "SELECT memNum, memId, memPwd, memAge, memGender FROM member WHERE memId=?";
		
		try {		
			psmt = con.prepareStatement(query);
			psmt.setString(1, memId);
			rs = psmt.executeQuery();
			if (rs.next()) {
				memInfo = new MemberDTO(
						rs.getString("memNum"),
						rs.getString("memId"), 
						rs.getString("memPwd"),
						rs.getString("memAge"), 
						rs.getString("memGender"));
			}
		} catch (Exception e) {
			System.out.println("명시한 회원 아이디에 해당하는  회원정보를 반환 중 예외 발생");
			e.printStackTrace();
		} 
		return (memInfo == null) ? null : memInfo;
	}
	
	// MEMBER 테이블의 전체 레코드를 리스트로 받아오기
	public List<MemberDTO> getAllMdtoList() {
		List<MemberDTO> list = new ArrayList<>();
		String query = "SELECT * FROM member";
		
		try {
			psmt = con.prepareStatement(query);
			rs = psmt.executeQuery();
			while (rs.next()) {
				MemberDTO tmp = new MemberDTO(
						rs.getString("memNum"), 
						rs.getString("MemId"),
						rs.getString("MemPwd"),
						rs.getString("MemAge"), 
						rs.getString("MemGender"));
				list.add(tmp);
			}
		} catch (Exception e) {
			System.out.println("MEMBER 테이블의 전체 레코드를 리스트로 반환 중 예외 발생");
			e.printStackTrace();
		}
		return (list.size() == 0) ? null : list;
	}
	
	
	// MEMBER 테이블에서 모든 레코드의 개수 반환
	public int countMembers() {
		int count = 0;
		
		try {		
			stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT COUNT(*) FROM member");
	
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("MEMBER 테이블에서 모든 레코드의 개수 반환 중 예외 발생");
			e.printStackTrace();
		}
		return count;
	}	
	
	// MEMBER 테이블에서 회원고유번호와 일치하는 레코드 삭제하고 0 or 1 반환
	public int deleteMdtoByMemNum(String memNum) {
		String query = "DELETE FROM member WHERE memNum=?";
		int result = 0;
		try {			
			psmt = con.prepareStatement(query);
			psmt.setString(1, memNum);
			
			result = psmt.executeUpdate(); 
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return result;
	}

	// MEMBER 테이블에서 특정 회원고유번호와 일치하는 레코드의 전체 정보 수정하고 0 or 1 반환
	public int updateByMemNum(String targetMemNum, String memId, String memPwd, String memAge, String memGender) {
		String query = "UPDATE member SET memId=?, memPwd=? memAge=?, memGender=? WHERE memNum=?";
		int result = 0;
		try {			
			psmt = con.prepareStatement(query);
			psmt.setString(1,memId);
			psmt.setString(2, memPwd);
			psmt.setString(2, memAge);
			psmt.setString(3, memGender);
			psmt.setString(4, targetMemNum);
			
			result = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// MEMBER 테이블에서 특정 회원고유번호와 일치하는 레코드의 전체 정보 수정하고 0 or 1 반환
	public int updateByMemNum(String targetMemNum, String memAge, String memGender) {
		String query = "UPDATE member SET memAge=?, memGender=? WHERE memNum=?";
		int result = 0;
		try {			
			psmt = con.prepareStatement(query);
			psmt.setString(1, memAge);
			psmt.setString(2, memGender);
			psmt.setString(3, targetMemNum);
			
			result = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 지정한 회원정보을 수정
	public int updateMdto(MemberDTO dto) {
		int result = 0;
		
		// 쿼리문 준비
		String query = "UPDATE member SET "
				+ " memId=?, memPwd=?, memAge=?, memGender=? "
				+ " WHERE memNum=?";
		
		try {
			psmt = con.prepareStatement(query);
			
			// 쿼리문 완성
			psmt.setString(1, dto.getMemId());
			psmt.setString(2, dto.getMemPwd());
			psmt.setString(3, dto.getMemAge());
			psmt.setString(4, dto.getMemGender());
			psmt.setString(5, dto.getMemNum());
			
			// 쿼리문 실행
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("회원 정보 수정 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 지정한 회원정보를 삭제
	public int deleteMember(MemberDTO dto) {
		int result = 0;
		try {
			// 쿼리문 템플릿
			String query = "DELETE FROM member WHERE memNum=?";
			
			// 쿼리문 완성
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getMemNum());
			
			// 쿼리문 실행
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("회원정보 삭제 중 예외 발생");
			e.printStackTrace();
		}
		return result; // 결과 반환
	}
	
}
