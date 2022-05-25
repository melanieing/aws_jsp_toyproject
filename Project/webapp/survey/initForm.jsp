<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="project_survey.*"%>
<%
	SurveyDao dao = SurveyDao.getInstance();
%>
<%
	request.setCharacterEncoding("UTF-8");
if (!dao.init()) {
	out.println("");
}else{
	response.sendRedirect("index.jsp");
}
%>


<%-- <!DOCTYPE html>
<html>
<head>
<title>init page</title>
<script src="script.js"></script>
</head>

<body>
<form name="initForm" >
<input type="button" value="초기화" onclick="init()">
<%
		dao.init();
		%>
</form>
</body>
</html> --%>