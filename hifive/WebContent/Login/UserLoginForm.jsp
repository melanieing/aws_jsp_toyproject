<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인</title>
</head>
<body>
	<jsp:include page="../Common/UserLink.jsp"/>
	<h2 align="center">로그인 페이지</h2> <%-- 내장 객체 영역에 LoginErrMsg 속성이 있는지 확인 후 그 내용 출력 --%>
	<span style="color : red; font-size: 1.2em;">
		<%= request.getAttribute("LoginErrMsg") == null ?
				"" : request.getAttribute("LoginErrMsg") %>
	</span>
	<% // session 영역에 사용자 아이디가 저장되어 있는지 확인 (null이면 로그아웃상태)
		if (session.getAttribute("memId") == null) {
	%>
	<script> <!-- 유효성 검사 함수 (id, pw 중 빈 값이 있다면 경고창 띄움) -->
		function validateForm(form) {
			if (!form.memId.value) {
				alert("아이디를 입력하세요.");
				return false;
			}
			if (form.memPwd.value == "") {
				alert("패스워드를 입력하세요.");
				return false;
			}
		}
	</script> <!-- 폼값 전송 시 onsubmit이벤트 핸들러가 validateForm()을 호출하도록 설정 , 유효성 검사 통과 시 post방식으로 LoginProcess.jsp로 전송 -->
	
	<table align="center">
		<tr align="center">
			<td>
				<form action="<%=request.getContextPath() %>/Login/UserLoginProcess.jsp" method="post" name="loginForm" onsubmit="return validateForm(this)">
					아이디 : <input type="text" name="memId"/>&nbsp;&nbsp;&nbsp;
					패스워드 : <input type="password" name="memPwd"/>
					<input type="submit" value="로그인하기"/>
				</form>
		</td>
		</tr>
	</table>
	
	<hr>
	
	<table align="center">
		<tr>
			<td>
				★★★아직 회원이 아니신가요?★★★<br/>
			</td>
		</tr>
		<tr align="center">
			<td>
				<form method="post" action="<%=request.getContextPath() %>/User/JoinForm.jsp">
					<input type="submit" value="가입하기"/>
				</form>
			</td>
		</tr>
	</table>
	<%
		} else { // 이미 로그인 되어있는 경우 실행
	%>		
			session.setAttribute("mode", "user");
			<jsp:forward page="../User/UserMain.jsp"/>
			<!--<h4 align="center"> -->
			<%--= session.getAttribute("memId") --%> 
			<!--회원님, 로그인하셨습니다.</h4> -->
			
			<!--<a href="Logout.jsp">[로그아웃]</a>  -->
	<%
		}
	%>
</body>
</html>