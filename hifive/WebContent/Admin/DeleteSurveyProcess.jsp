<%@ page import="membership.*" %>
<%@ page import="question.*" %>
<%@ page import="java.util.List" %>
<%@ page import="utils.JSFunction"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String memNum = request.getParameter("memNum"); // 일련번호 받기
	String questNum = request.getParameter("questNum");
	
	QuestionDAO qdao = new QuestionDAO(application); // DAO 생성
	List<QuestionDTO> qdtoList = qdao.getQdtoByMemNum(memNum); // 개별 회원 정보 가져오기
	QuestionDTO qdto = qdao.searchQuestByQuestNum(questNum);

	//qdao.close(); // DB 연결 해제

	int delResult = 0;
	
	if (session.getAttribute("adminId") != null 
	&& session.getAttribute("adminId").toString().equals(application.getInitParameter("ADMIN_ID"))) { // 어드민계정인지 확인
		
		delResult = qdao.deleteByQuestNum(questNum);; // 삭제!!
		
		// 성공/실패 처리
		if (delResult == 1) {
			// 성공 시 목록 페이지로 이동
			JSFunction.alertLocation("삭제되었습니다.", "SurveyListForAdmin.jsp", out);
		} else {
			// 실패 시 이전 페이지로 이동
			JSFunction.alertBack("삭제에 실패하였습니다.", out);
		}
	} else {
		// 작성자 본인이 아니라면 이전 페이지로 이동
		JSFunction.alertBack("어드민 계정만 삭제할 수 있습니다.", out);
		return;
	}
%>

