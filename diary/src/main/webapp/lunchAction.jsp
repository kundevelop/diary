<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%
    //요청
    String lunchDate = request.getParameter("lunchDate");
    String menu = request.getParameter("menu");

    //디버깅
    System.out.println(menu+"<------menu");
    
    
    
    //비지니스 코드
    
    String sql ="INSERT INTO lunch(lunch_date, menu, update_date, create_date) VALUES(?, ?, NOW(), NOW())";
	Class.forName("org.mariadb.jdbc.Driver");
	
	//자원초기화
	Connection conn = null;
	PreparedStatement stmt = null;
	
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
    stmt = conn.prepareStatement(sql);
    stmt.setString(1, lunchDate);
    stmt.setString(2, menu);
    
	int row = stmt.executeUpdate();
    
	if(row == 1) {
		System.out.println("투표성공");
	} else {
		System.out.println("투표실패");
	}
    
	// 3. 목록(statsLunch.jsp)을 재요청(redirect) 하게 한다
	response.sendRedirect("/diary/statsLunch.jsp");
    
   
%>    