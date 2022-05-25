<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- 설문하기 폼 --%>
<%@ page import="musicvoteone.*"%>
<%@ page import="java.util.List"%>
<%
MusicDao mdo = MusicDao.getInstance();
MusicDto mto = new MusicDto();
List<MusicDto> musiclist = mdo.selectAll();
// String list = null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>※설문조사참여※</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<h2>※설문조사하기※</h2>
	<form method="post" action="surveyProc.jsp" name="surveyForm">
		희망하는 음악장르는? <br><br/>
		<%
			if (musiclist == null) {
		%>
		<h3> 데이터가 없습니다. 음악장르를 등록하시오. </h3>
		<%
			} else {
			for (MusicDto tmp : musiclist) {
		%>
			<input type='radio' name="musictype" value= "<%=tmp.getNumber()%>" >
			<%= tmp.getMusictype() %><br><br/>
		<% }
		}%><br>
		<input type="submit" value="설문완료">
		<ul>
			<li><a href=main.jsp> 홈으로</a></li>
		</ul>
	</form>
</body>
</html>