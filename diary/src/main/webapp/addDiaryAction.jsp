<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%	
	//1. 요청 분석
	request.setCharacterEncoding("utf-8");
	String diaryDate = request.getParameter("diaryDate");
	String feeling = request.getParameter("feeling");
	String title = request.getParameter("title");
	String weather = request.getParameter("weather");
	String content = request.getParameter("content");
		
	//디버깅
	System.out.println(diaryDate + "<---diaryDate");   
	System.out.println(feeling + "<---feeling");
	System.out.println(title + "<---title");
	System.out.println(weather + "<---weather");
	System.out.println(content + "<---content");
		
	//2. 비지니스 코드
	String sql ="INSERT INTO diary(diary_date, feeling, title, weather, content, update_date, create_date) VALUES(?, ?, ?, ?, ?, now(), now())";
	Class.forName("org.mariadb.jdbc.Driver");
	
	//자원초기화
	Connection conn = null;
	PreparedStatement stmt = null;
	
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, diaryDate);
	stmt.setString(2, feeling);
	stmt.setString(3, title);
	stmt.setString(4, weather);
	stmt.setString(5, content);
	
	System.out.println(stmt);
	
	int row = stmt.executeUpdate();
	if(row == 1) {
		System.out.println("입력성공");
	} else {
		System.out.println("입력실패");
	}

	// 3. 목록(addDiaryForm.jsp)을 재요청(redirect) 하게 한다
	response.sendRedirect("/diary/addDiaryForm.jsp");
%>
