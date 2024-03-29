<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*"%>

<%  
    // 0. 로그인(인증) 분기
    String loginMember = (String)(session.getAttribute("loginMember"));
    if(loginMember == null) {
        String errMsg = URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저 해주세요", "utf-8");
        response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
        return;
    }

%>

<%
    //요청분석
    String diaryDate = request.getParameter("diaryDate");
    String title = request.getParameter("title");
    String weather = request.getParameter("weather");
    String content = request.getParameter("content");
    
    
    //디버깅
    System.out.println(diaryDate + "<-----diaryDate");
    System.out.println(title + "<-----title");
    System.out.println(weather + "<-----weather");
    System.out.println(content + "<-----content");
    
    
    
    Connection conn = null;
    PreparedStatement stmt= null;
    String updatesql = null;

    updatesql = "UPDATE diary SET title=?, weather=?, content=?, update_date=now() WHERE diary_date = ?";
    
    System.out.println(updatesql);
    
    Class.forName("org.mariadb.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
    
    stmt = conn.prepareStatement(updatesql);
    stmt.setString(1,title);   
    stmt.setString(2,weather);
    stmt.setString(3,content);
    stmt.setString(4,diaryDate);
    
    
    
    System.out.println(stmt);

    int row = stmt.executeUpdate();
    
	if(row == 1) { //수정 성공
        System.out.println(row +"<-- 수정성공");
		response.sendRedirect("/diary/diaryOne.jsp?diaryDate="+diaryDate);
	} else{
        System.out.println(row +"<-- 수정실패");
        response.sendRedirect("/updateDiaryForm.jsp?diaryDate="+diaryDate);
    }
    
    //자원반납
    stmt.close();
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