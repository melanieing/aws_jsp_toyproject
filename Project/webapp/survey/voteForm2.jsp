<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>vote page</title>
<script src="script.js"></script>
</head>
<body>
	<h3>설문 참여하기</h3>
	<h4>좋아하는 영화 장르를 선택하세요.</h4>
	<form name="voteForm" method="post" action="vote.jsp">
		<ol type="1">
			<li><input type="radio" id="액션" name="movie" value="액션">
				<label for="액션">액션</label></li>
			<li><input type="radio" id="멜로" name="movie" value="멜로">
				<label for="멜로">멜로</label></li>
			<li><input type="radio" id="코미디" name="movie" value="코미디">
				<label for="코미디">코미디</label></li>
			<li><input type="radio" id="공포" name="movie" value="공포">
				<label for="공포">공포</label></li>
			<li><input type="radio" id="판타지" name="movie" value="판타지">
				<label for="판타지">판타지</label></li>
			<li><input type="radio" id="기타" name="movie" value="기타">
				<label for="기타">기타</label></li>
			<input type="text" name="other" placeholder="(직접 입력)" >
			<br>
			<input type="hidden" name="checkedVal">
			<input type="hidden" name="checkedNum" value="0">
			<br>
			<button type="button" onclick="values()">제출</button>
			<input type="reset" value="다시 선택">
			<input type="button" value="뒤로 가기" onclick='history.go(-1);'>
		</ol>
	</form>

</body>
</html>