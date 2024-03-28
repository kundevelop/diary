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

    String updatesql = "SELECT diary_date as diaryDate, title, weather, content FROM diary WHERE diary_date = ?";
    
    System.out.println(updatesql);
    
	PreparedStatement stmt2= null;
    ResultSet rs2 = null;
    stmt2 = conn.prepareStatement(updatesql);
    stmt2.setString(1,diaryDate);
    
    System.out.println(stmt2);


    rs2 = stmt2.executeQuery();
    
    //자원반납
    //rs2.close();
    //stmt2.close();
    //conn.close();
    
    if(rs2.next()) { 
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
        </style>
</head>
<body class="bg gr">
    <h1>일기 수정하기</h1>
        <div>
            <form method = "post" action="/diary/updateDiaryAction.jsp">

            <table>
                <tr>
                    <td>날짜 :</td>
                    <td><input type = "text" name = "diaryDate" value ='<%=rs2.getString("diaryDate")%>'></td>
    
                </tr>
    
    
                <tr>
                    <td>제목 :</td>
                    <td><input type = "text" name = "title" value ='<%=rs2.getString("title")%>'></td>
        
                </tr>
    
    
                <tr>
                    <td>
                        <select name="weather">
                            <%
                                if(rs2.getString("weather").equals("맑음")) {
                            
                            %>
                                <option value="맑음" selected="selected">맑음</option>
                                <option value="흐림">흐림</option>
                                <option value="비">비</option>
                                <option value="눈">눈</option>
                            <%
                            
                                } else if(rs2.getString("weather").equals("흐림")) {
                                
                            %>
                                <option value="맑음">맑음</option>
                                <option value="흐림" selected="selected">흐림</option>
                                <option value="비">비</option>
                                <option value="눈">눈</option>
                                
                            <%
                            
                                } else if(rs2.getString("weather").equals("비")) {
                            
                            %>
                                <option value="맑음">맑음</option>
                                <option value="흐림">흐림</option>
                                <option value="비" selected="selected">비</option>
                                <option value="눈">눈</option>
                                
                            <%
                            
                                } else {
                            
                            %>
                                <option value="맑음">맑음</option>
                                <option value="흐림">흐림</option>
                                <option value="비">비</option>
                                <option value="눈" selected="selected">눈</option>
                            <%
                                }
                    
                            %>

                        </select>
                    </td>
                </tr>
    
     
                <tr>
                    <td><input type = "text" name = "content" value ='<%=rs2.getString("content")%>'></td>
                </tr>

            </table>
    		<div>
        		<input type="hidden" name="update_date">
        		<input type="hidden" name="create_date">
    		</div>



                <button type="submit" class="btn btn-outline-light">수정</button>
            
    
    
            </form>
            
        </div>
</body>
</html>
<%
    }
%>
