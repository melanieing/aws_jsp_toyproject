<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="musicvoteone.MusicDao"%>
<%@ page import="musicvoteone.MusicDto"%>
<%@ page import="java.util.List"%>
<!-- 설문현황 보여주기 -->
<%
	MusicDao mdo = MusicDao.getInstance();
	MusicDto mto = new MusicDto();
	List<MusicDto> musiclist = mdo.selectAll();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설문결과</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<link href="css/votestyle.css" rel="stylesheet" type="text/css">
</head>
<body>
<form method="post" action="main.jsp" name="surveyForm">
	<h2>※ 설문 결과확인 ※</h2>
	<%
		if (musiclist == null) {
	%>
	<h3>데이터가 없습니다. 음악장르를 등록하시오.</h3>
	<%
		} else {
	%>
	<table border="1">
		<th>음악 장르</th>
		<th>투표수</th>
		<%
			for (MusicDto tmp : musiclist) {
		%>
		<tr>
			<td><%=tmp.getMusictype()%></td>
			<td><%=tmp.getVote()%></td>
		</tr>
		<%
			}
		%>
	</table><br>
	
	<li> 총 투표 수 : <%= mdo.totalvote()%> 표</li> <br/>
	<input type="button" value="홈으로" onclick="javascript:window.location='main.jsp'" >
	</form>
	<%
		}
	%>
</body>
</html>