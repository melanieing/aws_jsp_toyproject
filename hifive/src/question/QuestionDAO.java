package question;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBCConnect;
import membership.MemberDAO;

public class QuestionDAO extends JDBCConnect {
	
	private MemberDAO mdao;
	
	public QuestionDAO() {
		super();
	}
	public QuestionDAO(ServletContext application) {
		super(application);
	}
	
	// 명시한 DB로의 연결이 완료된 MemberDAO 객체를 생성함
	public QuestionDAO(String drv, String url, String id, String pw) {
		super(drv, url, id, pw); // 매개변수 4개짜리 JDBCConnect 생성자 호출
	}
	
	// 검색 조건에 맞는 설문데이터의 수를 반환
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0; // 결과(설문데이터 수)를 담을 변수
		
		// 설문데이터 수를 얻어오는 쿼리문 작성
		String query = "SELECT COUNT(*) FROM question";
		if (map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " " + " LIKE '%" + map.get("searchWord") + "%'";
		}
		
		try {
			stmt = con.createStatement(); // 정적 쿼리문 생성
			rs = stmt.executeQuery(query); // 쿼리 실행
			rs.next(); // 커서를 첫 번째 행으로 이동, qdto 개수를 추출
			totalCount = rs.getInt(1); // 첫 번째 컬럼 값을 가져옴
		} catch (Exception e) {
			System.out.println("설문데이터 수를 구하는 중 예외 발생");
			e.printStackTrace();
		}
		return totalCount;
	}
	
	// 검색 조건에 맞는 설문데이터 목록 반환
	public List<QuestionDTO> selectQdtoList(Map<String, Object> map) {
		List<QuestionDTO> ql = new Vector<QuestionDTO>(); // 결과(게시물 목록)를 담을 변수
		
		String query = "SELECT * FROM question";
		if (map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " LIKE '%" + map.get("searchWord") + "%' ";
		}
		query += " ORDER BY questNum DESC";
		
		try {
			stmt = con.createStatement(); // 쿼리문 생성
			rs = stmt.executeQuery(query); // 쿼리 실행
			
			while (rs.next()) { // 결과를 순회하며
				QuestionDTO dto = new QuestionDTO(); // 한 행(설문데이터 하나)의 내용을 DTO에 저장
				
				dto.setQuestNum(rs.getString("questNum")); // 설문데이터 일련번호
				dto.setMemNum(rs.getString("memNum")); // 설문응답자 고유번호
				dto.setQuestType(rs.getString("questType")); // 설문유형
				dto.setQuestAns(rs.getString("questAns")); // 설문응답
				
				ql.add(dto); // 결과 목록에 저장
			}
		} catch (Exception e) {
			System.out.println("설문데이터 목록 조회 중 예외 발생");
			e.printStackTrace();
		}
		return ql;	
	}
	
	// 검색 조건에 맞는 설문데이터 목록을 반환(페이징 기능 지원)
	public List<QuestionDTO> selectQdtoListPage(Map<String, Object> map) {
		List<QuestionDTO> ql = new Vector<QuestionDTO>(); // 결과(설문데이터 목록)를 담을 변수
		
		// 쿼리문 템플릿
		String query = " SELECT * FROM ( "
					+ " 	SELECT Tb.*, ROWNUM rNum FROM ( "
					+ " 		SELECT * FROM question ";
		
		// 검색 조건 추가
		if (map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " LIKE '%" + map.get("searchWord") + "%' ";
		}
		
		query += " 		ORDER BY questNum DESC"
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
				QuestionDTO dto = new QuestionDTO(); // 한 행(설문데이터 하나)의 내용을 DTO에 저장
				
				dto.setQuestNum(rs.getString("questNum")); // 일련번호
				dto.setMemNum(rs.getString("memNum")); // 설문응답자 고유번호
				dto.setQuestType(rs.getString("questType")); // 설문유형
				dto.setQuestAns(rs.getString("questAns")); // 설문응답
				
				ql.add(dto); // 결과 목록에 저장
			}
		} catch (Exception e) {
			System.out.println("설문데이터 목록 조회 중 예외 발생");
			e.printStackTrace();
		}
		//목록 반환
		return ql;	
	}
	
	// 설문데이터 정보를 받아 DB에 추가
	public int insertQuestion(String memNum, String questType, String questAns) {
		int result = 0;
		
		try {
			// INSERT 쿼리문 작성
			String query = "INSERT INTO question ( "
					+ " questNum, memNum, questType, questAns) "
					+ " VALUES ( "
					+ "seq_member_num.NEXTVAL, ?, ?, ?)";
			
			psmt = con.prepareStatement(query); //동적 쿼리
			psmt.setString(1, memNum);
			psmt.setString(2, questType);
			psmt.setString(3, questAns);
			
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("설문데이터 등록 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	// 명시한 회원 고유번호에 해당하는 설문데이터 정보 반환
	public List<QuestionDTO> getQdtoByMemNum(String memNum) {
		List<QuestionDTO> ql = new ArrayList<>();
		
		// 쿼리문 준비
		String query = "SELECT * FROM question WHERE memNum=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, memNum); // 인파라미터를 일련번호로 설정
			rs = psmt.executeQuery(); // 쿼리 실행
		
			while (rs.next()) {
				QuestionDTO dto = new QuestionDTO(); // 한 행(설문데이터 하나)의 내용을 DTO에 저장
				
				dto.setQuestNum(rs.getString("questNum")); // 일련번호
				dto.setMemNum(rs.getString("memNum")); // 설문응답자 고유번호
				dto.setQuestType(rs.getString("questType")); // 설문유형
				dto.setQuestAns(rs.getString("questAns")); // 설문응답
				
				ql.add(dto); // 결과 목록에 저장
			}
		} catch (Exception e){
			System.out.println("설문데이터 상세보기 중 예외 발생");
			e.printStackTrace();
		}
		return ql;
	}
	
//	// 지정한 응답자 아이디에 해당하는 회원 정보 반환
//	public MemberDTO selectMemberInfo(String memNum) {
//		MemberDTO mdto = new MemberDTO();
//		
//		// 쿼리문 준비
//		String query = "SELECT memNum, memId, memAge, memGender FROM member WHERE mem=?";
//		
//		try {
//			psmt = con.prepareStatement(query);
//			psmt.setString(1, memNum); // 인파라미터를 일련번호로 설정
//			rs = psmt.executeQuery(); // 쿼리 실행
//			
//			// 결과 처리
//			if (rs.next()) {
//				mdto.setMemNum(rs.getString("memNum")); // 일련번호
//				mdto.setMemId(rs.getString("memId")); // 아이디
//				mdto.setMemAge(rs.getString("memAge")); // 비밀번호
//				mdto.setMemGender(rs.getString("memGender")); // 성별
//			}
//		} catch (Exception e){
//			System.out.println("게시물 상세보기 중 예외 발생");
//			e.printStackTrace();
//		}
//		return mdto;
//	}
//	// QUESTION 테이블에 레코드 삽입
//	// INSERT INTO "QUESTION" VALUES ("SQ_QUESTION".NEXTVAL, "MEM_ID", "QUEST_TYPE", "QUEST_ANS")
//	public boolean insertQuest(QuestionDTO dto) {
//		boolean flag = false;
//		
//		String query = "INSERT INTO question VALUES (seq_question_num.NEXTVAL, ?, ?, ?)";
//		try {			
//			psmt = con.prepareStatement(query); 
////			psmt.setLong(1, vo.getMemId()); 
////			psmt.setInt(2,  vo.getQuestType());
////			psmt.setInt(3, vo.getQuestAns());
////			
////			int result = psmt.executeUpdate();
////			System.out.printf("설문응답 %d개가 등록되었습니다^_^\n\n", result);
////			flag = true; // INSERT 성공 시 true 반환
////		} catch (Exception e) {
////			updateQuest(vo.getMemId(), vo.getQuestAns(), vo.getQuestType());
//			// e.printStackTrace();
//		}
//		return flag; // INSERT 실패 시 그대로 false 반환
//	}
	
	// QUESTION 테이블에서 모든 레코드 검색
	public List<QuestionDTO> selectQuestAll() {
		List<QuestionDTO> list = new ArrayList<>();
		String query = "SELECT questNum, memNum, questType, questAns FROM question";
		
		try {
			psmt = con.prepareStatement(query);
			rs = psmt.executeQuery(); 
			while (rs.next()) {
				QuestionDTO tmp = new QuestionDTO(
						rs.getString("questNum"), 
						rs.getString("memNum"),
						rs.getString("questType"),
						rs.getString("questAns"));
				list.add(tmp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return (list.size() == 0) ? null : list;
	}
	
	// QUESTION 테이블에서 설문고유번호로 레코드 하나 검색
	public QuestionDTO searchQuestByQuestNum(String questNum) {
		QuestionDTO questInfo = null;
		String query = "SELECT questNum, memNum, questType, questAns FROM question WHERE questNum=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, questNum);
			rs = psmt.executeQuery();
			if (rs.next()) {
				questInfo = new QuestionDTO(rs.getString("questNum"), rs.getString("memNum"), 
						rs.getString("questType"), rs.getString("questAns"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return (questInfo == null) ? null : questInfo;
	}

	// QUESTION 테이블에서 설문유형으로 레코드 리스트 검색
	public List<QuestionDTO> searchQuestByQuestType(String questType) {

		List<QuestionDTO> list = new ArrayList<>();
		String query = "SELECT questNum, memNum, questType, questAns FROM question WHERE questType=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, questType);
			rs = psmt.executeQuery();
			while (rs.next()) {
				QuestionDTO tmp = new QuestionDTO(
						rs.getString("questNum"), 
						rs.getString("memNum"), 
						rs.getString("questType"),
						rs.getString("questAns"));
				list.add(tmp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return (list.size() == 0) ? null : list;
	}	
	
	
	// question 테이블에서 (회원 고유번호, 설문유형)으로 설문응답 검색
	public String getQuestAns(String memNum, String questType) {

		String query = "SELECT questAns FROM question WHERE memNum=? AND questType=?";
		String questAns = "";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, memNum);
			psmt.setString(2, questType);
			rs = psmt.executeQuery();
			if (rs.next()) {
				questAns = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return questAns;
	}

	// QUESTION 테이블에서 (설문유형, 설문응답)에 일치하는 회원고유번호 리스트  검색
	public ArrayList<Integer> getMemNumListToInteger(String questType, String questAns) {
		ArrayList<Integer> list = new ArrayList<>();
		String query = "SELECT memNum FROM question WHERE questType=? AND questAns=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, questType);
			psmt.setString(2, questAns);
			rs = psmt.executeQuery();
			while (rs.next()) {
				list.add(rs.getInt("memNum"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return (list.size() == 0) ? null : list;
	}
	
	// QUESTION 테이블의 모든 레코드 수 반환
	public int countQuest() {
		int rowCount = 0;
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT COUNT(*) FROM question");
			if (rs.next()) {
				rowCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rowCount;
	}	
	
	// QUESTION 테이블에서 (설문유형, 설문응답)에 일치하는 레코드 수 반환 
	public int countQuest(String questType, String questAns) {

		String query = "SELECT COUNT(*) FROM question WHERE questType=? AND questAns=?";
		int rowCount = 0;
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1,  questType);
			psmt.setString(2, questAns);
			rs = psmt.executeQuery();
			if (rs.next()) {
				rowCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return rowCount;
	}
	
	// QUESTION 테이블에서 설문유형에 일치하는 레코드 수 반환 
	public int countQuest(String questType) {

		String query = "SELECT COUNT(*) FROM question WHERE questType=?";
		int rowCount = 0;
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1,  questType);
			rs = psmt.executeQuery();
			if (rs.next()) {
				rowCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return rowCount;
	}
	
	// QUESTION 테이블에서 설문고유번호가 일치하는 레코드 하나 삭제
	public int deleteByQuestNum(String questNum) {
		String query = "DELETE FROM question WHERE questNum=?";
		int result = 0;
		try {			
			psmt = con.prepareStatement(query);
			psmt.setString(1, questNum);
			
			result = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;

	}
	
	// QUESTION 테이블에서 회원고유번호와 일치하는 레코드 삭제
	public int deleteByMemNum(String memNum) {
		String query = "DELETE FROM question WHERE memNum=?";
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
	
	// QUESTION 테이블에서 (회원고유번호, 설문유형)이 일치하는 레코드의 설문응답 수정
	public int updateQuest(String memNum, String questAns, String questType) {
		String query = "UPDATE question SET questAns=? WHERE memNum=? AND questType=?";
		int result = 0;
		try {			
			psmt = con.prepareStatement(query);
			psmt.setString(1,questAns);
			psmt.setString(2, memNum);
			psmt.setString(3,  questType);
			
			result = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return result;
	}	
	
	// QUESTION 테이블에서 설문데이터 업데이트
	public int updateQuestByMemNum(String questType, String questAns, String memNum) {
		int result = 0;
		
		// 쿼리문 준비
		String query = "UPDATE question SET "
				+ " questType=?, questAns=? "
				+ " WHERE memNum=?";
		
		try {
			psmt = con.prepareStatement(query);
			
			// 쿼리문 완성
			psmt.setString(1, questType);
			psmt.setString(2, questAns);
			psmt.setString(3, memNum);
			
			// 쿼리문 실행
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("설문데이터 업데이트 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}

}
