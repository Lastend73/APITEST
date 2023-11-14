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
        </style>

    </head>

    <body>
        <div class="mainWrap">

            <div class="header">
                <h1>views/member/MebmerJoinForm.jsp</h1>
            </div>
            <%@ include file="/WEB-INF/views/include/Menu.jsp" %>

                <div class="contents">
                    <h2 style="text-align: center;">회원가입 페이지</h2>
                    <!-- 아이디, 비밀번호, 이름, 생년월일, 이메일 -->
                    <div class="formWrap">
                        <form action="${pageContext.request.contextPath}/memberJoin" method="post">
                            <div class="formRow">
                                <input type="text" id="inputId" name="mid" placeholder="아이디">
                                <button type="button" onclick="idCheck()" id="checkbtn">중복확인</button>
                            </div>
                            <p id="checkMsg"></p>
                            <div class="formRow">
                                <input type="text" name="mpw" placeholder="비밀번호">
                            </div>

                            <div class="formRow">
                                <input type="text" name="mname" placeholder="이름">
                            </div>

                            <div class="formRow">
                                <input type="date" name="mbirth" placeholder="연. 월. 일">
                            </div>

                            <div class="formEmail">
                                <input type="text" name="memailId" placeholder="이메일아이디">
                                <p style="margin: 7px;">@</p>
                                <input type="text" id="edomain" name="memailDomain" placeholder="이메일도메인">
                                <select id="hello" onchange="selectDomain(this)" style="margin-left: 5px;">
                                    <option value="">직접입력</option>
                                    <option value="naver.com">네이버</option>
                                    <option value="google.com">구글</option>
                                </select>
                            </div>
                            <input type="submit" id="submitbtn" value="회원가입">
                        </form>
                    </div>

                </div>
        </div>
    </body>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/jss/main.js"></script>
    <script type="text/javascript">

        // let hi = document.querySelector("#hello")

        // hi.addEventListener('change', function(){
        //     document.querySelector("#edomain").value = hi.value;
        // });

        function selectDomain(obj) {
            document.querySelector('#edomain').value = obj.value;
        }

    </script>
    <!-- 아이디 중복체크 -->

    <script type="text/javascript">
        function idCheck() {
            // 중복확인 할 아이디 VALUE 확인
            let idEl = document.querySelector('#inputId');
            console.log(idEl.value);

            //ajax - 아이디 중복 확인 요청 (memberIDcheck)
            $.ajax({
                type: 'get', /* 전송 방식*/
                url: "memberIdCheck", // 전송 URL
                data: { "inputId": idEl.value }, // 전송 파라메터
                success: function (re) { // 전송에 성공 했을 경우
                    /* re : 응답받은 데이터*/
                    console.log("확인결과 : " + re);
                    if (re == 'Y') {
                        document.querySelector("#checkMsg").innerText = "사용가능한 아이디 입니다"
                        document.querySelector("#checkMsg").classList.add("success");
                    } else {
                        document.querySelector("#checkMsg").innerText = "중복된 아이디 입니다"
                        $("p").addClass("fail");
                    }
                }
            })
        }
    </script>

    <script type="text/javascript">
        let msg = '${msg}';
        if (msg.length > 0) {
            alert(msg);
        }
    </script>

    </html>