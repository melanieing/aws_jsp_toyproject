<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String mode = session.getAttribute("mode").toString();

	// 방법1. 회원 인증정보 속성 삭제
	// 인수로 지정한 속성을 삭제하는 메서드
// 	session.removeAttribute("memId");
// 	session.removeAttribute("memPwd");
// 	session.removeAttribute("memNum");
// 	session.removeAttribute("adminId");
// 	session.removeAttribute("adminPwd");
	
	// 방법2. 모든 속성 한꺼번에 삭제
	// 세션 자체를 무효화함  -> 서버는 세션 정보를 더 이상 유지할 필요가 없어 부담이 줄어듦
	session.invalidate();
	
	// 속성 삭제 후 페이지 이동
	if (mode.equals("admin")) {
		response.sendRedirect("AdminLoginForm.jsp");			
	} else if (mode.equals("user")) {
		response.sendRedirect("UserLoginForm.jsp");			
	}
%>