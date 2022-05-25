<%@ page import="model1.board.BoardDAO"%>
<%@ page import="model1.board.BoardDTO"%>
<%@ page import="membership.MemberDAO"%>
<%@ page import="membership.MemberDTO"%>
<%@ page import="utils.JSFunction"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String memNum = request.getParameter("memNum"); // 일련번호 받기
	System.out.println("멤버고유번호:" + memNum);
	MemberDAO mdao = new MemberDAO(application); // DAO 생성
	MemberDTO mdto = mdao.getMdtoByMemNum(memNum); // 개별 회원 정보 가져오기
	System.out.println("멤버아이디 : " + mdto.getMemId());
	//mdao.close(); // DB 연결 해제
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../Common/AdminLink.jsp"/> <!-- 공통 링크 -->
	
	<h2 align="center">회원 정보 수정하기</h2>
	<form name="writeForm" action="EditUserProcess.jsp?memNum=<%= mdto.getMemNum() %>" method="post">
		<input type="hidden" name="memNum" value="<%= memNum %>"/>
		<table align="center" border="1" width="90%">
			<tr align="center">
				<td>회원 고유번호(수정불가)</td>
				<td><%= mdto.getMemNum() %></td>
				<td>아이디(별명)(수정불가)</td>
				<td><%= mdto.getMemId() %></td>
			</tr>
			<tr align="center">
				<td>나이</td>
				<td><input type="text" name="memAge"/></td>
				<td>성별</td>
				<td><input type="radio" name="memGender" checked="" value="남성">남성 <input type="radio" name="memGender" value="여성">여성</td>
			</tr>
			<tr>
				<td colspan="4" align="center">
					<input type="submit" value="수정완료"/>
					<input type="reset" value="초기화"/>
					<button type="button" onclick="location.href='UserListForAdmin.jsp';">목록 보기</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
