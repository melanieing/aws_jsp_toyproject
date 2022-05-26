<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 모드</title>
</head>
<body>	
	<jsp:include page="../Common/AdminLink.jsp" />
	<br/>
	<table align="center">
		<tr>
			<td>
				╭ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝╮<br/>
				 &nbsp;&nbsp; 관리자 님 ! 오늘은  <%= LocalDate.now().format(formatter) %>입니다.<br/>
				╰ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞╯<br/>
				 &nbsp;O °<br/>
				 &nbsp;ᕱ ᕱ     "" Hi-Five!"<br/>
				( ･ω･) <br/>
				/ つΦ . .. . ﹢ ⃰ ଂ ಇ	<br/>
			</td>
		</tr>
	</table>
	<h2 align="center">☞ 관리자 메뉴를 선택하세요.</h2>
	<hr>
	<table align="center">
		<tr align="center">
			<td align="center">
				<form action="<%= request.getContextPath() %>/Admin/UserListForAdmin.jsp" method="get">
					<input type="submit" name="adminMenu" value="회원정보 관리"><br/>
				</form>
			</td>
		</tr>
		<tr align="center">
			<td align="center">
				<form action="<%= request.getContextPath() %>/Admin/SurveyListForAdmin.jsp" method="get">
					<input type="submit" name="adminMenu" value="설문데이터 관리"><br/>
				</form>
			</td>
		</tr>		
		<tr>
			<td align="center">
				<form action="<%= request.getContextPath() %>/Common/SurveyStatistics.jsp" method="get">
					<input type="submit" name="userMenu" value="설문응답 통계 확인"><br/>
				</form>
			</td>
		</tr>	
	</table>

</body>
</html>