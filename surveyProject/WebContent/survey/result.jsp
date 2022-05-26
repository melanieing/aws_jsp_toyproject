  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="survey.*, java.util.List" %>
<jsp:useBean id="info" class="survey.InfoVo" />
<jsp:useBean id="place" class="survey.PlaceVo" />
<jsp:useBean id="purpose" class="survey.PurposeVo" />
<jsp:setProperty name="vo" property="*" />

<%
	InfoDao infodao = InfoDao.getInstance();
	PlaceDao placedao = PlaceDao.getInstance();
	PurposeDao purposedao = PurposeDao.getInstance();		
%>
<html>
<head>

<title>설문조사 결과</title>
</head>
<body>

<h2>** 설문조사 결과 **</h2>
<hr>
<ul>
	<li>설문참여인원  : <%=purposedao.counttotal() %> 명</li>
	<li>10대 :  <%=infodao.countinfoage1() %>명<br>
	    20대 : <%=infodao.countinfoage2()%>명<br>
	    30대 : <%=infodao.countinfoage3() %>명</li>
	<li>여성 : <%=infodao.countinfosex1() %>명 <br> 
	       남성 : <%=infodao.countinfosex2() %>명</li>
</ul>
<hr>
<h3>&lt;플레이스 결과 집계&gt;</h3>

<table border="1">
	<tr><th>순위</th><th>플레이스</th><th>득표수</th></tr>
	<% 
	List<RankVo> lsplace = placedao.rankplace();
	for(int i = 0; i < lsplace.size(); i++){ %>
	<tr>
	<td><%=i+1%>위</td>
	<td><%= lsplace.get(i).getplace() %></td>
	<td><%= lsplace.get(i).getvote() %></td>
	</tr>
	<% } %>
</table>

<h3>&lt;방문 목적 결과 집계&gt;</h3>

<table border="1">
	<tr><th>순위</th><th>목적</th><th>득표수</th></tr>
	<% 
	List<RankVo> lspurpose = purposedao.rankpurpose();
	for(int i = 0; i < lspurpose.size(); i++){ %>
	<tr>
	<td><%=i+1%>위</td>
	<td><%= lspurpose.get(i).getPurposeStr() %></td>
	<td><%= lspurpose.get(i).getCount() %></td>
	</tr>
	<% } %>
</table><br><br>
</body>
</html>