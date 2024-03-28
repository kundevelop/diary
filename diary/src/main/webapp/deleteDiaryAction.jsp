<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*"%>

<%
    //로그인(인증) 분기
    //diary.login.my_session => 'OFF'=> redirect("loginForm.jsp") DB설정
    
    String sql1="SELECT my_session mySession FROM login"; // my_session 값가져오는데 별칭으로 가져온다
    Class.forName("org.mariadb.jdbc.Driver");
    Connection conn = null;
    PreparedStatement stmt1 = null;
    ResultSet rs1 = null;
    conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
    stmt1 = conn.prepareStatement(sql1);
    rs1 = stmt1.executeQuery();
    
    String mySession = null;
    if(rs1.next()) {
        mySession = rs1.getString("mySession"); // 괄호안에 1적으면 컬럼명 첫번째꺼 가르킴
    }
    
    if(mySession.equals("OFF")) {
        String errMsg = URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저해주세요", "utf-8"); //utf-8로 인코딩
        response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
        //DB자원반납
        rs1.close();
        stmt1.close();
        conn.close();
        return; //코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return사용
    }

%>

<%
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