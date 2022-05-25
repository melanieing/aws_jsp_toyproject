<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.List"%>
<%@ page import="membership.MemberDTO"%>
<%@ page import="membership.MemberDAO"%>
<%@ page import="utils.BoardPage"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// DAO를 생성해 DB에 연결
	MemberDAO dao = new MemberDAO();
	
	// 사용자가 입력한 검색 조건을 Map에 저장
	Map<String, Object> param = new HashMap<String, Object>();
	String searchField = request.getParameter("searchField"); // memId, memAge, memGender
	String searchWord = request.getParameter("searchWord");
	if (searchWord != null) {
		param.put("searchField", searchField);
		param.put("searchWord", searchWord);
	}
	
	int totalCount = dao.selectCount(param); // 게시물 수 확인
	
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
	int start = (pageNum - 1) * pageSize + 1; // 첫 게시물 번호
	int end = pageNum * pageSize; // 마지막 회원 번호
	param.put("start", start);
	param.put("end", end);
	/*** 페이지 처리 end ***/
	
	List<MemberDTO> memberLists = dao.selectMdtoListPage(param); // 게시물 목록 받기
	dao.close(); // DB 연결 닫기
%>
    

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원정보 관리</title>
</head>
<body>
	<jsp:include page="../Common/AdminLink.jsp"/> <!-- 공통 링크 -->

	<h2 align="center">회원 목록</h2>
	<!--  - 현재 페이지 : <%--= pageNum --%> (전체 : <%--=totalPage --%>) -->
	<!-- 검색 폼 -->
	<form method="get"> <!-- action 속성 지정 안했으므로 submit 시 폼값이 현재 페이지로 전송됨 -->
		<table align="center" border="1" width="90%">
			<tr align="center">
				<td>
					<select name="searchField">
						<option value="memId">아이디(별명)</option>
						<option value="memAge">나이</option>
						<option value="memGender">성별</option>
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
			<th width="20%">회원고유번호</th>
			<th width="30%">아이디(별명)</th>
			<th width="20%">나이</th>
			<th width="20%">성별</th>
		</tr>
		<!-- 목록의 내용 -->
<%
	if (memberLists.isEmpty()) {
		// 회원 목록이 하나도 없을 떄
%>		
		<tr>
			<td colspan="5" align="center">
				해당하는 회원이 없습니다ㅠ_ㅠ
			</td>
		</tr>
<%	
	} else { // 회원 목록이 있을 때 
		int virtualNum = 0; // 화면상에서의 게시물 번호
		int countNum = 0;
		for (MemberDTO dto : memberLists) {
			// virtualNum = totalCount--; // 전체 게시물 수에서 시작해 1씩 감소
			virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);
%>
		<tr align="center">
			<td><%= virtualNum %></td> <!-- 회원 번호 -->
			<td align="center"><%= dto.getMemNum() %></td> <!-- 회원 고유번호 -->
			<td align="center"> <!-- 회원아이디(+하이퍼링크) -->
				<a href="UserViewForAdmin.jsp?memNum=<%= dto.getMemNum() %>"><%= dto.getMemId() %></a>
			</td>
			<td align="center"><%= dto.getMemAge() %></td> <!-- 회원 나이 -->
			<td align="center"><%= dto.getMemGender() %></td> <!-- 회원 성별 -->
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
				<button type="button" onclick="location.href='<%=request.getContextPath()%>/Admin/UserListForAdmin.jsp'">전체 목록보기</button>
			</td>
		</tr>
	</table>
	
</body>
</html>