<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="musicvoteone.MusicDao"%>
<%@ page import="musicvoteone.MusicDto"%>
<%-- 라디오에서 체크된 값을 롱 넘버로 넘겨야 함 그리고 변경사항을 스트링 인풋으로 넘겨야 함 --%>
<%
	String input = request.getParameter("musictype").replaceAll("\\s+","");
	long number =  Long.parseLong(request.getParameter("check").replaceAll("\\s+",""));
	MusicDao mdo = MusicDao.getInstance();
	mdo.altermusic(input, number);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정하기</title>
</head>
<body>

</body>
</html>