<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%  
    //정답
    int a1= 2;
    int a2= 1;
    int a3= 3;
    int a4= 4;
    
    String a21 = "o";
    String a22 = "o";
    String a23 = "x";
    String a24 = "o";
    
    String a31 = "o";
    String a32 = "o";
    String a33 = "x";
    String a34 = "o";
    
    String a41 = "o";
    String a42 = "o";
    String a43 = "x";
    String a44 = "o";
    
    String b = "34";
    

    
   
    //1번
    int ex1 = Integer.parseInt(request.getParameter("ex1"));
    int ex2 = Integer.parseInt(request.getParameter("ex2"));
    int ex3 = Integer.parseInt(request.getParameter("ex3"));
    int ex4 = Integer.parseInt(request.getParameter("ex4"));
    
    //2번
    String ex21 = request.getParameter("ex21");
    String ex22 = request.getParameter("ex22");
    String ex23 = request.getParameter("ex23");
    String ex24 = request.getParameter("ex24");   
    
    //3번
    String ex31 = request.getParameter("ex31");
    String ex32 = request.getParameter("ex32");
    String ex33 = request.getParameter("ex33");
    String ex34 = request.getParameter("ex34");    
    
    //4번
    String ex41 = request.getParameter("ex41");
    String ex42 = request.getParameter("ex42");
    String ex43 = request.getParameter("ex43");
    String ex44 = request.getParameter("ex44");  
    
    //5번
    String ex5 = request.getParameter("ex5");

    //디버깅
    System.out.println(ex1 +"<==ex1");
    System.out.println(ex2 +"<==ex2");
    System.out.println(ex3 +"<==ex3");
    System.out.println(ex4 +"<==ex4");
    System.out.println(ex21 +"<==ex21");
    System.out.println(ex22 +"<==ex22");
    System.out.println(ex23 +"<==ex23");
    System.out.println(ex24 +"<==ex24");
    System.out.println(ex31 +"<==ex31");
    System.out.println(ex32 +"<==ex32");
    System.out.println(ex33 +"<==ex33");
    System.out.println(ex34 +"<==ex34");
    System.out.println(ex41 +"<==ex41");
    System.out.println(ex42 +"<==ex42");
    System.out.println(ex43 +"<==ex43");
    System.out.println(ex44 +"<==ex44");
    System.out.println(ex5 +"<==ex5");

    
    
    int totalScore = 0;

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
    <h1>채점표</h1>
    
    
    <%
        if((ex1 == a1) && (ex2 == a2) && (ex3 == a3) && (ex4 == a4) ) {
        	totalScore+=5;
    %>
        <div>1번 정답입니다.</div>
    <%
        } else {
    
    %>
        <div>1번 오답입니다.</div>
    <%
    
        }
    %>


    <%
        if(ex21.equals(a21)) {
        	totalScore+=5;
    %>
    
            <div>2-1번 정답입니다.</div>
    <%
        } else {
        
    %>
            <div>2-1번 오답입니다.</div>
    <%
        }
    %>
    
    
    <%
        if(ex22.equals(a22)) {
        	totalScore+=5;
    %>
    
            <div>2-2번 정답입니다.</div>
    <%
        } else {
        
    %>
            <div>2-2번 오답입니다.</div>
    <%
        }
    %>
    
    
    <%
        if(ex23.equals(a23)) {
        	totalScore+=5;
    %>
    
            <div>2-3번 정답입니다.</div>
    <%
        } else {
        
    %>
            <div>2-3번 오답입니다.</div>
    <%
        }
    %>
    
    
    <%
        if(ex24.equals(a24)) {
        	totalScore+=5;
    %>
    
            <div>2-4번 정답입니다.</div>
    <%
        } else {
        
    %>
            <div>2-4번 오답입니다.</div>
            
    <%
        }
    %>
    
    <%
        if(ex31.equals(a31)) {
        	totalScore+=5;
    %>
    
            <div>3-1번 정답입니다.</div>
    <%
        } else {
        
    %>
            <div>3-1번 오답입니다.</div>
    <%
        }
    %>
    
    
    <%
        if(ex32.equals(a32)) {
        	totalScore+=5;
    %>
    
            <div>3-2번 정답입니다.</div>
    <%
        } else {
        
    %>
            <div>3-2번 오답입니다.</div>
    <%
        }
    %>
    
    
    <%
        if(ex33.equals(a33)) {
        	totalScore+=5;
    %>
    
            <div>3-3번 정답입니다.</div>
    <%
        } else {
        
    %>
            <div>3-3번 오답입니다.</div>
    <%
        }
    %>
    
    
    <%
        if(ex34.equals(a34)) {
        	totalScore+=5;
    %>
    
            <div>3-4번 정답입니다.</div>
    <%
        } else {
        
    %>
            <div>3-4번 오답입니다.</div>
            
    <%
        }
    %>
    
    
    <%
        if(ex41.equals(a41)) {
        	totalScore+=5;
    %>
    
            <div>4-1번 정답입니다.</div>
    <%
        } else {
        
    %>
            <div>4-1번 오답입니다.</div>
    <%
        }
    %>
    
    
    <%
        if(ex42.equals(a42)) {
        	totalScore+=5;
    %>
    
            <div>4-2번 정답입니다.</div>
    <%
        } else {
        
    %>
            <div>4-2번 오답입니다.</div>
    <%
        }
    %>
    
    
    <%
        if(ex43.equals(a43)) {
        	totalScore+=5;
    %>
    
            <div>4-3번 정답입니다.</div>
    <%
        } else {
        
    %>
            <div>4-3번 오답입니다.</div>
    <%
        }
    %>
    
    
    <%
        if(ex44.equals(a44)) {
        	totalScore+=5;
    %>
    
            <div>4-4번 정답입니다.</div>
    <%
        } else {
        
    %>
            <div>4-4번 오답입니다.</div>
            
    <%
        }
    %>
    
    
    <%
        if(ex5.equals(b)) {
        	totalScore+=5;
    %>
    
            <div>5번 정답입니다.</div>
    <%
        } else {
        
    %>
            <div>5번 오답입니다.</div>
            
    <%
        }
        
    %>
    
    <div> 총점: <%=totalScore%></div>




</body>
</html>