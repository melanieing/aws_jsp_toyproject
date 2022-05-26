<%@page import="question.QuestionDAO"%>
<%@ page import="membership.MemberDAO" %>
<%@ page import="membership.MemberDTO" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../Login/IsLoggedIn.jsp" %> <!-- 로그인 확인 -->

<%
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일");
	
	String memId= session.getAttribute("memId").toString();

	MemberDAO mdao = new MemberDAO();	
	MemberDTO mdto = mdao.getMdtoByMemId(memId);
	
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Hi-Five! (유저모드)</title>
</head>
<body>	
	<jsp:include page="../Common/UserLink.jsp" />
	<br/>
	<table align="center">
		<tr>
			<td>
				╭ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝╮<br/>
				  &nbsp;&nbsp; 설문에 참여하시면, 당신과 비슷한 성향의 친구를 매칭해드립니다!  <br/>
				╰ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞╯<br/>
				O ° <br/>
				 ᕱ ᕱ      &nbsp; "Hi-Five!"<br/>
				( ･ω･)       <br/>
				/ つΦ . .. . ﹢ ⃰ ଂ ಇ <br/>
			</td>
		</tr>
	</table>
	<h2 align="center"> 안녕하세요, <%= session.getAttribute("memId").toString() %>님!</h2>
	<h4 align="center">☞ 아래 메뉴 중에서 선택하세요.</h4>
	<hr>
	
	<table width="20%" align="center">
		<tr>
			<td align="center">
				<form action="<%= request.getContextPath() %>/User/UserViewForUser.jsp" method="get">
					<input type="submit" name="userMenu" value="개인정보 확인/수정"><br/>
				</form>
			</td>
		</tr>
		<tr>
			<td align="center">
				<form action="<%= request.getContextPath() %>/User/DoSurvey.jsp" method="get">
					<input type="submit" name="userMenu" value="설문참여/수정"><br/>
				</form>
			</td>
		</tr>
		<tr>
			<td align="center">
				<form action="<%= request.getContextPath() %>/User/SurveyViewForUser.jsp" method="get">
					<input type="submit" name="userMenu" value="내 설문응답 확인"><br/>
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
		<tr>
			<td align="center">
				<form action="<%= request.getContextPath() %>/User/MatchingOne.jsp" method="get">
					<input type="submit" name="userMenu" value="1:1매칭 신청하기"><br/>
				</form>
			</td>
		</tr>	
		<tr>
			<td align="center">
				<form action="<%= request.getContextPath() %>/User/MatchingGroup.jsp" method="get">
					<input type="submit" name="userMenu" value="그룹매칭 신청하기"><br/>
				</form>
			</td>
		</tr>		
		
	</table>

</body>
</html>