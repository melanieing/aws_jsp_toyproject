<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.List"%>
<%@ page import="membership.*" %>
<%@ page import="question.*" %>
<%@ page import="utils.BoardPage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// DAO를 생성해 DB에 연결
	MemberDAO mdao = new MemberDAO();
	QuestionDAO qdao = new QuestionDAO();

	// 사용자가 입력한 검색 조건을 Map에 저장
	Map<String, Object> param = new HashMap<String, Object>();
	String searchField = request.getParameter("searchField"); // memNum, memAge, memGender, (+memId : 어떻게?)
	String searchWord = request.getParameter("searchWord");
	if (searchWord != null) {
		param.put("searchField", searchField);
		param.put("searchWord", searchWord);
	}
	
	int totalCount = qdao.selectCount(param); // 총 설문데이터 수 확인
	
	/*** 페이징 처리 start ***/
	// 전체 페이지 수 계산
	int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE")); // 10
	int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK")); // 5
	int totalPage = (int)Math.ceil((double)totalCount / pageSize); // 전체 페이지 수
	
	// 전체 페이지 확인
	int pageNum = 1; // 기본값
	String pageTemp = request.getParameter("pageNum");
	if (pageTemp != null && !pageTemp.equals("")) {
		pageNum = Integer.parseInt(pageTemp); // 요청받은 페이지로 수정
	}
	
	// 목록에 출력할 게시물 범위 계산
	int start = (pageNum - 1) * pageSize + 1; // 첫 설문데이터 번호
	int end = pageNum * pageSize; // 마지막 설문데이터 번호
	param.put("start", start);
	param.put("end", end);
	/*** 페이지 처리 end ***/
	
	List<QuestionDTO> questionLists = qdao.selectQdtoListPage(param); // 설문데이터 목록 받기

	qdao.close(); // DB 연결 닫기 
%>
    

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>설문데이터 목록 </title>
</head>
<body>
	<jsp:include page="../Common/AdminLink.jsp"/> <!-- 공통 링크 -->

	<h2 align="center">설문데이터 목록</h2>
	<!-- - 현재 페이지 : <%--= pageNum --%> (전체 : <%--=totalPage --%>)  -->
	<!-- 검색 폼 -->
	<form method="get"> <!-- action 속성 지정 안했으므로 submit 시 폼값이 현재 페이지로 전송됨 -->
		<table align="center" border="1" width="90%">
			<tr>
				<td align="center">
					<select name="searchField">
						<!--<option value="memId">응답자 아이디(별명)</option> -->
						<option value="memNum">응답자 고유번호</option>
						<option value="questType">설문유형</option>
						<option value="questAns">설문응답</option>
					</select>
					<input type="text" name="searchWord"/>
					<input type="submit" value="검색하기"/>
				</td>
			</tr>
		</table>
	</form>
	
	<!-- 회원 목록 테이블 -->
	<table align="center" border="1" width="90%">
		<!-- 각 컬럼의 이름 -->
		<tr>
			<th width="10%">번호</th>
			<th width="20%">설문 고유번호</th>
			<th width="30%">응답자 아이디(별명)</th>
			<th width="20%">설문유형</th>
			<th width="20%">설문응답</th>
		</tr>
		<!-- 목록의 내용 -->
<%
	if (questionLists.isEmpty()) {
		// 회원 목록이 하나도 없을 떄
%>		
		<tr>
			<td colspan="5" align="center">
				해당하는 설문데이터가 없습니다ㅠ_ㅠ
			</td>
		</tr>
<%	
	} else { // 설문데이터 목록이 있을 때 
		int virtualNum = 0; // 화면상에서의 게시물 번호
		int countNum = 0;
		for (QuestionDTO qdto : questionLists) {
			// virtualNum = totalCount--; // 전체 게시물 수에서 시작해 1씩 감소
			virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);
%>
		<tr align="center">
			<td><%= virtualNum %></td> <!-- 설문 번호 -->
			<td align="center"> <!-- 설문 고유번호 (+하이퍼링크) -->
				<a href="SurveyViewForAdmin.jsp?questNum=<%= qdto.getQuestNum() %>&memNum=<%= qdto.getMemNum()%>"><%= qdto.getQuestNum() %></a>
			</td>
			<td align="center"><%= mdao.getMdtoByMemNum(qdto.getMemNum()).getMemId() %></td> <!-- 회원 아이디 -->
			<td align="center"><%= qdto.getQuestType() %></td> <!-- 회원 설문유형 -->
			<td align="center"><%= qdto.getQuestAns() %></td> <!-- 회원 설문응답-->
		</tr>
<%
		}
	}
%>			
	</table>
	<!-- 목록 하단  -->
	<table align="center" border="1" width="90%">
		<tr align="center">
			<!-- 페이징 처리 -->
			<td>
				<%= BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, request.getRequestURI()) %>
			</td>
		</tr>
		<tr align="right">
			<td>
				<button type="button" onclick="location.href='<%=request.getContextPath()%>/Admin/SurveyListForAdmin.jsp'">전체 목록보기</button>
			</td>
		</tr>
	</table>
	
</body>
</html>