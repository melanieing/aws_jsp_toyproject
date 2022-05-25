<%@ page import="common.JDBCConnect"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Connection"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>JDBC</title>
</head>
<body>
	<h2>회원 추가 테스트(executeUpdate() 사용)</h2>
	<%
		// DB 연결
		JDBCConnect jdbc = new JDBCConnect();
	
		// 테스트용 입력값 준비
		String id = "test2";
		// String id = request.getParameter("id");
		String pass = "1111";
		// String pass = request.getParameter("pwd");
		String name = "테스트2회원";
		// String name = request.getParameter("name");
		
		// 쿼리문 생성
		String sql = "INSERT INTO member VALUES (?, ?, ?, sysdate)";
		PreparedStatement psmt = jdbc.con.prepareStatement(sql); 
		// out.println(psmt); // oracle.jdbc.driver.OraclePreparedStatementWrapper@7cbcd5b8
		psmt.setString(1, id);
		psmt.setString(2, pass);
		psmt.setString(3, name);
		
		// 쿼리 실행
		int inResult = psmt.executeUpdate();
		out.println(inResult + "행이 입력되었습니다.");
		
		// 연결 닫기
		jdbc.close();
		
		
	%>
</body>
</html>