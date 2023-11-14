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

            div.formWrap {
                border: 1px solid black;
                border-radius: 5px;
                padding: 10px;
            }

            div.formRow {
                border-radius: 5px;
                padding: 10px;
                margin-bottom: 3px;
                margin-top: 3px;
                display: flex;
            }

            div.formRow {
                border: 1px solid black;
            }

            div.formRow>input {
                width: 100%;
                outline: none;
                border: none;
            }

            #checkbtn {
                width: 95px;
                border: 1px solid black;
                border-radius: 5px;
            }

            #submitbtn {
                width: 50%;
                border-radius: 12px;

            }

            #hello {
                border-radius: 10px;
            }

            input[type=submit] {
                margin: auto;
                background-color: cadetblue;
            }
        </style>

    </head>

    <body>
        <div class="mainWrap">

            <div class="header">
                <h1>views/member/memberModifyForm.jsp</h1>
            </div>
            <%@ include file="/WEB-INF/views/include/Menu.jsp" %>

                <div class="contents">
                    <h2 style="text-align: center;">회원정보 수정 페이지</h2>
                    <!-- 아이디, 비밀번호, 이름, 생년월일, 이메일 -->
                    <div class="formWrap">
                        <form action="${pageContext.request.contextPath}/memberModify" method="post">
                            <div class="formRow">
                               <input type="text" name="mid" value="${myInfo.mid}" readonly>
                            </div>
                            <div class="formRow">
                                <input type="text" name="mpw" value="${myInfo.mpw}" placeholder="비밀번호">
                            </div>

                            <div class="formRow">
                                <input type="text" name="mname" value="${myInfo.mname}" placeholder="이름">
                            </div>

                            <div class="formRow">
                                <input type="date" name="mbirth" value="${myInfo.mbirth}" placeholder="연. 월. 일">
                            </div>

                            <div class="formRow">
                                <input type="text" name="memail" value="${myInfo.memail}" placeholder="이메일아이디">
                            </div>
                            <div class="formRow" style="border: none;">
                                <input type="submit" id="submitbtn" value="수정 완료" style="margin: auto;">
                            </div>

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