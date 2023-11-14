<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>TagoBus</title>
        <style type="text/css">
            #mapInfo {
                display: flex;
            }

            #busSttnArea {
                box-sizing: border-box;
                border: 2px solid black;
                margin-left: 3px;
                padding: 5px;
                width: 250px;
                height: 300px;
                overflow: scroll;
                /*내용물이 초과되면 scroll로 변환*/
                font-size: 13px;
            }

            #TagoBusDiv {
                display: flex;
            }

            .busSttn {
                box-sizing: border-box;
                border: 1px solid black;
                border-radius: 10px;
                padding: 5px;
                text-align: center;
                margin-bottom: 3px;
                cursor: pointer;
            }

            .busSttn:hover,.arrInfo:hover {
                background-color: wheat;
            }

            .clickColor {
                background-color: wheat;
            }

            #busArrInfo {
                box-sizing: border-box;
                border: 2px solid black;
                border-radius: 7px;
                width: 655px;
                padding: 5px;
                margin-top: 5px;
                height: 125px;
                overflow: scroll;

            }

            .arrInfo {
                display: flex;
                border: 1px solid black;
                border-radius: 10px;
                padding: 5px;
                margin-bottom: 3px;
                cursor: pointer;
            }

            #busLocInfo {
                border: 2px solid black;
                border-radius: 7px;
                margin-left: 5px;
                width: 300px;
                padding: 7px;
                height: 415px;
                overflow: scroll;
                text-align: center;
            }

            .busNode {
                border: 1px solid black;
                border-radius: 10px;
                padding: 8px;
                margin-bottom: 5px;
            }

            .selectBusNode {
                background-color: brown;
            }

            .nowBus {
                border: 5px solid coral !important;
            }
        </style>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Main.css">
    </head>

    <body>
        <div class="mainWrap">

            <div class="header">
                <h1>TagoBus - views/TagoBus.jsp</h1>
            </div>

            <%@ include file="/WEB-INF/views/include/Menu.jsp" %>

                <div class="contents">
                    <div id="TagoBusDiv">
                        <div id="leftInfo">

                            <div id="mapInfo">
                                <!--지도 -->
                                <div id="map" style="width:400px;height:300px;"></div>

                                <!-- 정류소 목록  / 버스 정류소조회_API-->
                                <div id="busSttnArea">

                                </div>
                            </div>
                            <div id="busArrInfo">
                                <!-- 도착예정 버스 정보 -->
                            </div>
                        </div>

                        <div id="busLocInfo">
                            <!-- 버스 노선 정보 -->

                        </div>
                    </div>
                    <div class="clickColor"></div>
                </div>
        </div>
        <!-- /*<div class = 'header'>인 요소 선택*/ -->
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/jss/main.js"></script>

        <!-- fontawsome -->
        <script src="https://kit.fontawesome.com/5db7097b9a.js" crossorigin="anonymous"></script>

        <!-- 카카오맵 script -->
        <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7dc2c6b0b75b52fca2072b8f50ecfe78"></script>

        <!-- JQUERY script -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

        <script>
            var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                mapOption = {
                    center: new kakao.maps.LatLng(37.4387, 126.6750), // 지도의 중심좌표
                    level: 3 // 지도의 확대 레벨
                };

            var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

            // 지도에 클릭 이벤트를 등록합니다
            // 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
            kakao.maps.event.addListener(map, 'click', function (mouseEvent) {

                // 클릭한 위도, 경도 정보를 가져옵니다 
                var latlng = mouseEvent.latLng;
                console.log("위도 : " + latlng.getLat());
                console.log("경도 : " + latlng.getLng());

                getBusSttnList(latlng.getLat(), latlng.getLng())
                // 정류소 목록 조회 기능

            });
        </script>


        <script>
            //정류소 목록 조회 기능    
            function getBusSttnList(latitude, longtitude) {
                console.log("getBussttnList() 호출");
                console.log(latitude + ":" + longtitude);
                $.ajax({
                    type: "get",
                    url: "getTagoSttnList",
                    data: { "lati": latitude, "longi": longtitude },
                    dataType: "json",
                    success: function (result) {
                        // console.log(result);
                        // console.log(result.length);

                        // 정류소 목록 기능 호출
                        printBusSttnList(result);
                    }
                });
            }

            let currentCityCode = null;
            let selectBusNodeId = null;

            let oldMarker = null;
            //정류소 목록 출력 기능
            function printBusSttnList(sttnList) {
                console.log("printBusSttnList 호출")
                console.log(sttnList);
                console.log(sttnList.length);

                let busSttnArea = document.querySelector("#busSttnArea")
                busSttnArea.innerHTML = ""; // 정류소 목록 초기화;

                

                for (let sttn of sttnList) {

                    let sttnDiv = document.createElement('div');
                    sttnDiv.classList.add('busSttn');
                    sttnDiv.innerText = sttn.nodeno + " " + sttn.nodenm;
                    sttnDiv.addEventListener('click', function () {
                        var moveLatLon = new kakao.maps.LatLng(sttn.gpslati, sttn.gpslong);
                        document.querySelector(".clickColor").classList.remove("clickColor");    
                        sttnDiv.classList.add('clickColor');
                        // 지도 중심을 부드럽게 이동시킵니다
                        // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
                        map.panTo(moveLatLon);

                        var markerPosition = new kakao.maps.LatLng(sttn.gpslati, sttn.gpslong);

                        // 마커를 생성합니다
                        var marker = new kakao.maps.Marker({
                            position: markerPosition
                        });

                        if (oldMarker != null) {
                            oldMarker.setMap(null);
                        }
                        marker.setMap(map);
                        oldMarker = marker;

                        // 마커가 지도 위에 표시되도록 설정합니다
                        marker.setMap(map);
                        selectBusNodeId = sttn.nodeid;
                        currentCityCode = sttn.citycode;
                        document.querySelector("#busArrInfo").innerHTML = "";
                        document.querySelector("#busLocInfo").innerHTML = "";
                        getBusArrInfo(sttn.citycode, sttn.nodeid)
                    });
                    busSttnArea.append(sttnDiv);
                    
                }
            }

            $(document).ready(function () {
                getBusSttnList(37.4387, 126.6750);
            })
        </script>

        <!-- <script>
            function getBusArrInfo(citycode, nodeid) {
                console.log("버스 도착 정보 getBusArrInfo() 호출")
                console.log("도시코드 : " + citycode + " ||정류소ID : " + nodeid)
            }
        </script> -->

        <script>
            function getBusArrInfo(citycode, nodeid) {
                console.log("getBusArrInfo() 호출");
                console.log("도시코드 : " + citycode + "|| 정류소 아이디" + nodeid);
                $.ajax({
                    type: "get",
                    url: "getTagoArrList",
                    data: { "citycode": citycode, "nodeid": nodeid },
                    dataType: "json",
                    success: function (result) {

                        printBusArrInfo(result);

                    }
                });
            }

            function printBusArrInfo(arrList) {
                console.log("버스도착정보 출력 기능 호출")
                console.log(arrList);
                console.log(arrList.length);
                console.log(arrList.length == undefined);

                let busArrInfoDiv = document.querySelector("#busArrInfo");
                busArrInfoDiv.innerHTML = ""; //초기화

                for (let arrInfo of arrList) {

                    let arrInfoDiv = document.createElement('div');
                    arrInfoDiv.classList.add('arrInfo');
                    arrInfoDiv.innerText = arrInfo.routeno + "번   " + arrInfo.arrprevstationcnt + "정거장 전   " + arrInfo.arrtime + "초 후 도착예정  ";

                    arrInfoDiv.addEventListener('click', function () {
                        console.log("버스 선택!");
                        // 버스 위치 정보 조회 기능 호출
                        getBusLocList(arrInfo.routeid, currentCityCode, arrInfo.nodeid);
                    })

                    busArrInfoDiv.appendChild(arrInfoDiv);


                }
            }

            function getBusLocList(rid, ccode, selnodeid) {
                console.log("버스 위치정보 조회 기능 호출");
                console.log("도시 코드 : " + ccode);
                console.log("버스ID : " + rid);
                let nodeList = null; // 정류소 목록
                let locList = null; // 버스 위치 목록
                // 1. 버스 노선 정보 - 국토교통부_(TAGO)_버스노선정보 (노선별 경유 정류소 목록 조회)
                $.ajax({
                    type: "get",
                    url: "getTagoBusNodeList",
                    data: {
                        "citycode": ccode,
                        "routeid": rid
                    },
                    dataType: "json",
                    async: false,
                    success: function (nodeResult) {
                        nodeList = nodeResult;
                    }
                });

                // 2. 버스 위치 경보- - 국토교통부_(TAGO)_버스위치 정보 (노선별 버스위치 목록 조회)
                $.ajax({
                    type: "get",
                    url: "getTagoBusLocList",
                    data: {
                        "citycode": ccode,
                        "routeid": rid
                    },
                    dataType: "json",
                    async: false,
                    success: function (busLocResult) {
                        locList = busLocResult;
                    }
                });

                //3. 정류소 목록 출력 <div id = "busLocInfo"

                console.log("정류소 목록");
                console.log(nodeList);
                console.log("버스 위치 목록");
                console.log(locList);

                let locNodeIdList = []; // 버스 위치 목록의 nodeid 
                let nodeIdList = []; // 버스 정류소 목록

                for (let SnodeID of nodeList) {
                    nodeIdList.push(SnodeID.nodeid);
                }
                for (let locnode of locList) {
                    locNodeIdList.push(locnode.nodeid);
                }

                console.log(locNodeIdList);

                let busLocInfoDiv = document.querySelector("#busLocInfo")
                busLocInfoDiv.innerHTML = "";

                for (let busNode of nodeList) {

                    let busNodeDiv = document.createElement('div');
                    busNodeDiv.classList.add('busNode') //

                    /* busNode.nodeid 가 버스 위치 목록(locList)에 있으면*/
                    if (locNodeIdList.includes(busNode.nodeid)) {   //배열.includes 는 노드안에있는 것을 포함하면 true 아니면 false
                        console.log(busNode.nodeid);
                        busNodeDiv.classList.add('nowBus');
                        busNodeDiv.innerHTML = '<i class="fa-solid fa-bus"></i>' + busNode.nodenm;
                    }else{
                        busNodeDiv.innerHTML =  busNode.nodenm;
                    }

                    // 선택한 정류소인지 확인
                    // if(busNode.nodeid== selnodeid){
                    //     console.log(selnodeid);
                    //     busNodeDiv.classList.add("selectBusNode");
                    // }

                    if (busNode.nodeid == selectBusNodeId) {
                        busNodeDiv.classList.add("selectBusNode");
                        busNodeDiv.setAttribute("tabindex", "0");
                        busNodeDiv.setAttribute("id", "focusNode");
                    }



                    busLocInfoDiv.appendChild(busNodeDiv);
                }
                document.querySelector("#focusNode").focus();
            }
        </script>


    </body>

    </html>