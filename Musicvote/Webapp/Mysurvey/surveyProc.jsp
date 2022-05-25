<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page import="musicvoteone.MusicDao"%>
<%@ page import="musicvoteone.MusicDto"%>
<%
MusicDao mdo = MusicDao.getInstance();
long upvote = Long.parseLong(request.getParameter("upvote"));
// mdo.updatevote(number);
response.sendRedirect("main.jsp");
%>
	<%
		if (upvote !=   ) {
%>
<script>
	alert("<b> 투표가 완료되었습니다.</b>");
	out.println("<a href = main.jsp> 확인하기 </a>");
</script>
<% } else {
	%>	
<script>
	alert("<b> 투표가 완료되었습니다.</b>");
	out.println("<a href = main.jsp> 확인하기 </a>");
</script>

<% }
%>