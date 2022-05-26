<%@ page import="service.Matching" %>
<%@ page import="membership.MemberDAO"%>
<%@ page import="membership.MemberDTO"%>
<%@ page import="question.QuestionDAO"%>
<%@ page import="question.QuestionDTO"%>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.Map.Entry" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String memId = session.getAttribute("memId").toString();
	MemberDAO mdao = new MemberDAO();	
	QuestionDAO qdao = new QuestionDAO();
	MemberDTO mdto = mdao.getMdtoByMemId(memId);
	Matching manager = new Matching(mdao, qdao);
	String memNum = mdto.getMemNum();
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>그룹 매칭</title>
</head>
<body>
	<jsp:include page="../Common/UserLink.jsp"/>

	<h2 align="center">그룹 매칭</h2>
	<hr>
	<h4 align="center">그룹 매칭은 당신을 포함하여 총 4명으로 이루어집니다.</h4>
	<h4 align="center">저희가 검토해본 결과, 당신과 가장 잘 어울릴 것 같은 친구들은..</h4>
	<%	
		try {
			String matchingMemNum = "";
			int matchingSimilarity = 0;
			int countLimit = 1;
			Set<Entry<String, Integer>> entrySet = manager.getGroupMatchingMemNum(memNum).entrySet();
			for (Entry<String, Integer> entry : entrySet) {
				if (countLimit == 4) { break; }
				matchingMemNum = entry.getKey();
				matchingSimilarity = entry.getValue();
	%>
				<%= countLimit %> 번째, 
				<h3 align="center"> <mark> <%= mdao.getMdtoByMemNum(matchingMemNum).getMemId() %> </mark> 님입니다!>_< </h3>
				<h4 align="center"> (예상친밀도 <%= matchingSimilarity%>%) (짝짝짝) </h4>
	<%
				++countLimit;
	%>
		<div style=" text-align: center;">
			<button style="display: inline-block;" type="button" onclick="location.href='TalkToGroup.jsp'">그룹으로 대화하기</button>								
		</div>	
	<%	
			}
		} catch (NullPointerException e) { 
	%>	
		<table border="1" align="center">
			<tr>
				<td>
					<h4 align="center">아쉽지만, 아직 매칭되는 회원이 없습니다!ㅠ_ㅠ</h4>
					<h4 align="center">더 많은 사람들이 Hi-Five!에 참여할 수 있도록 공유해주세요!>_<</h4>
				</td>
			</tr>	
		</table><br/>
		<div style=" text-align: center;">
			<button style="display: inline-block;" type="button" onclick="location.href='UserMain.jsp'">마이페이지로 돌아가기</button>								
		</div>	
	<%
			e.printStackTrace(); 
		}	
	%>

</body>
</html>