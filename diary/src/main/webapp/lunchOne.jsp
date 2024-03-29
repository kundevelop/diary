<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    //점심 투표 가능 여부 확인
    String checkDate2 = request.getParameter("checkDate2");
    if(checkDate2 == null) {
        checkDate2 = "";
    }
    String ck2 = request.getParameter("ck2");
    if(ck2 == null) {
        ck2 = "";
    }
    
    String msg = "";
    if(ck2.equals("T")) {
        msg = "입력이 가능한 날짜입니다";
    } else if(ck2.equals("F")){
        msg = "점심투표가 이미 존재하는 날짜입니다";
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
              background-image: url(/diary/img/vote.png);
              background-repeat: no-repeat;
              

        }
        .gr {
              font-family:"Grandiflora One", cursive;
              font-weight: bold;
        }
     </style>
</head>
<body class="gr bg">

    <h1>점심 투표</h1>
    
    <form method="post" action="/diary/checkLunchDateAction.jsp">    
        <div>
            날짜확인 : <input type="date" name="checkDate2" value="<%=checkDate2%>">
            <span><%=msg%></span>
            <button type="submit">날짜가능확인</button>
        </div>

    </form>
    
    <br>
    
    
    <form method="post" action="/diary/lunchAction.jsp">
         <div>
            날짜 : 
            <%
                if(ck2.equals("T")) {
            %>
                    <input value="<%=checkDate2%>" type="text" name="lunchDate" readonly="readonly">
            <%      
                } else {
            %>
                    <input value="" type="text" name="lunchDate" readonly="readonly">               
            <%      
                }
            %>
            
        </div>
        
        <div>
			<input type="radio" name="menu" value="양식" id="menu1">&nbsp;
				<label for="menu1" >양식</label><br>
								
			<input type="radio" name="menu" value="한식" id="menu2">&nbsp;
				<label for="menu2" >한식</label><br>
								
			<input type="radio" name="menu" value="중식" id="menu3">&nbsp;
				<label for="menu3" >중식</label><br>
							
			<input type="radio" name="menu" value="일식" id="menu4">&nbsp;
				<label for="menu4" >일식</label><br>
        </div>
    
  
    
    
    
        <div>
            <a href ="/diary/diary.jsp" class="btn btn-dark">돌아가기</a>
            <button type="submit" class="btn btn-dark">입력</button>
            <a href ="/diary/statsLunch.jsp" class="btn btn-dark">점심 통계</a>
        </div>   
    </form>
    
</body>
</html>