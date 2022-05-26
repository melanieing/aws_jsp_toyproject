<%@ page import="service.Matching" %>
<%@ page import="membership.*"%>
<%@ page import="question.*"%>
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
	<title>1:1 매칭</title>
</head>
<body>
	<jsp:include page="../Common/UserLink.jsp"/>

	<h2 align="center">1:1 매칭</h2>
	<hr>
	<h4 align="center">저희가 검토해본 결과, 당신과 가장 잘 어울릴 것 같은 친구는..</h4>
	<%	
		try {
			String matchingMemNum = "";
			int matchingSimilarity = 0;
			Set<Entry<String, Integer>> entrySet = manager.getOneMatchingMemNum(memNum).entrySet();
			for (Entry<String, Integer> entry : entrySet) {
				matchingMemNum = entry.getKey();
				matchingSimilarity = entry.getValue();	
			}
			if (mdao.getMdtoByMemNum(matchingMemNum).getMemId() == null) {
				throw new Exception();
			} else {
	%>
			<h3 align="center"> <mark> <%= mdao.getMdtoByMemNum(matchingMemNum).getMemId() %> </mark> 님입니다!>_< </h3>
			<h4 align="center"> (예상친밀도 <%= matchingSimilarity%> %) (짝짝짝)</h4>
			<div style=" text-align: center;">
				<button style="display: inline-block;" type="button" onclick="location.href='TalkToOne.jsp'">1:1로 대화하기</button>								
			</div>
	<%			
			}
		} catch (Exception e) {
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