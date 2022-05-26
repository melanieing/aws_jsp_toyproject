<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설문항목 등록하기</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<link href="css/votestyle.css" rel="stylesheet" type="text/css">
<script src="script.js"></script>
</head>
<body>
	<h2>※설문항목 등록하기※</h2>
	<article>
		<form method="post" name="insertForm" action="insertProc.jsp">
			희망하는 설문항목은?<br /> 
			<input type="text" name="musictype" /> 
			<input type="submit" value="등록하기" onclick="isExist()">
		</form>
		<ul>
			<li><a href=main.jsp> 홈으로</a></li>
		</ul>
	</article>
</body>
</html>