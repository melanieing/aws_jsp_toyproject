<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="survey.*" %>
 <% request.setCharacterEncoding("UTF-8"); %>

<%
	InfoDao infodao = InfoDao.getInstance();
	PlaceDao placedao = PlaceDao.getInstance();
	PurposeDao purposedao = PurposeDao.getInstance();	
	
%>

<%

		int newpcode = placedao.placeNum()+1; 

int age = Integer.parseInt(request.getParameter("agegroup"));                              
int sex = Integer.parseInt(request.getParameter("sex"));
int place = Integer.parseInt(request.getParameter("place"));
String newplace = request.getParameter("newplace");
int purpose = Integer.parseInt(request.getParameter("purpose"));
		
	infodao.insertinfo(new InfoVo(age, sex));
	
	 if (place == 4) {
/* 		 newpcode++; */		 
		placedao.insertplace(new PlaceVo(newpcode, newplace));
		purposedao.insertpurpose(new PurposeVo(newpcode, purpose));
		
		
	} else {
	purposedao.insertpurpose(new PurposeVo(place, purpose));
	}

	
	%>
	
<% response.sendRedirect("submit.jsp"); %>
	
	
