<%@page import="membership.MemberDAO"%>
<%@page import="membership.MemberDTO"%>
<%@page import="utils.JSFunction"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 폼값 받기
	String memId = request.getParameter("memId");
	String memPwd = request.getParameter("memPwd");
	String memAge = request.getParameter("memAge");
	String memGender = request.getParameter("memGender");

	// 폼값을 DTO 객체에 저장
// 	MemberDTO dto = new MemberDTO();
// 	dto.setMemId(memId);
// 	dto.setMemAge(memAge);
// 	dto.setMemGender(memGender);
// 	dto.setMemPwd(memPwd);
// 	System.out.println(session.getAttribute("memNum"));
// 	dto.setMemNum(""); // 외래키 제약때문에 id가 빈 값이면 INSERT할 때 제약조건 위배로 오류발생하므로 담기
	
	// DAO 객체를 통해 DB에 DTO 저장
	MemberDAO dao = new MemberDAO(application);
	int iResult = dao.insertMember(memId, memPwd, memAge, memGender);
	
	//dao.close();
	
	// 성공 or 실패?
	if (iResult == 1) {
		session.setAttribute("memId", memId);
		session.setAttribute("mode", "user");
		JSFunction.alertLocation("가입이 완료되었습니다!", "UserMain.jsp", out);

	} else {
		JSFunction.alertBack("회원가입 실패하였습니다. 이미 계정이 있으신가요?", out);
	}
%>