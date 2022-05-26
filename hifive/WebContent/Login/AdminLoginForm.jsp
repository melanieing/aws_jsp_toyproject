<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Admin Login</title>
</head>
<body>
	<h2>관리자 계정으로 로그인하세요</h2> <%-- 내장 객체 영역에 LoginErrMsg 속성이 있는지 확인 후 그 내용 출력 --%>
	<span style="color : red; font-size: 1.2em;">
		<%= request.getAttribute("LoginErrMsg") == null ?
				"" : request.getAttribute("LoginErrMsg") %>
	</span>
	<% // session 영역에 사용자 아이디가 저장되어 있는지 확인 (null이면 로그아웃상태)
 		if (session.getAttribute("adminId") == null) {
	%>
	<script> <!-- 유효성 검사 함수 (id, pw 중 빈 값이 있다면 경고창 띄움) -->
		function validateForm(form) {
			if (!form.adminId.value) {
				alert("아이디를 입력하세요.");
				return false;
			}
			if (form.adminPwd.value == "") {
				alert("패스워드를 입력하세요.");
				return false;
			}
		}
	</script> <!-- 폼값 전송 시 onsubmit이벤트 핸들러가 validateForm()을 호출하도록 설정 , 유효성 검사 통과 시 post방식으로 LoginProcess.jsp로 전송 -->
	<form action="AdminLoginProcess.jsp" method="post" name="AdminLoginForm" onsubmit="return validateForm(this)">
		아이디 : <input type="text" name="adminId"/><br/>
		패스워드 : <input type="password" name="adminPwd"/><br/>
		<input type="submit" value="로그인하기"/>
	</form>
	
	<%
 		} else { // 이미 로그인 되어있는 경우 실행
	%>		
			<jsp:forward page="../Admin/AdminMain.jsp"/>
			<!--  관리자님, 환영합니다.<br/>-->
			<!--<a href="../AdminMain.jsp">[어드민 메인으로 가기]</a>-->
			<!--<a href="Logout.jsp">[로그아웃]</a>-->
	<%
 		}
	%>
	
</body>
</html>