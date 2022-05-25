<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="musicvoteone.MusicDao"%>
<jsp:useBean id="dao" class="musicvoteone.MusicDao" />
<%--String[] init = request.getParameterValues("init"); --%>
<% 
	boolean flag = dao.init();
%>
<%
	if(flag){ // 초기화 된 상태.
		out.println("<b>데이터가 없습니다.(음악장르를 등록하시오).");
		out.println("<a href = insert.jsp> 음악장르등록</a>");
	}else{
		out.println("<b>초기화 되었습니다.");
		out.println("<a href = main.jsp>설문시작하기</a>");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>초기화 알림</title>
</head>
<link href="css/style.css" rel="stylesheet" type="text/css">
<link href="css/votestyle.css" rel="stylesheet" type="text/css">
<body>
	<br></br>

</body>
</html>