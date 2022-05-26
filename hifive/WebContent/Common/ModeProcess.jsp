<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String mode = request.getParameter("mode");
	if (mode.equals("admin")) {
		response.sendRedirect("../Login/AdminLoginForm.jsp");
	} else {
		response.sendRedirect("../Login/UserLoginForm.jsp");
	}
%>