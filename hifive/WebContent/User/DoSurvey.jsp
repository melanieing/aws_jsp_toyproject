<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>설문조사 참여하기</title>
	<link rel="icon" href="data:;base64,iVBORw0KGgo=">
	<script type="text/javascript">
		function validateForm(form) { // 폼 내용 검증
			var checked_one = document.querySelector('input[name = "1"]:checked');
			var checked_two = document.querySelector('input[name = "2"]:checked');
			var checked_three = document.querySelector('input[name = "3"]:checked');
			var checked_four = document.querySelector('input[name = "4"]:checked');
			var checked_five = document.querySelector('input[name = "5"]:checked');

			if (checked_one == null){  
				alert("1번 문제의 답을 선택하세요."); 
				return false;
			} else if (checked_two == null) {
				alert("2번 문제의 답을 선택하세요.");
				return false;
			} else if (checked_three == null) {
				alert("3번 문제의 답을 선택하세요."); 
				return false;
			} else if (checked_four == null) {
				alert("4번 문제의 답을 선택하세요.");
				return false;
			} else if (checked_five == null) {
				alert("5번 문제의 답을 선택하세요.");
				return false;
			} 
		}
	</script>
</head>
<body>
	<jsp:include page="../Common/UserLink.jsp"/>
	<h2>설문조사 참여하기</h2>
	<form name="surveyForm" method="post" action="DoSurveyProcess.jsp" onsubmit="return validateForm(this)">
		<table border="1" width="90%">
			<tr>
				<td colspan="1" align="center">설문유형1.당신은 모든 메뉴가 맛있다는 김밥천국에 왔습니다. 어떤 음식을 먹을까요?</td>
			</tr>
			<tr>
				<td colspan="1">
					<input type="radio" name="1" value="1">① 김밥류(야채/참치/치즈김밥 등)<br/>
					<input type="radio" name="1" value="2">② 식사류(비빔밥/덮밥/볶음밥 등)<br/>
					<input type="radio" name="1" value="3">③ 찌개류(김치찌개/뚝불 등)<br/>
					<input type="radio" name="1" value="4">④ 분식류(라면/떡복이/만두 등)<br/>
					<input type="radio" name="1" value="5">⑤ 튀김류(돈까스/생선까스 등)
				</td>
			</tr>
			<tr>
				<td colspan="1" align="center">설문유형2. 당신은 혼자 영화관에 왔습니다. 어떤 영화를 볼까요?</td>
			</tr>
			<tr>
				<td colspan="1">
					<input type="radio" name="2" value="1">① 스릴 넘치는 액션/범죄 영화<br/>
					<input type="radio" name="2" value="2">② 꿈에 나올까 무서운 공포 영화<br/>
					<input type="radio" name="2" value="3">③ 달달하고 설레는 로맨스 영화<br/>
					<input type="radio" name="2" value="4">④ 웃겨서 뒤집어지는 코미디 영<br/>
					<input type="radio" name="2" value="5">⑤ 매니아틱한 판타지 영화 (해리포터, 어벤저스 등)
				</td>
			</tr>			<tr>
				<td colspan="1" align="center">설문유형3. 당신은 버스를 타고 이어폰을 꽂았습니다. 어떤 노래를 들을까요?</td>
			</tr>
			<tr>
				<td colspan="1">
					<input type="radio" name="3" value="1">① 아이유의 희망차고 밝은 노래<br/>
					<input type="radio" name="3" value="2">② 백예린의 잔잔하고 편안한 노래<br/>
					<input type="radio" name="3" value="3">③ 지코, 비오의 귀에 때력박는 빡센 힙합<br/>
					<input type="radio" name="3" value="4">④ 크러쉬의 그루비한 알앤비<br/>
					<input type="radio" name="3" value="5">⑤ 숀의 속이 뻥 뚫리는 EDM
				</td>
			</tr>			<tr>
				<td colspan="1" align="center">설문유형4. 당신은 동아리에 들고 싶습니다. 어떤 동아리에 가입할까요?</td>
			</tr>
			<tr>
				<td colspan="1">
					<input type="radio" name="4" value="1">① 밴드부/합창단/오케스트라<br/>
					<input type="radio" name="4" value="2">② 독서/시사토론 동아리/방송반<br/>
					<input type="radio" name="4" value="3">③ 운동/댄스 동아리<br/>
					<input type="radio" name="4" value="4">④ 봉사/교육동아리<br/>
					<input type="radio" name="4" value="5">⑤ 친목/문화생활 동아리
				</td>
			</tr>			<tr>
				<td colspan="1" align="center">설문유형5. 바쁜 당신에게 자유시간이 생겼습니다. 뭐할까요?</td>
			</tr>
			<tr>
				<td colspan="1">
					<input type="radio" name="5" value="1">① 자기계발/공부해야지!<br/>
					<input type="radio" name="5" value="2">② 운동이나 하자~<br/>
					<input type="radio" name="5" value="3">③ 친구 만나서 놀기<br/>
					<input type="radio" name="5" value="4">④ 한 숨 잘거야...<br/>
					<input type="radio" name="5" value="5">⑤ 게임 한 판ㄱㄱ
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button type="submit">작성 완료</button>
					<button type="reset">다시 입력</button>
					<button type="button" onclick="location.href='UserMain.jsp';">마이페이지로 돌아가기</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>