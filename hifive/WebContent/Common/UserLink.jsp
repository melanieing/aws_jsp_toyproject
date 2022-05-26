<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<table border="1" width="100%">
	<tr>
		<td align="center">
		<!-- 로그인 여부에 따른 메뉴 변화 -->
		<% if (session.getAttribute("memId") == null) { %>
			<a href="<%= request.getContextPath() %>/Login/UserLoginForm.jsp">Login</a>
		<% } else { %> 
			<a href="<%= request.getContextPath() %>/Login/Logout.jsp">Logout</a>
		<% } %>
			&nbsp;&nbsp;&nbsp;
			<a href="<%= request.getContextPath() %>/Home.jsp">HOME</a>
			&nbsp;&nbsp;&nbsp;
			<a href="<%= request.getContextPath() %>/User/UserMain.jsp">My Page</a>
		</td>
	</tr>
</table>