<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.net.*"%>
<%
	
	//session.removeAttribute("loginMember"); 다른 정보가 들어갈수있음
    
    session.invalidate(); //세션 공간 초기화(포멧)
    
	response.sendRedirect("/diary/loginForm.jsp");
%>
