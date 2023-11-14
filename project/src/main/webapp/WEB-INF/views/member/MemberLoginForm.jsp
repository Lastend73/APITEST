<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>MebmerJoinForm</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Main.css">
        
            
        <style type="text/css">
            div.formWrap {
                padding-left: 10px;
                width: 500px;
                margin: auto;
            }

            #checkMsg {
                margin: 0px;
                font-size: 10px;

            }

            .fail {
                color: red;
            }

            .success {
                color: green;
            }

            div.formWrap {
                border: 1px solid black;
                border-radius: 5px;
                padding: 10px;
            }

            div.formRow,
            div.formEmail {
                border-radius: 5px;
                padding: 10px;
                margin-bottom: 3px;
                margin-top: 3px;
                display: flex;
            }

            div.formRow {
                border: 1px solid black;
            }

            div.formEmail {
                border: none;
                padding-left: 0px;
                padding-right: 0px;
            }

            div.formRow>input {
                width: 100%;
                outline: none;
                border: none;
            }

            div.formEmail>input {
                outline: none;
                border: 1px solid black;
                border-radius: 5px;
                width: 100%;
            }


            #checkbtn {
                width: 95px;
                border: 1px solid black;
                border-radius: 5px;
            }

            #submitbtn {
                width: 100%;
                border-radius: 12px;

            }

            #hello {
                border-radius: 10px;
            }
            #sub{
                
                padding: 0px; 
                margin: auto;
                width: 50%;
                
            }
        </style>

    </head>

    <body>
        <div class="mainWrap">

            <div class="header">
                <h1>views/member/MemberLoginForm.jsp</h1>
            </div>
            
            <%@ include file="/WEB-INF/views/include/Menu.jsp" %>

                <div class="contents">
                 <button onclick="toastrOn()">toastr!! </button>
                    <h2 style="text-align: center;">회원가입 페이지</h2>
                    <!-- 아이디, 비밀번호, 이름, 생년월일, 이메일 -->
                    <div class="formWrap">
                        <form action="${pageContext.request.contextPath}/memberLogin" method="post">
                            <div class="formRow">
                                <input type="text" id="inputId" name="mid" placeholder="아이디">
                            </div>
                            <p id="checkMsg"></p>
                            <div class="formRow">
                                <input type="text" name="mpw" placeholder="비밀번호">
                            </div>
                            <div class="formRow" id="sub">
                                <input type="submit" id="submitbtn" value="로그인" style="background-color: bisque;">
                            </div>
                        </form>
                    </div>

                </div>
        </div>
    </body>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/jss/main.js"></script>
    <script type="text/javascript">
        let msg = '${msg}';
        if(msg.length >0){
            alert(msg);
        }
    </script>




    </html>