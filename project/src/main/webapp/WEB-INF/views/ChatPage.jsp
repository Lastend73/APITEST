<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>메인페이지</title>
        <style type="text/css">
        </style>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Main.css">

        <!-- toastr css  ( <head>태그 안쪽에 )-->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.css"
            integrity="sha512-oe8OpYjBaDWPt2VmSFR+qYOdnTjeV9QPLJUeqZyprDEQvQLJ9C5PCFclxwNuvb/GQgQngdCXzKSFltuHD3eCxA=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />

        <style>
            #chatArea {
                border: 3px solid black;
                width: 500px;
                padding: 10px;
                border-radius: 10px;
                background-color: #9bbbd4;
                height: 500px;
                overflow: scroll;
                box-sizing: border-box;
            }

            #chatArea::-webkit-scrollbar {
                display: none;
            }

            .receiveMsg,
            .receiveid {
                margin-bottom: 3px;
            }

            .msgComment {
                display: inline-block;
                padding: 7px;
                border-radius: 7px;
                max-width: 220px;
            }

            .receiveMsg>.msgComment {
                background-color: #ffffff;
            }

            .SendMsg>.msgComment {
                background-color: #fef01b;
            }

            .connMsg {
                min-width: 300px;
                max-width: 300px;
                margin: 5px auto;
                margin-left: auto;
                ;
                margin-right: auto;
                text-align: center;
                background-color: #556677;
                color: white;
                border-radius: 10px;
                padding: 5px;
            }


            .SendMsg {
                margin-bottom: 3px;
                text-align: right;
            }

            .connMsg {
                font-size: 13px;
                font-weight: bold;
            }

            .receiveMsg,
            .SendMsg {
                margin-bottom: 5px;
            }

            #inputMsg>input {
                width: 100%;
                padding: 5px;
            }

            #inputMsg>button {
                width: 100px;
                padding: 5px;
            }

            #inputMsg {
                display: flex;
                box-sizing: border-box;
                width: 500px;
                padding: 10px;
                border-radius: 10px;
                border: 3px solid black;
            }

            #chatContents{
                display: flex;
                width: 900px;
                margin-bottom: 10px;

            }
            #leftContent{
                margin: 5px;
            }
            #rigthContent{
                margin: 5px;
                width: 230px;
            }

            #connMembersArea{
                border-radius: 10px;
                border: 3px solid black;
                height: 550px;
                overflow: scroll;
            }

            .connMember{
                border: 2px solid black;
                border-radius: 7px;
                padding: 5px;
                margin: 3px;
            }
            
        </style>
    </head>

    <body>
        <div class="mainWrap">

            <div class="header">
                <h1>채팅페이지 - views/ChatPage.jsp</h1>
            </div>

            <%@ include file="/WEB-INF/views/include/Menu.jsp" %>

                <div class="contents">
                    <h2>로그인 된 아이디 : ${loginMemberId}</h2>
