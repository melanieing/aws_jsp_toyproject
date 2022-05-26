<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 가입</title>
</head>
<body>
	<h2 align="center">회원가입</h2>
	<form action="JoinProcess.jsp" method="post">
		<table align="center" border="1">
		    <tr><td>아이디(별명)</td><td><input type="text" name="memId"> <input type="button" value="중복확인"></td></tr>
		    <tr><td>나이</td><td><input type="text" name="memAge"></td></tr>
		    <tr><td>성별</td><td><input type="radio" name="memGender" checked="" value="남성">남성<input type="radio" name="memGender" value="여성">여성</td></tr>
		    <tr><td>암호(4자리 숫자)</td><td><input type="password" name="memPwd"></td></tr>
		</table>
		<table align="center">
		    <tr><td>
		    <input type="submit" value="확인"> 
		    <input type="reset" value="다시입력">
    		</td></tr>
		</table>
	</form>
</body>
</html>