<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>

<title> 설문조사 </title>
</head>
<body>
<h2> ** 설문조사를 시작합니다! **</h2>
<hr>
<form method="post" action="process.jsp">
<ol type="1">
<li>본인의 연령대를 선택해주세요.<br/>
    <input type="radio" name="agegroup" value="1">14~19세
	<input type="radio" name="agegroup" value="2">20~29세
	<input type="radio" name="agegroup" value="3">30~39세
	<br/><br/>
</li>
<li>본인의 성별을 선택해주세요.<br/>
	<input type="radio" name="sex" value="1">여성
	<input type="radio" name="sex" value="2">남성<br/><br/>
</li>
<li>자주 방문하는 플레이스는 어디일까요? 기타항목 선택 후 직접입력도 가능합니다.
	<br/><input type="radio" name="place" value="1">서부권 (합정, 성수, 망원, 연남, 연희)<br/>	
	<input type="radio" name="place" value="2">강남, 가로수길<br/>
	<input type="radio" name="place" value="3">북촌, 서촌, 삼청동 일대<br/>
	<input type="radio" name="place" value="4">기타(직접입력)&nbsp;&nbsp;&nbsp;
	<input type="text" name="newplace"><br/><br/>
</li>
<li>위 질문의 답변 장소을 가려는 이유는 무엇일까요?
	<br/><input type="radio" name="purpose" value="1">맛집 탐방<br/>	
	<input type="radio" name="purpose" value="2">카페 투어<br/>
	<input type="radio" name="purpose" value="3">사진 촬영<br/>	
	<input type="radio" name="purpose" value="4">그냥! 이유없음<br/>	
</li>		
</ol>
<input type="submit" value="제출">
</form>
<input type="button" value="결과보기" onclick="location='result.jsp'">
</body>
</html>