<!-- 
                    <h2>1. pom.xml > spring-webSocket, jackson databind 추가</h2>
                    <h2>2. com.spring_memberBoard.sockutill. 패키지에 ChatHandler 클래스 생성</h2>
                    <h2>3. servlet-context.xml websocket 설정 추가</h2>
                    <h2>4. ChatPage.jsp sockjs에 기능 추가</h2>
                    <h2>5. ChatPage.jsp sockjs에 채팅 기능 구현 </h2> -->


                    <div id="chatContents">
                        <div id="leftContent">
                            <div id="chatArea">
                                <div class="receiveMsg">
                                    <!-- <div class="msgId">아이디</div>
                                    <div class="msgComment">받은메세지</div> -->
                                </div>
                                <div class="SendMsg">
                                    <!-- 보낸 메세지 -->
                                    <!-- <div class="msgComment">보낸메세지</div> -->
                                </div>

                                <!-- <div class="connMsg"> 접속/접속헤제</div> -->
                            </div>

                            <div id="inputMsg">
                                <input type="text" id="sendMsg">
                                <button onclick="msgSend()">전송</button>
                            </div>

                        </div>

                        <div id="rigthContent">
                            <div id="connMembersArea">
                                <!-- <div class="connMember">접속 아이디1</div> -->
                            </div>
                        </div>
                        
                    </div>
                </div>
        </div>
        <!-- sockjs 스키립트 -->
        <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/jss/main.js">
            /*<div class='header'>인 요소 선택*/
        </script>

        <!--socketJs  -->
        <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/jss/NoticeJS.js"></script>

        <!--jquery  ( <body> 태그 하단에 )--> 
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

        <!-- toastr  (jquery 보다 아래에 있어야함)-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.min.js"
            integrity="sha512-lbwH47l/tPXJYG9AcFNoJaTMhGvYWhVM9YI43CT+uteTRRaiLCui8snIgyAN8XWgNjNhCqlAUdzZptso6OCoFQ=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>

        <script type="text/javascript">
            let noticeSock = connectionNotice("${noticeMsg}");

            let msg = '${msg}';
            if (msg.length > 0) {
                alert(msg);
            }
        </script>

        <script>
            var sock = new SockJS('chatSocket');

            //열때
            sock.onopen = function () {
                console.log('open');
            };

            //메세지 받을때
            sock.onmessage = function (e) {
                console.log('message', e.data);

                let msgObj = JSON.parse(e.data);
                

                let mtype = msgObj.msgtype;
                switch (mtype) {
                    case "m":
                        printMessage(msgObj); //메세지 출력 기능
                        break;
                    case "c": ;
                    case "d":
                        printConnect(msgObj); //접속 정보 출력 기능
                        break;
                }
            };

            let divArea = document.querySelector("#chatArea");

            function printMessage(msg) {
                console.log("메세지 인쇄");

                let receiveArea = document.createElement("div");
                receiveArea.classList.add('receiveMsg');

                let recDivId = document.createElement('div');
                recDivId.classList.add("msgId");
                recDivId.innerText = msg.id;

                let recDivMsg = document.createElement('div');
                recDivMsg.classList.add("msgComment");
                recDivMsg.innerText = msg.message;

                receiveArea.appendChild(recDivId);
                receiveArea.appendChild(recDivMsg);

                divArea.appendChild(receiveArea);
                divArea.scrollTop = divArea.scrollHeight;
                console.log("divArea.scrollHeight : " + divArea.scrollHeight);
            }

            //나갈떄
            sock.onclose = function () {
                console.log('close');
            };


            // <div class="SendMsg">
            //     <div class="msgComment">보낸메세지</div>
            // </div>
            function msgSend() {
                let sendMsg = document.querySelector("#sendMsg");
                sock.send(sendMsg.value);

                let SendMsgdiv = document.createElement('div');
                SendMsgdiv.classList.add('SendMsg');


                let SendMsgCom = document.createElement('div');
                SendMsgCom.innerText = sendMsg.value;
                SendMsgCom.classList.add('msgComment');

                SendMsgdiv.appendChild(SendMsgCom);

                divArea.appendChild(SendMsgdiv);
                divArea.scrollTop = divArea.scrollHeight;
                // console.log("divArea.scrollHeight : " + divArea.scrollHeight);
                sendMsg.value = "";

            }

            function printConnect(msgObj) {

                console.log("접속정보 출력 기능");
                //접속 정보 >> 채팅창에 출력
                let connMsgDiv = document.createElement('div');
                connMsgDiv.classList.add('connMsg');
                connMsgDiv.innerText = msgObj.msgid + "이/가" + msgObj.msgcomm;

                connMsgDiv.setAttribute("tabindex", "0");

                divArea.appendChild(connMsgDiv);
                divArea.scrollTop = divArea.scrollHeight;
                // scrollHeight는 스크롤의 길이
                // console.log("divArea.scrollHeight : " + divArea.scrollHeight);

                // 접속 정보 >> 접속자 목록에서 출력 / 삭제
                
                let connMembersAreaDiv = document.querySelector("#connMembersArea")
                
                if(msgObj.msgtype== 'c') {
                    // msgtpye == 'c' >> 접속자 목록에 추가
                    let connMemberDiv = document.createElement('div');
                    connMemberDiv.classList.add('connMember');

                    connMemberDiv.innerText = msgObj.msgid;

                    connMemberDiv.setAttribute('id', msgObj.msgid);

                    connMembersAreaDiv.appendChild(connMemberDiv);
                    
                }else{
                    // msgtpye == 'd' >> 접속자 목록에서 삭 제
                    document.querySelector("#"+msgObj.msgid).remove();
                }

            }

        </script>

        <script>

            // 엔터 키로 전송하기 Keycode == 13 은 엔터키를 의미
            let msgInputTag = document.querySelector("#sendMsg");
            msgInputTag.addEventListener('keyup', function (e) {
                if (e.keyCode == 13) {
                    msgSend();
                }
            })
        </script>


    </body>

    </html>