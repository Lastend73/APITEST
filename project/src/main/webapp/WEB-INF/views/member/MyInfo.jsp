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
                <h1>views/member/Myinfo.jsp</h1>
            </div>
            <%@ include file="/WEB-INF/views/include/Menu.jsp" %>

                <div class="contents">
                    <h2 style="text-align: center;">회원정보 조회 페이지</h2>
                    <!-- 아이디, 비밀번호, 이름, 생년월일, 이메일 -->
                    <div class="formWrap">
                        <form action="${pageContext.request.contextPath}/memberModifyForm" method="post">
                            <div class="formRow">
                                <input type="text" name="mid" value="${myInfo.mid}" readonly>
                            </div>
                            <div class="formRow">
                                <input type="text" name="mpw" value="${myInfo.mpw}" placeholder="비밀번호" readonly>
                            </div>

                            <div class="formRow">
                                <input type="text" name="mname" value="${myInfo.mname}" placeholder="이름" readonly>
                            </div>

                            <div class="formRow">
                                <input type="date" name="mbirth" value="${myInfo.mbirth}" placeholder="연. 월. 일"
                                    readonly>
                            </div>

                            <div class="formRow">
                                <input type="text" name="memail" value="${myInfo.memail}" placeholder="이메일아이디" readonly>
                            </div>
                            <div class="formRow" style="border: none;">
                                <button class="submitBtn" type="button" onclick="pwCheck('${myInfo.mpw}')" style="margin: auto;">수정하기</button>
                            </div>

                            <hr>
                            작성한 글 : ${boardnum}개
                            <hr>
                            작성한 댓글 : ${replynum}개
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
        function pwCheck(mpw) {
            let inputpw = prompt("비밀번호 입력");
            if(mpw == inputpw){
                location.href="memberModifyForm"
            }else {
                alert("비밀번호를 다시 확인 해주세요!");
            }
        }


    </script>

    <script type="text/javascript">
        let msg = '${msg}';
        if (msg.length > 0) {
            alert(msg);
        }
    </script>

    </html>