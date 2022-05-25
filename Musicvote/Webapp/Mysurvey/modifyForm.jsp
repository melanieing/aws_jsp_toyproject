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
		변경하고자 하는 항목을 고르시오.<br><br/>
		<%
			if (musiclist == null) {
		%>
		<h3>데이터가 없습니다. 음악장르를 등록하시오.</h3>
		<ul>
			<li><a href=main.jsp> 홈으로</a></li>
		</ul>
		<%
			} else {
		for (MusicDto tmp : musiclist) {
		%>
		
		<input type='radio' name="musictype" value="<%=tmp.getMusictype()%>">
		<%=tmp.getMusictype()%><br><br/>
		<%
			}
		%>
		<%
			}
		%>
		<h3>변경될 새로운 장르를 적으시오.</h3>
		<input type="text" name="newType"> 
		<input type="submit" value="수정하기" >
		<ul>
			<li><a href=main.jsp> 홈으로</a></li>
		</ul>
	</form>

</body>
</html>