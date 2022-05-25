<%@ page import="membership.*" %>
<%@ page import="question.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 로그인 폼으로부터 받은 아이디와 패스워드
	String adminId = request.getParameter("adminId");
	String adminPwd = request.getParameter("adminPwd");
	
	final String ADMIN_ID = "admin";
	final String ADMIN_PWD = "1234";
	
	// 로그인 성공 여부에 따른 처리
	if (ADMIN_ID.equals(adminId) && ADMIN_PWD.equals(adminPwd)) {
		// 로그인 성공  -> session 영역에 아이디와 모드를 저장 후, 로그인 페이지로 이동
		session.setAttribute("adminId", ADMIN_ID);
		session.setAttribute("mode", "admin");
		response.sendRedirect("AdminLoginForm.jsp");
	} else {
		// 로그인 실패 -> request 영역에 오류 메시지 저장 후, 로그인 페이지로 포워드
		request.setAttribute("LoginErrMsg", "로그인 오류입니다.");
		request.getRequestDispatcher("AdminLoginForm.jsp").forward(request, response);
	}
%>