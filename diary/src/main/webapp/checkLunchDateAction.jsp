<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
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
    Class.forName("org.mariadb.jdbc.Driver");
    Connection conn = null;

    conn = DriverManager.getConnection(
            "jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	
    
    //투표 가능 여부 확인
	String checkDate2 = request.getParameter("checkDate2");
	
	String sql2 = "select lunch_date lunchDate from lunch where lunch_date=?";
	// 결과가 있으면 이미 이날짜에 이미 점심 투표가 되있다 -> 이날짜로는 입력X
	
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, checkDate2);
	rs2 = stmt2.executeQuery();
	if(rs2.next()) {
	//  이날짜 투표 기록 불가능(이미존재)
		response.sendRedirect("/diary/lunchOne.jsp?checkDate2="+checkDate2+"&ck2=F");
	} else {
		//  이날짜 투표 기록 가능
		response.sendRedirect("/diary/lunchOne.jsp?checkDate2="+checkDate2+"&ck2=T");
	}
	
%>