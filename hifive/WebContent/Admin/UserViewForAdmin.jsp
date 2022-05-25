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
	mdao.close(); // DB 연결 해제
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 정보 상세보기</title>
</head>
<body>
	<jsp:include page="../Common/AdminLink.jsp"/> <!-- 공통 링크 -->
	
	<h2 align="center">회원 정보 상세 보기</h2>
	<form name="writeForm">
		<input type="hidden" name="memNum" value="<%= memNum %>"/>
		<table align="center" border="1" width="90%">
			<tr align="center">
				<td>회원 고유번호</td>
				<td><%= mdto.getMemNum() %></td>
				<td>아이디(별명)</td>
				<td><%= mdto.getMemId() %></td>
			</tr>
			<tr align="center">
				<td>나이</td>
				<td><%= mdto.getMemAge() %></td>
				<td>성별</td>
				<td><%= mdto.getMemGender() %></td>
			</tr>
			<tr>
				<td colspan="4" align="center">
					<button type="button" onclick="location.href='EditUserInfoPage.jsp?memNum=<%= mdto.getMemNum() %>';">수정하기</button>
					<button type="button" name="delete" onclick="location.href='DeleteUserProcess.jsp?memNum=<%= mdto.getMemNum() %>';">삭제하기</button>
					<button type="button" onclick="location.href='UserListForAdmin.jsp';">목록 보기</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
