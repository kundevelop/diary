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
    conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
    
    
    
	// 출력 리스트 모듈
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	/*
	if(request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	*/
	
	int startRow = (currentPage-1)*rowPerPage; // 1-0, 2-10, 3-20, 4-30,....
	
	String searchWord = "";
	if(request.getParameter("searchWord") != null) {
		searchWord = request.getParameter("searchWord");
	}
    
    
    
    
    
	/*
		select diary_date diaryDate, title
		from diary
		where title like ?
		order by diary_date desc
		limit ?, ?
	*/
	String sql2 = "select diary_date diaryDate, title from diary where title like ? order by diary_date desc limit ?, ?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, "%"+searchWord+"%");
	stmt2.setInt(2, startRow);
	stmt2.setInt(3, rowPerPage);
	rs2 = stmt2.executeQuery();
%>
    
<%
	// lastPage 모듈
	String sql3 = "select count(*) cnt from diary where title like ?";
	PreparedStatement stmt3 = null;
	ResultSet rs3 = null;
	stmt3 = conn.prepareStatement(sql3);
	stmt3.setString(1, "%"+searchWord+"%");
	rs3 = stmt3.executeQuery();
	int totalRow = 0;
	if(rs3.next()) {
		totalRow = rs3.getInt("cnt");
	}
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
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
                  background-image: url(/diary/img/note3.png);
                  background-repeat: no-repeat;
                  background-size : cover;
    
            }
            .gr {
                  font-family:"Grandiflora One", cursive;
                  font-weight: bold;
            }
            
                    
            #mainDiv{
                margin-top: 100px;
            }
        </style>
</head>
<body class="gr bg">
    <div class="container text-center" id="mainDiv">
    	<h1>일기 목록</h1>
    	<table border="1" class="table center table-striped table-light table-hover">
    		<tr>
    			<th>날짜</th>
    			<th>제목</th>
    		</tr>
    		<%
    			while(rs2.next()) {
    		%>
    				<tr>
    					<td><a href=""><%=rs2.getString("diaryDate")%></a></td>
    					<td><%=rs2.getString("title")%></td>
    				</tr>
    		<%		
    			}
    		%>
    	</table>
    	
    	<div>
    		<a href="" class="btn btn-outline-light">이전</a>
    		<a href="" class="btn btn-outline-light">다음</a>
            <a href="/diary/diary.jsp" class="btn btn-outline-light">돌아가기</a>
    	</div>
    	<form method="get" action="/diary/diaryList.jsp">
    		<div>
    			제목검색 :
    			<input type="text" name="searchWord">
    			<button type="submit" class="btn btn-outline-light">검색</button>
    		</div>
    	</form>
        </div>
</body>
</html>
