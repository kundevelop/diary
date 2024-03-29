<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*"%>

<%
    /*
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
    }*/
    
  
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

    conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
    
    String diaryDate = request.getParameter("diaryDate");

    String onesql = "SELECT diary_date as diaryDate , title, weather, content, update_date, create_date FROM diary WHERE diary_date = ?";
    
    System.out.println(onesql);
    
	PreparedStatement stmt2= null;
    ResultSet rs2 = null;
    stmt2 = conn.prepareStatement(onesql);
    stmt2.setString(1,diaryDate);
    
    System.out.println(stmt2);


    rs2 = stmt2.executeQuery();
    
    //자원반납
    rs2.close();
    stmt2.close();
    conn.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Grandiflora+One&display=swap');
        a { 
        
            text-decoration-line: none; 
            display: block; 
            
            
        } /*a태그는 인라인 속성이라 text align이 안됨*/ 
        
        .bg {
              background-image: url(/diary/img/note2.png);
              background-repeat: no-repeat;
              background-size : cover;

        }
        .gr {
              font-family:"Grandiflora One", cursive;
              font-weight: bold;
        }
        
        #diaryDiv{
            margin-top : 90px;
            width: 500px;
            height: 600px;
            padding: 0px;
        }
        #mainDiv{
            margin-top: 100px;
        }
        
       </style>
</head>
<body class="bg gr">
    

    
    <!-- 메인 내용 -->
    <div class="container text-center" id="mainDiv">
    <h1>&#128210 일기장 보기 &#128210</h1>
    
    <%
        if(rs2.next()) {
    %>  <div class="container" id="diaryDiv">
            <table class="table center table-warning">
                <tr>
                    <th>날짜 :</th>
                    <td><%=rs2.getString("diaryDate")%></td>
                </tr>
                
                <tr>
                    <th>제목 :</th>
                    <td><%=rs2.getString("title")%></td>
                </tr>
                
                <tr>
                    <th>날씨 :</th>
                    <td><%=rs2.getString("weather")%></td>
                </tr>
                
                <tr>
                    <th>내용 :</th>
                    <td><%=rs2.getString("content")%></td>
                </tr>
                
                <tr>
                    <th> 업데이트날짜 :</th>
                    <td><%=rs2.getString("update_date")%></td>
                </tr>
                
                <tr>
                    <th> 게시날짜 :</th>
                    <td><%=rs2.getString("create_date")%></td>
                </tr>
            
            
            </table>
            <div>
                <a href="/diary/diary.jsp" class="btn btn-outline-light">돌아가기</a>
                <a href="/diary/updateDiaryForm.jsp?diaryDate=<%=rs2.getString("diaryDate")%>" 
                    class="btn btn-outline-light">수정</a>
                <a href="/diary/deleteDiaryAction.jsp?diaryDate=<%=rs2.getString("diaryDate")%>" 
                    class="btn btn-outline-light">삭제</a>


            </div>
        </div>
    <%
        }
    %>
    
    </div>
    
   <!-- 메인 내용 종료 -->
</body>
</html>