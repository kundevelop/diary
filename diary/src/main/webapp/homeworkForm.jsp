<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
    <h1>확인문제</h1>
    <form method="post" action="/diary/homeworkAction.jsp">
        <div>1. 자바 프로그램 개발 과정을 순서대로 적어보세요 ()=>()=>()=>()
            <table>
                <tr></tr>
                <tr>
                    <td><label>1 javac 명령어로 컴파일한다.</label></td>
                    <td><input type="text" name=ex1></td>
                </tr>
                <tr>
                    <td><label>2 소스 파일(~.java)을 작성한다.</label></td>
                    <td><input type="text" name=ex2></td>
                </tr>
                <tr>
                    <td><label>3 java 명령어로 실행한다.</label></td>
                    <td><input type="text" name=ex3></td>
                </tr>
                <tr>
                    <td><label>4 실행결과를 확인한다.</label></td>
                    <td><input type="text" name=ex4></td>
                </tr>
            </table>
        </div>
        <br>
        
        <div>2. 자바 소스에 대한 설명 중 맞는 것에 O표, 틀린 곳에 X표 하세요.
            <table>
                <tr></tr>
                <tr>
                    <td><label>1 컴파일하면'클래스이름.class'라는 바이트 코드 파일이 생성된다.</label></td>
                    <td><input type="text" name=ex21></td>
                </tr>
                <tr>
                    <td><label>2 main()메소드는 반드시 클래스 블록 내부에서 작성해야 한다.</label></td>
                    <td><input type="text" name=ex22></td>
                </tr>
                <tr>
                    <td><label>3 main()메소드를 작성할 때 중괄호 블록을 만들지 않아도 된다.</label></td>
                    <td><input type="text" name=ex23></td>
                </tr>
                <tr>
                    <td><label>4 컴파일 후 실행을 하려면 반드시 main()메소드가 있어야 한다.</label></td>
                    <td><input type="text" name=ex24></td>
                </tr>
            </table>
        </div>
        <br>
        
        <div>3. 주석에 대한 설명 중 맞는 것에 O표, 틀린 곳에 X표 하세요.
            <table>
                <tr></tr>
                <tr>
                    <td><label>1 //뒤의 라인 내용은 모두 주석이 된다.</label></td>
                    <td><input type="text" name=ex31></td>
                </tr>
                <tr>
                    <td><label>2 /*부터 시작해서*/까지 모든 내용이 주석이 된다.</label></td>
                    <td><input type="text" name=ex32></td>
                </tr>
                <tr>
                    <td><label>3 주석이 많으면 바이트 코드 파일의 크기가 커지므로 꼭 필요할 경우에만 작성한다.</label></td>
                    <td><input type="text" name=ex33></td>
                </tr>
                <tr>
                    <td><label>4 문자열 안에는 주석을 만들 수 없다.</label></td>
                    <td><input type="text" name=ex34></td>
                </tr>
            </table>
        </div>
        <br>
        
        <div>4. 이클립스의 자바 프로젝트에 대해 설명한 것 중 맞는 것에 O표, 틀린 곳에 X표 하세요.
            <table>
                <tr></tr>
                <tr>
                    <td><label>1 기본적으로 소스 파일과 바이트 코드 파일이 저장되는 폴더가 다르다.</label></td>
                    <td><input type="text" name=ex41 ></td>
                </tr>
                <tr>
                    <td><label>2 자바 소스 파일을 작성하는 폴더는 src이다.</label></td>
                    <td><input type="text" name=ex42></td>
                </tr>
                <tr>
                    <td><label>3 선언되는 클래스 이름은 소스 파일 이름과 달라도 상관없다.</label></td>
                    <td><input type="text" name=ex43></td>
                </tr>
                <tr>
                    <td><label>4 올바르게 작성된 소스 파일을 저장하면 자동으로 컴파일되고, 바이트 코드 파일이 생성된다.</label></td>
                    <td><input type="text" name=ex44></td>
                </tr>
            </table>
        </div>
        <br>
        
        <div>5. 이클립스에서 바이트 코드 파일을 실행하는 방법을 모두 선택해보세요.
            <table>
                <tr></tr>
                <tr>
                    <td><label>1 Package Explorer 뷰에서 소스 파일을 더블클릭한다.</label></td>
                    
                </tr>
                <tr>
                    <td><label>2 Package Explorer 뷰에서 바이트 코드 파일을 선택하고, 툴 바에서 Run 아이콘을 클릭한다.</label></td>
                    
                </tr>
                <tr>
                    <td><label>3 Package Explorer 뷰에서 소스 파일을 선택하고, 툴 바에서 Run 아이콘을 클릭한다.</label></td>
                    
                </tr>
                <tr>
                    <td><label>4 Package Explorer 뷰에서 소스 파일을 선택하고, 마우스 오른쪽 버튼을 클릭한 후 [Run As]-[Java Application]을 선택한다.</label></td>
                    
                </tr>
                <tr>
                    <td><input type="text" name=ex5  ></td>
                </tr>
            </table>
        </div>
        <br>
        
        <button type="submit">제출하기</button>
    </form>
    
</body>
</html>