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

            div.formRow>input {
                width: 100%;
                outline: none;
                border: none;
            }

            #submitbtn {
                width: 100%;
                border-radius: 12px;

            }

            #hello {
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
        </style>

    </head>

    <body>
        <div class="mainWrap">

            <div class="header">
                <h1>views/board/BoardWriteForm.jsp</h1>
            </div>
            <%@ include file="/WEB-INF/views/include/Menu.jsp" %>

                <div class="contents">
                    <h2 style="text-align: center;">글쓰기</h2>
                    <!-- 아이디, 비밀번호, 이름, 생년월일, 이메일 -->
                    <div class="formWrap">
                        <form action="${pageContext.request.contextPath}/boardWrite" method="post" enctype="multipart/form-data">
                            <div class="formRow">
                                <input type="text" id="inputId" name="btitle" placeholder="글제목" >
                            </div>
                            <div class="formRow">
                                <textarea name="bcontents" id="hello" placeholder="글내용"></textarea>
                            </div>
                            <div class="formRow">
                                <input type="file" name="bfile">
                            </div>
                            <div class="formRow" id="sub">
                                <input type="submit" id="submitbtn" value="글등록" style="background-color: bisque;">
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
        if (msg.length > 0) {
            alert(msg);
        }
    </script>




    </html>