<%@ page import="membership.*" %>
<%@ page import="question.*" %>
<%@ page import="utils.JSFunction"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 수정 내용 얻기
	String memNum = request.getParameter("memNum"); // 일련번호 받기
	String memAge = request.getParameter("memAge");
	String memGender = request.getParameter("memGender");

	
	MemberDAO mdao = new MemberDAO(application); // DAO 생성
	MemberDTO mdto = mdao.getMdtoByMemNum(memNum); // 개별 회원 정보 가져오기

	//mdao.close(); // DB 연결 해제

	int delResult = 0;

	String sessionId = session.getAttribute("memId").toString();
	
	if (sessionId.equals(mdto.getMemId())) { // 어드민계정인지 확인
		
		delResult =  mdao.updateByMemNum(memNum, memAge, memGender); // 업데이트
		
		// 성공/실패 처리
		if (delResult == 1) {
			// 성공 시 목록 페이지로 이동
			JSFunction.alertLocation("수정되었습니다.", "UserViewForUser.jsp?memNum=" + mdto.getMemNum(), out);
		} else {
			// 실패 시 이전 페이지로 이동
			JSFunction.alertBack("수정에 실패하였습니다.", out);
		}
	} else {
		// 작성자 본인이 아니라면 이전 페이지로 이동
		JSFunction.alertBack("수정권한이 없습니다.", out);
		return;
	}
%>