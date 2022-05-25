<%@page import="question.QuestionDAO"%>
<%@page import="question.QuestionDTO"%>
<%@page import="membership.*"%>
<%@page import="utils.JSFunction"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	String memId = session.getAttribute("memId").toString();
	MemberDAO mdao = new MemberDAO();	
	MemberDTO mdto = mdao.getMdtoByMemId(memId);
	
	
	// 폼값 받기
	String[] questAns = new String[5];
	for (int i = 0; i < 5; i++) {
		questAns[i] = request.getParameter(Integer.toString(i+1));
	}

	// DAO 객체를 통해 DB에 DTO 저장
	QuestionDAO dao = new QuestionDAO(application);
	int[] iResults = new int[5];
	
	if (dao.getQdtoByMemNum(mdto.getMemNum()) != null) { // 이미 등록된 설문응답 정보가 있으면, 원래 데이터 삭제하고 
		dao.deleteByMemNum(mdto.getMemNum());
	}	
	for (int i = 0; i < 5; i++) { // 추가하기
		iResults[i] = dao.insertQuestion(mdto.getMemNum(), Integer.toString(i+1), questAns[i]);
	}
	
	dao.close();
	
	// 성공 or 실패?
	if (iResults[0] != 0 && iResults[1] != 0 && iResults[2] != 0 && iResults[3] != 0 && iResults[4] != 0) {
		JSFunction.alertLocation("설문응답이 업데이트되었습니다!", "UserMain.jsp", out);		
	} else {
		JSFunction.alertBack("설문응답 업데이트에 실패하였습니다.", out);
	}	

%>