<%@ page import="membership.*" %>
<%@ page import="question.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 로그인 폼으로부터 받은 아이디와 패스워드
	String memId = request.getParameter("memId");
	String memPwd = request.getParameter("memPwd");
	
	// web.xml에서 가져온 DB 연결 정보
	String oracleDriver = application.getInitParameter("OracleDriver");
	String oracleURL = application.getInitParameter("OracleURL");
	String oracleId = application.getInitParameter("OracleId");
	String oraclePwd = application.getInitParameter("OraclePwd");
	
	// 회원 테이블 DAO를 통해 회원 정보 DTO 획득
	MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
	MemberDTO memberDTO = dao.getMemberDTO(memId, memPwd);
	dao.close();
	
	// 로그인 성공 여부에 따른 처리
	if (memberDTO.getMemId() != null) {
		// 로그인 성공  -> session 영역에 아이디와 이름 저장 후, 로그인 페이지로 이동
		session.setAttribute("memId", memberDTO.getMemId());
		session.setAttribute("memNum", memberDTO.getMemNum());
		session.setAttribute("mode", "user");
		//session.setAttribute("memPwd", memberDTO.getMemPwd());
		response.sendRedirect("UserLoginForm.jsp");
	} else {
		// 로그인 실패 -> request 영역에 오류 메시지 저장 후, 로그인 페이지로 포워드
		request.setAttribute("LoginErrMsg", "로그인 오류입니다.");
		request.getRequestDispatcher("UserLoginForm.jsp").forward(request, response);
	}
%>