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
	String checkDate = request.getParameter("checkDate");
	if(checkDate == null) {
		checkDate = "";
	}
	String ck = request.getParameter("ck");
	if(ck == null) {
		ck = "";
	}
	
	String msg = "";
	if(ck.equals("T")) {
		msg = "입력이 가능한 날짜입니다";
	} else if(ck.equals("F")){
		msg = "일기가 이미 존재하는 날짜입니다";
	}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>addDiaryForm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Grandiflora+One&display=swap');
        /*a { 
        
            text-decoration-line: none; 
            display: block; 
            text-align: center; 
        }a태그는 인라인 속성이라 text align이 안됨 */
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
            margin-top: 132px;
        }
        
     </style>
</head>
<body class="gr bg">
    <div class="container text-center" id="mainDiv">


	<h1>일기쓰기</h1>
	
	<form method="post" action="/diary/checkDateAction.jsp">	
		<div>
			날짜확인 : <input type="date" name="checkDate" value="<%=checkDate%>">
			<span><%=msg%></span>
            <button type="submit">날짜가능확인</button>
		</div>

	</form>
	
	<br>
	
	<form method="post" action="/diary/addDiaryAction.jsp">
		<div>
			날짜 : 
			<%
				if(ck.equals("T")) {
			%>
					<input value="<%=checkDate%>" type="text" name="diaryDate" readonly="readonly">
			<%		
				} else {
			%>
					<input value="" type="text" name="diaryDate" readonly="readonly">				
			<%		
				}
			%>
			
			제목 : <input type="text" name="title">
		</div>
        <br>
        
        <div>
            기분 :
            <input type="radio" name ="feeling" value="&#128512;">&#128512;
            <input type="radio" name ="feeling" value="&#128545;">&#128545;
            <input type="radio" name ="feeling" value="&#128567;">&#128567;
            <input type="radio" name ="feeling" value="&#128561;">&#128561;
            <input type="radio" name ="feeling" value="&#128565;">&#128565;
            <input type="radio" name ="feeling" value="&#128564;">&#128564; 
            
            &nbsp;&nbsp;&nbsp;날씨:
            <select name="weather">
                <option value="맑음">맑음</option>
                <option value="흐림">흐림</option>
                <option value="비">비</option>
                <option value="눈">눈</option>
            </select>
        
        </div>
        
		<div>
			<textarea rows="7" cols="50" name="content"></textarea>
		</div>
		<div>
			<button type="submit" class="btn btn-outline-light">입력</button>
            <a href ="/diary/diary.jsp" class="btn btn-outline-light">돌아가기</a>
		</div>
		</form>
     </div>
</body>
</html>