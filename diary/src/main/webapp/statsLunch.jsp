<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
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
	/*
	SELECT menu,COUNT(*) 
	FROM lunch
	GROUP BY menu
	ORDER BY COUNT(*) DESC;
	*/
	String sql2 = "select menu, count(*) cnt from lunch group by menu";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	rs2 = stmt2.executeQuery();
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
              background-image: url(/diary/img/vote.png);
              background-repeat: no-repeat;
              background-size : cover;

        }
        .gr {
              font-family:"Grandiflora One", cursive;
              font-weight: bold;
        }
     </style>
</head>
<body class="gr">
	<h1>점심통계</h1>
	
	<%
				double maxHeight = 500;
				double totalCnt = 0; 
				while(rs2.next()) {
					totalCnt = totalCnt + rs2.getInt("cnt");
				}
				
				rs2.beforeFirst();
	%>
	<div>
		전체 투표수 : <%=(int)totalCnt%>
	</div>
	<table border="1" style="width: 400px;">
		<tr>
			<%	
				String[] c = {"#FF0000", "#FF5E00", "#FFE400", "#1DDB16", "#0054FF"};
				int i = 0;
				while(rs2.next()) {
					int h = (int)(maxHeight * (rs2.getInt("cnt")/totalCnt));
			%>
					<td style="vertical-align: bottom;">
						<div style="height: <%=h%>px; 
									background-color:<%=c[i]%>;
									text-align: center">
							<%=rs2.getInt("cnt")%>
						</div>
					</td>
			<%		
					i = i+1;
				}
			%>
		</tr>
		<tr>
			<%
				// 커스의 위치를 다시 처음으로
				rs2.beforeFirst();
							
				while(rs2.next()) {
			%>
					<td><%=rs2.getString("menu")%></td>
			<%		
				}
			%>
		</tr>
	</table>
	<div><a href="/diary/diary.jsp" class="btn btn-dark">처음으로</a>
         <a href="/diary/lunchOne.jsp" class="btn btn-dark">뒤로가기</a>
    </div>
    
	
	
</body>
</html>
