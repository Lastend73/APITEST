<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>MebmerJoinForm</title>

        <!-- toastr css  ( <head>태그 안쪽에 )-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.css"
            integrity="sha512-oe8OpYjBaDWPt2VmSFR+qYOdnTjeV9QPLJUeqZyprDEQvQLJ9C5PCFclxwNuvb/GQgQngdCXzKSFltuHD3eCxA=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />

        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Main.css">
        <style type="text/css">
            div.formWrap {
                padding-left: 10px;
                width: 500px;
                margin: auto;
                border: 1px solid black;
                border-radius: 5px;
                padding: 10px;
            }

            div.formRow {
                border-radius: 5px;
                padding: 5px;
                margin-bottom: 3px;
                margin-top: 3px;
                display: flex;
                border: 1px solid black;
            }

            #inputId {
                text-align: center;
            }

            div.formRow>input,
            .three>input {
                width: 100%;
                outline: none;
                border: none;
                border-radius: 5px;
            }

            .formRow>input,
            .formRow>textarea,
            .three>input {
                background-color: white;
            }

            #submitbtn {
                width: 100%;
                border-radius: 12px;
            }

            textarea {
                width: 100%;
                height: 200px;
                border: none;
                outline: none;
                resize: none;
            }

            #sub {
                padding: 0px;
                margin: auto;
                width: 50%;
                margin-top: 10px;
            }

            img {
                width: 100%;
            }

            .three {
                border: 1px solid black;
                outline: none;
                border-radius: 5px;
                margin-right: 2px;
                display: flex;
            }

            .replyArea {
                border: 3px solid black;
                border-radius: 10px;
                width: 500px;
                margin: 0 auto;
                padding: 15px;
            }

            .replyWrite textarea {
                border: 1px solid black;
                border-radius: 7px;
                width: 96%;
                min-height: 70px;
                font-family: auto;
                resize: none;
                padding: 8px;
            }

            .replyWrite button {
                width: 100%;
                margin-top: 5px;
                cursor: pointer;
                padding: 5px;
                border-radius: 7px;
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
                    <h2 style="text-align: center;">글보기</h2>
                    <!-- 아이디, 비밀번호, 이름, 생년월일, 이메일 -->
                    <div class="formWrap">
                        <form action="${pageContext.request.contextPath}/boardWrite" method="post"
                            enctype="multipart/form-data">
                            <div class="formRow">
                                <input type="text" id="inputId" name="btitle" placeholder="글제목" value="${view.btitle}"
                                    disabled>
                            </div>
                            <div class="formRow" style="border: none; padding: 0px;">
                                <div class="three">
                                    <input type="text" name="bwriter" placeholder="작성자" value="${view.bwriter}"
                                        disabled>
                                </div>
                                <div class="three">
                                    <input type="text" name="bhits" placeholder="조회수" value="${view.bhits}" disabled>
                                </div>
                                <div class="three">
                                    <input type="text" name="bdate" placeholder="작성일" value="${view.bdate}" disabled>
                                </div>
                            </div>
                            <div class="formRow">
                                <textarea name="bcontents" id="hello" placeholder="글내용"
                                    disabled>${view.bcontents}</textarea>
                            </div>
                            <div class="formRow">
                                <!-- <img src="${pageContext.request.contextPath}/resources/boardUpload/${view.bfilename}"
                                    alt=""> -->
                            </div>
                            <div class="formRow" id="sub">
                                <input type="submit" id="submitbtn" value="글목록" style="background-color: bisque;">
                            </div>
                        </form>
                    </div>
                    <%-- 댓글 관련 시작--%>
                        <hr>
                        <div class="replyArea">
                            <c:if test="${sessionScope.loginMemberId != null }">
                                <div class="replyWrite">
                                    <h3>댓글 작성 양식 - 로그인한 경우 출력</h3>
                                    <form onsubmit="return replyWrite(this)">
                                        <input type="hidden" name="rebno" value="${view.bno}">
                                        <input type="hidden" name="bwriter" value="${view.bwriter}">
                                        <textarea name="recomment" placeholder="댓글 내용 작성"></textarea>
                                        <button type="submit">댓글등록</button>
                                    </form>
                                </div>
                                <hr>
                            </c:if>

                            <div class="replyList">
                                <h3> 댓글 출력 </h3>
                            </div>
                        </div>

                        <%-- 댓글 관련 시작--%>

                </div> <%-- contents 끝--%>
        </div>

        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/jss/main.js"></script>

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

            let msg = '${msg}';
            if (msg.length > 0) {
                alert(msg);
            }
        </script>
        <!-- 댓글 등록 -->
        <script>
            function replyWrite(formObj) {
                console.log("replyWrite 호출 " + formObj.rebno.value);
                /*ajax 댓글 등록 요청 전송*/
                $.ajax({
                    type: "get",
                    url: "replyWrite",
                    data: {
                        "rebno": formObj.rebno.value,
                        "recomment": formObj.recomment.value
                    },
                    async: false,
                    success: function (result) {
                        console.log("result : " + result);
                        if (result == "1") {
                            alert("댓글이 등록되었습니다");
                            formObj.recomment.value = ""; // 댓글 내용 작성 Textarea 초기화
                            // 댓글 목록 갱신
                            getReplyList(formObj.rebno.value);

                            // document.querySelector('#focusDiv').focus();
                            // NoticeSock.send("{noticeType : "댓글알림", bno : "10", 'bwriter' : '글작성자'}"")

                            let noticeObj = {
                                            "noticeType" : "reply",
                                            "noticeMsg" :  formObj.rebno.value,
                                            "received" :  formObj.bwriter.value
                                            };

                            // 공지타입, 글번호, 작성자 >> Json
                            noticeSock.send(JSON.stringify(noticeObj));

                        } else {
                            alert("댓글 실패하였습니다.");
                        }
                    }

                });
                return false;
            }
            // 댓글 목록 조회 및 출력
            function getReplyList(rebno) {
                console.log("getReplyList() 호출");
                console.log("댓글 조회할 글번호 : " + bno);
                /*SELECT * FROM REPLYS WHERE REBNO = ${rebno} AND RESTATE = '1'
                  ORDER BY REDATE
                  >> ArrayList<Reply> >> JSON 변환 >> 페이지 응답
                */
                $.ajax({
                    type: "get",
                    Url: "replyList",
                    data: {
                        "rebno": rebno
                    },
                    dataType: "json",
                    success: function (reList) {
                        console.log("relist : " + reList);
                    }
                });
            }
        </script>

        <script>

            let noticeSock = connectionNotice("${noticeMsg}");

            let bno = "${view.bno}";
            $(document).ready(function () {
                getReplyList(bno);
            })
        </script>
    </body>




    </html>