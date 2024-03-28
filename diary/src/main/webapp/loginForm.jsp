<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	//0. 로그인(인증) 분기
	//diary.login.my_session => 'ON' => redirect("diary.jsp")     DB설정
	
	String sql1="SELECT my_session mySession FROM login";  // my_session 값가져오는데 별칭으로 가져온다
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
	
	if(mySession.equals("ON")) {
		response.sendRedirect("/diary/loginForm.jsp");
		//DB자원반납
		rs1.close();
		stmt1.close();
		conn.close();
		return; //코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return사용
	}
		rs1.close();
		stmt1.close();
		conn.close();
	
		//1. 요청값 분석
		String errMsg = request.getParameter("errMsg");
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
		<style>
		@import url('https://fonts.googleapis.com/css2?family=Grandiflora+One&display=swap');
		
		
		.gr {
			  font-family:"Grandiflora One", cursive;
			  font-weight: bold;
		}
		
		.cen { 
				width: 40%;
				height: 50%;
				/* 수평 중앙 정렬하기 */
				margin-left:auto;
				margin-right:auto;
			 	
		}
		
		.bg {
			  background-image: url(/diary/img/login2.jpg);
			  background-repeat: no-repeat;
			  background-size : cover;

		}
        #mainDiv {
            margin-top: 200px;
        
        }
		</style>
</head>
<body class="bg gr bg-success-subtle">
	<div class = "container" id="mainDiv">
		<div class="cen">	
			<h1 style="text-align: center">&#129442로그인&#129442</h1>
			<form method="post" action="/diary/loginAction.jsp">
				<div>
					<%
						if(errMsg != null) {
							
					%>
						<%=errMsg %>
					<%
					
						}
					%>	
				
				</div>
				
				<div class="cen" style="text-align: center">아이디 <input type ="text" name="memberId"></div> <br>
				<div class="cen" style="text-align: center">비밀번호  <input type ="password" name="memberPw"></div> <br>
				
				<nav aria-label="Page navigation example cen">
  					<ul class="pagination justify-content-center">
  				
				
						<li><button type ="submit" class="btn btn-primary">&#129442로그인&#129442</button></li>
					</ul>
				</nav>
				
			</form>
		</div>
	</div>
</body>
</html>