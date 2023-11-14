<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>메인페이지</title>
        <style type="text/css">
        </style>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Main.css">
    </head>

    <body>
        <div class="mainWrap">

            <div class="header">
                <h1>BusList</h1>
            </div>

            <%@ include file="/WEB-INF/views/include/Menu.jsp" %>

                <div class="contents">
                    <h2>버스 도착정보</h2>
                    <%--  --%>
                    <table>
                        <tr>
                            <th>정류소 명</th>
                            <th>버스 번호</th>
                            <th>남은 정류장</th>
                            <th>도착 예정 시간</th>
                        </tr>
                        <c:forEach items="${busList }" var="bus">
                        <tr>
                        	<td>${bus.nodenm}</td>
                            <td>${bus.routeno}</td>
                            <td>${bus.arrprevstationcnt}</td>
                            <td>${bus.arrtime}</td>
                          </tr>
                        </c:forEach>

                    </table>
                </div>
        </div>


        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/jss/main.js">
            /*<div class = 'header'>인 요소 선택*/
        </script>
       
       <script type="text/javascript">
            let msg = '${msg}';
            if (msg.length > 0) {
                alert(msg);
            }
        </script>

    </body>

    </html>