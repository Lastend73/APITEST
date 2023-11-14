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
    </head>

    <body>
        <div class="mainWrap">

            <div class="header">
                <h1>메인페이지 - views/MainPAage.jsp</h1>
            </div>

            <%@ include file="/WEB-INF/views/include/Menu.jsp" %>

                <div class="contents">
                    <h2>로그인 된 아이디 : ${loginMemberId}</h2>
                    <h2>컨텐츠 영역</h2>


                    <button onclick="sendTest()">클릭!!</button>
                </div>
        </div>

        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/jss/main.js">

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

        <script>
            let noticeSock = connectionNotice("${noticeMsg}");

            function sendTest() {
                let noticeObj = {
                    "noticeType": "board"
                };
                noticeSock.send(JSON.stringify(noticeObj));
            }
        </script>

    </body>

    </html>