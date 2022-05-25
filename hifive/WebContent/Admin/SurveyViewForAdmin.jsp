<%@ page import="question.QuestionDAO"%>
<%@ page import="question.QuestionDTO"%>
<%@ page import="membership.MemberDAO"%>
<%@ page import="membership.MemberDTO"%>
<%@ page import="service.Survey" %>
<%@ page import="utils.JSFunction"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String memNum = request.getParameter("memNum"); // 회원 고유번호 받기
	String questNum = request.getParameter("questNum"); // 설문 고유번호 받기
	
	MemberDAO mdao = new MemberDAO(application); // DAO 생성
	MemberDTO mdto = mdao.getMdtoByMemNum(memNum); // 개별 회원 정보 가져오기
	System.out.println(mdto.getMemNum());
	QuestionDAO qdao = new QuestionDAO(application);
	QuestionDTO qdto = qdao.searchQuestByQuestNum(questNum);
	System.out.println(qdto.getMemNum());
	String memId = mdto.getMemId();
	System.out.println(memId);
	
	Survey sv = new Survey();
	
	//qdao.close(); // DB 연결 해제
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 정보 상세보기</title>
</head>
<body>
	<jsp:include page="../Common/AdminLink.jsp"/> <!-- 공통 링크 -->
	
	<h2>설문데이터 정보 상세 보기</h2>
	<form name="writeForm">
		<input type="hidden" name="questNum" value="<%= questNum %>"/>
		<table border="1" width="90%">
			<tr>
				<td width="20%">회원 고유번호</td>
				<td width="30%"><%= mdto.getMemNum() %></td>
				<td width="20%">아이디(별명)</td>
				<td><%= mdto.getMemId() %></td>
			</tr>
			<tr>
				<td>나이</td>
				<td><%= mdto.getMemAge() %></td>
				<td>성별</td>
				<td><%= mdto.getMemGender() %></td>
			</tr>
			<tr>
				<td>설문 고유번호</td>
				<td colspan="3"><%= qdto.getQuestNum() %></td>
			</tr>
			<tr>
				<td>설문유형</td>
				<td colspan="3"><%= sv.getQuestion(qdto.getQuestType()) %></td>
			</tr>
			<tr>
				<td>설문응답</td>
				<td colspan="3"><%= sv.getSurveyResult(qdto.getQuestType(), qdto.getQuestAns())%></td>
			</tr>
			<tr>
				<td colspan="4" align="center">
					<button type="button" name="delete" onclick="location.href='DeleteSurveyProcess.jsp?questNum=<%= qdto.getQuestNum() %>';">삭제하기</button>
					<button type="button" onclick="location.href='SurveyListForAdmin.jsp';">목록 보기</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>