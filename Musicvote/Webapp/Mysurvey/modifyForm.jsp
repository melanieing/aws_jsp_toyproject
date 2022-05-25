<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- 음악장르 변경 폼 --%>
<%@ page import="musicvoteone.*"%>
<%@ page import="java.util.List"%>
<%

MusicDao mdo = MusicDao.getInstance();
MusicDto mto = new MusicDto();
List<MusicDto> musiclist = mdo.selectAll();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>음악장르 변경하기</title>
<link href="css/style.css?after" rel="stylesheet" type="text/css" />
<link href="css/regFormstyle.css?after" rel="stylesheet" type="text/css" />
</head>
<body>
	<h2>※음악장르 수정※</h2>
	<form method="post" action="modifyProc.jsp" name="modifyForm">
		변경하고자 하는 항목을 고르시오. <br></br>
		<%
			if (musiclist.size() == 0) {
		%>
		<h3>데이터가 없습니다. 음악장르를 등록하시오.</h3>
		<ul>
			<li><a href=insertForm.jsp> 뒤로가기</a></li>
		</ul>
		<%
			} else {
			for (MusicDto tmp : musiclist) {
		%>
			<%= tmp.getMusictype() %>		
			<input type='radio' name="musictype" value= "<%= tmp.getMusictype() %>" >
		<% }%>
<% }%>	
		<input type = "hidden" name ="check" />
		<h4>변경될 새로운 장르는?</h4>
		<input type="text" name="musictype" />
		<input type="submit" value="수정하기" onclick="modify()">
	</form>

</body>
</html>