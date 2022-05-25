<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="musicvoteone.MusicDao"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	String input = request.getParameter("musictype");
	MusicDao mdo = MusicDao.getInstance();
	boolean flag = mdo.insertMusic(input);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등록확인</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<link href="css/votestyle.css" rel="stylesheet" type="text/css">
</head>
<body>
<ul>
	<li><a href= insertForm.jsp> 뒤로가기</a></li>
</ul>
	<br></br>
	<%
		if (flag) { //등록된 상태
		out.println("<b> 정상적으로 등록되었습니다.</b>");
		out.println("<a href = main.jsp> 홈으로 </a>");
	}
	%>
	
</body>
</html>