<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*"%>

<%
    //로그인(인증) 분기

	String loginMember = (String)(session.getAttribute("loginMember"));
    
	if(loginMember == null) {
		String errMsg = URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저 해주세요", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
		return;
	}

%>

<%

    Connection conn = null;

    conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
    String diaryDate = request.getParameter("diaryDate");
    System.out.println(diaryDate + "<-----diaryDate");
    
    String onesql = "DELETE FROM diary WHERE diary_date = ?";
    
    System.out.println(onesql);
    
    PreparedStatement stmt2= null;
    stmt2 = conn.prepareStatement(onesql);
    stmt2.setString(1,diaryDate);
    
    System.out.println(stmt2);
    

    int row = stmt2.executeUpdate();
    
	if(row == 1) { // 삭제실패 -> 비밀번호 
		System.out.println("삭제성공");
		response.sendRedirect("/diary/diaryList.jsp");
	}
    
    //자원반납
    stmt2.close();
    conn.close();

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
</body>
</html>