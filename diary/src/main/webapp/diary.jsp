<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import = "java.util.*" %>
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
	
		// if 문에 안 걸릴때 ...
		rs1.close();
		stmt1.close();
		
		
		
		//-------달력-------
		
		//1. 요청 분석
		//출력하고자는 달력의 년과 월값을 넘겨받음
		String tagrgetYear = request.getParameter("targetYear");
		String targetMonth = request.getParameter("targetMonth");
		
		
		Calendar target = Calendar.getInstance(); //오늘날짜를 구함
		
		if(tagrgetYear != null && targetMonth != null) { // 오류방지 코드 
			target.set(Calendar.YEAR, Integer.parseInt(tagrgetYear)); //년도 먼저 놔야한다
			target.set(Calendar.MONTH, Integer.parseInt(targetMonth));
			
		}
		//시작공백의 개수 -> 1일의 요일이 필요 ->요일에 맵핑된 숫자 -> 타겟 날짜를 1일로변경
		target.set(Calendar.DATE, 1);
		
		// 달력 타이틀로 출력할 변수
		int tYear = target.get(Calendar.YEAR);
		int tMonth = target.get(Calendar.MONTH);
		
		
		int yoNum = target.get(Calendar.DAY_OF_WEEK); // 일 :1, 월:2, .....토:7
		System.out.println(yoNum);
		//시작공백의 개수 : 일요일 공백이 없고, 월요일은1칸 , 화요일은 2칸..... yoNum - 1이 공백의 개수
		int startBlank = yoNum -1;
		int lastDate = target.getActualMaximum(Calendar.DATE); //target달의 마지막 날짜 반환
		System.out.println(lastDate + "<--lastDate");

		int countDiv = startBlank + lastDate;	
        //DB에서 tYeary와 tMonth에 해당되는 diary 목록 추출
        String sql2 = "SELECT diary_date diaryDate, day(diary_date) day, LEFT(title, 5) title FROM diary WHERE year(diary_date)=? AND month(diary_date)=?";
    	PreparedStatement stmt2 = null;
        ResultSet rs2 = null;
        stmt2 = conn.prepareStatement(sql2);
        stmt2.setInt(1, tYear);
        stmt2.setInt(2, tMonth+1);
        System.out.println(stmt2);
        
        rs2 = stmt2.executeQuery();
        
        
        conn.close(); // 자원반납을 위에서 하면 밑에 코드가 실행이안댐

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
			  background-image: url(/diary/img/login2.jpg);
			  background-repeat: no-repeat;
			  background-size : cover;

		}
		.gr {
			  font-family:"Grandiflora One", cursive;
			  font-weight: bold;
		}
		.yo {
			
			float: left;
			width: 70px; height: 20px; 
			border: 1px solid #00ff0000; 
			border-radius: 5px;
			margin-top: 20px;
            margin-bottom: 20px;
			text-align: center;
			background-color: #00ff0000;
			color: black;
			border-radius: 5px;  
		
		}
		

		
		.date {
			float: left;
			background-color: #00ff0000; 
			width: 70px; height: 20px; 
		
		}
		
		.cell {
			float: left;
			background-color: #00BFFF;
			width: 70px; height: 70px;
            border: 1px solid black;
            border-radius: 5px;
		}
		
		.sun {
			clear: both;
			color: #FF0000;
		}
		
		.textcenter {
			text-align: center;
		
		}
        #diaryDiv{
            width: 500px;
            height: 600px;
            padding: 0px;
        }
        #mainDiv{
            margin-top: 100px;
        }
	</style>
</head>
<body class="gr bg">
    <a href="/diary/diary.jsp">다어이리 모양으로 보기</a>
    <a href="/diary/diaryList.jsp">다어이리 리스트 보기</a>
	<div class="container text-center" id="mainDiv">
		<div>
			<h1 class="textcenter">&#128216 일기장 &#128216</h1>
			<div style="text-align: center">
				<button type="button" class="btn btn-primary"
                onclick="location.href='/diary/logout.jsp'">로그아웃 
                </button>
			</div>
			
			
			<!--  달력 -->
            <%
                int mon = tMonth+1;
                if(mon>0&&mon<3) {
                    
                
            
            %>
                <h1 class="textcenter"> &#9924 <%=tYear%>년 <%=tMonth+1%>월  &#9924</h1>
            
            <%
                }else if (mon>2 && mon<6) {
            
            
            %>
                <h1 class="textcenter"> &#127804 <%=tYear%>년 <%=tMonth+1%>월  &#127804</h1>
            <%
                }else if (mon>5 && mon<10) {
                
            %>
                <h1 class="textcenter"> &#9925 <%=tYear%>년 <%=tMonth+1%>월  &#9925</h1>
            <%
            
                }else if (mon>9 && mon<12) {
            %>
                <h1 class="textcenter"> &#127805 <%=tYear%>년 <%=tMonth+1%>월  &#127805</h1>
            <%
            
                }else {
            %>
                <h1 class="textcenter"> &#9924 <%=tYear%>년 <%=tMonth+1%>월  &#9924</h1>
            <%
            
                }
            %>
			
			<div style="text-align: center">
				<button type="button" class="btn btn-primary"
                        onclick="location.href='./diary.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth-1%>'">이번달
                </button>
				<button type="button" class="btn btn-primary"
                        onclick="location.href='./diary.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth+1%>'">다음달
                </button>
                <button type="button" class="btn btn-primary"
                        onclick="location.href='/diary/addDiaryForm.jsp'">일기쓰기
                </button>
			</div>     
		</div>	
    </div>
            <div class="container" id="diaryDiv">
                    <div class="yo">일</div>
                    <div class="yo">월</div>
                    <div class="yo">화</div>
                    <div class="yo">수</div>
                    <div class="yo">목</div>
                    <div class="yo">금</div>
                    <div class="yo">토</div>
                    
                    <!-- DATE값이 들어갈 DIV -->
                    <%
                        for(int i=1; i<=countDiv; i=i+1) {
                            
                            if(i%7 == 1) {
                    %>
                            <div class="cell sun date back">
                                
                    <%          
                            } else {
                    %>
                                <div class="cell date back">
                    <%              
                            }
                                    if(i-startBlank > 0) {
                                %>
                                        <%=i-startBlank%>
                                <%  
                                        // 현재날짜(i-startBlank)의 일기가 rs2 목록에 있는지 비교
                                        while(rs2.next()) {
                                            //날짜에 일기가 존재한다
                                            if(rs2.getInt("day")== (i-startBlank))  {
                                %>
                                                <div>
                                                    
                                                    <a href='/diary/diaryOne.jsp?diaryDate=<%=rs2.getString("diaryDate")%>'>
                                                        <%=rs2.getString("title")%>...
                                                    </a>
                                                </div>
                                <% 
                                                break;
                                            }
                                        }
                                        rs2.beforeFirst(); //ResultSet의 커스 위치를 처음으로 
                                    } else {
                                %>
                                        &nbsp;
                                <%      
                                    }
                                %>
                                </div>
                    <%      
                        }
                    %>
                            </div>
            </div>
</body>
</html>