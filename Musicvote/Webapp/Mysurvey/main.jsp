<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- 설문조사 폼 --%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset="UTF-8">
<title>MusicVote</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<link href="css/votestyle.css" rel="stylesheet" type="text/css">
</head>
<body>
	<section>
		<table class="musicvote">
				<h1>※설문조사※</h1>
				<h4>좋아하는 음악장르에 대한 설문조사 입니다! 초기화 먼저 진행해주세요 할까</h4>
		
				<input type="submit" value="초기화"
					onclick="initProc.jsp" />
				<input type="submit" value="음악장르등록"
					onclick="insertForm.jsp" />
				<input type="submit" value="설문참여"
					onclick="surveyForm.jsp" />
				<input type="submit" value="항목이름 변경"
					onclick="modifyForm.jsp" />
				<input type="submit" value="설문현황"
					onclick="list.jsp" />
				<input type="submit" value="최종결과확인"
					onclick="voteResult.jsp" />
		</table>
	</section>
</body>
</html>