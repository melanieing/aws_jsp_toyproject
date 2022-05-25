<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.InputMismatchException" %>
<%@ page import="java.util.Scanner" %>
<%@ page import="service.Banner" %>
<%@ page import="admin.Admin" %>
<%@ page import="service.Survey" %>
<%@ page import="service.Matching" %>
<%@ page import="membership.MemberDAO" %>
<%@ page import="question.QuestionDAO" %>
<%@ page import="exceptions.AnswerOutOfBoundException" %>
<%@ page import="exceptions.YesOrNoException" %>
<%@ page import="membership.MemberDTO" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Hi-Five</title>
</head>
<body>

<%! 
	private final static int QUESTION_SIZE = 5;
%> 

	<!-- 메인 시작 화면  --> 
	
	<table align="center">
		<tr>
			<td>
				╭ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝ ͡ ◜◝╮<br/>
				&nbsp;&nbsp; ♬안녕하세요, 설문조사 기반 친구 매칭 서비스 Hi-Five!에 오신 걸 환영합니다!<br/>
				╰ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞ ͜ ◟◞╯<br/>
			</td>
		</tr>
		<tr align="center">
			<td>
				<form action="<%= request.getContextPath() %>/Common/ModeProcess.jsp" method="get">
					<input type="radio" name="mode" value="admin">관리자 모드&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="mode" value="user" checked="checked">사용자 모드
					<input type="submit" value="선택"/>
				</form>
			</td>
		</tr>
	</table>
	

</body>
</html>