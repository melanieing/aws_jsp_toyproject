<%@ page import="question.QuestionDAO" %>
<%@ page import="question.QuestionDTO" %>
<%@ page import="service.Survey" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	QuestionDAO qdao = new QuestionDAO();
	Survey sv = new Survey();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>설문응답 통계 확인</title>
</head>
<body>
<%
	if (session.getAttribute("adminId") == "admin") {
%>
		<jsp:include page="../Common/AdminLink.jsp" />
<%
	} else {
%>
		<jsp:include page="../Common/UserLink.jsp" />
<%
	}
%>
	<table border="1">
<%	
	for (int i = 1; i <= sv.getQuestions().length; i++) {
%>
		<tr> 
			<td colspan='2'>		
				<strong> <%= sv.getQuestion(Integer.toString(i)) %> </strong>
			</td>
		</tr>
<%
		double rows = (double)qdao.countQuest(Integer.toString(i));
		for (int j = 1; j <= sv.getOptions().length; j++) {
%>
		<tr>
			<td>
				<%= sv.getSurveyResult(Integer.toString(i), Integer.toString(j)) %> 				
			</td>		
			<td>
				<%= String.format("%.2f%%", (qdao.countQuest(Integer.toString(i), Integer.toString(j))/rows)*100) %>					
			</td>
		</tr>
<%
		}
	}	
%>
	</table>
</body>
</html>