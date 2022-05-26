<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="musicvoteone.*"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	MusicDao mdo = MusicDao.getInstance();
String upvote = request.getParameter("musictype");
System.out.println(upvote.length());
System.out.println(upvote);
if (mdo.updatevote(upvote)) {
%>

<script>
	alert("투표가 완료되었습니다.");
	location.href = "main.jsp";
</script>

<%
	} else {
%>
<script>
	alert("에러");
	location.href = "main.jsp";
</script>
<%
	}
%>

