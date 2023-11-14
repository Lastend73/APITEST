<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
		<!DOCTYPE html>
		<html>
		<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7dc2c6b0b75b52fca2072b8f50ecfe78"></script>

		<head>
			<meta charset="UTF-8">
			<title>메인페이지</title>
			<style type="text/css">
				.sttnbtn {
					width: 150px;
					margin: 8px;
				}

				table {
					margin: auto;
					width: 700px;
					text-align: center;
					margin-top: 13px;
					margin-bottom: 13px;
				}

				table,
				th,
				td {
					border: 1px solid black;
					border-collapse: collapse;
				}
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
						<%-- --%>

							<h2>컨텐츠 영역</h2>
							<button onclick=""></button>
							<div id="map" style="width:300px;height:300px; margin: auto;"></div>

							<hr>

							<div id="btn" style="text-align: center;">

							</div>
							<hr>
							<div id="busInfoArea">

							</div>

							<hr>

							<div id="busLocArea"></div>

							<hr>

							<div id="busLoc" style="width:300px;height:300px; margin: auto;"></div>


					</div>
			</div>

			<script type="text/javascript">

				var mapContainer = document.getElementById('map'); // 지도를 표시할 div 
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

					var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
					message += '경도는 ' + latlng.getLng() + ' 입니다';

					console.log(message);

					getBusStnList(latlng.getLat(), latlng.getLng());
				});
			</script>


			<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jss/main.js">
				/*<div class = 'header'>인 요소 선택*/
			</script>

			<script type="text/javascript">
				let msg = '${msg}';
				if (msg.length > 0) {
					alert(msg);
				}
			</script>

			<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
			<script type="text/javascript">
				function getBusArrInfo(nodeId) {
					console.log("nodeId : " + nodeId);

					// 1. 도착정보 조회 ajax
					$.ajax({
						type: "get",
						url: "getBusArr",
						data: {
							"nodeId": nodeId
						},
						dataType: "json",
						success: function (arrInfoList) {
							// 도착정보 출력 기능 호출
							printBusArrInfo(arrInfoList);
						}
					});
				}

				function printBusArrInfo(arrList) {
					console.log("도착정보 출력 기능 호출");
					/*<div id="busInfoArea"></div> 선택*/
					//도착 정보를 출력할 DIV 선택
					let busInfoArea_div = document.querySelector("#busInfoArea");
					busInfoArea_div.innerHTML = "";

					let loc = document.querySelector("#busLocArea");
					loc.innerHTML = "";

					let busLoc = document.querySelector("#busLoc");
					busLoc.innerHTML = "";

					let tableTag = document.createElement('table'); //<table></table> 생성

					let trTag = document.createElement('tr'); //<tr></tr> 생성

					let thTag1 = document.createElement('th'); //<th></th> 생성
					thTag1.innerText = "번호"//<th>번호</th> 생성
					trTag.appendChild(thTag1); // tr태그에  th태그를 자식으로 집어넣기

					let thTag2 = document.createElement('th'); //<th></th> 생성
					thTag2.innerText = "남은정류장"//<th>번호</th> 생성
					trTag.appendChild(thTag2); // tr태그에  th태그를 자식으로 집어넣기

					let thTag3 = document.createElement('th'); //<th></th> 생성
					thTag3.innerText = "도착예정시간"//<th>번호</th> 생성
					trTag.appendChild(thTag3); // tr태그에  th태그를 자식으로 집어넣기


					tableTag.appendChild(trTag);

					for (let info of arrList) {
						let infoTrTag = document.createElement('tr'); //<tr></tr> 생성
						let tdTag_routeno = document.createElement('td'); //<td></td> 생성
						tdTag_routeno.innerText = info.routeno;
						tdTag_routeno.setAttribute("onclick", "	getBusloc('" + info.routeid + "')")
						infoTrTag.appendChild(tdTag_routeno);

						let tdTag_arrprevstationcnt = document.createElement('td'); //<td></td> 생성
						tdTag_arrprevstationcnt.innerText = info.arrprevstationcnt + "번째 전";
						infoTrTag.appendChild(tdTag_arrprevstationcnt);

						let tdTag_arrtime = document.createElement('td'); //<td></td> 생성
						tdTag_arrtime.innerText = parseInt((info.arrtime / 60)) + "분" + (info.arrtime % 60) + "초 후 도착예정";
						infoTrTag.appendChild(tdTag_arrtime);

						tableTag.appendChild(infoTrTag);


						// console.log(info.routeno);
						// console.log(info.arrprevstationcnt);
						// console.log(info.arrtime);
					}
					console.log(tableTag);
					busInfoArea_div.appendChild(tableTag);

				}

				/*		<table>
						<tr>
							<th>번호</th>
							<th>남은 정류장</th>
							<th>도착에정시간</th>
						</tr>
						<tr>
							<th>4</th>
							<th>3번째전</th>
							<th>456초</th>
				
						</tr>
					</table>*/

			</script>

			<script>
				$(document).ready(function () {
					getBusStnList(37.4387, 126.6750);
				});
			</script>

			<script>
				function getBusloc(node) {
					$.ajax({
						type: "get",
						url: "getBusloc",
						data: {
							"node": node
						},
						dataType: "json",
						success: function (busloc) {

							getbuslocAll(busloc);

						}
					})
				}
			</script>

			<script>
				//버스노선에 위치한 모든 버스의 번호 및 위치 
				function getbuslocAll(busloc) {
					let loc = document.querySelector("#busLocArea");
					loc.innerHTML = "";
					let busLoc = document.querySelector("#busLoc");
					busLoc.innerHTML = "";

					let table = document.createElement("table");
					loc.appendChild(table);

					let tr = document.createElement("tr");
					table.appendChild(tr);

					let th_nodenm = document.createElement("th"); // 정류소명
					th_nodenm.innerText = "정류소명"

					let th_vehicleno = document.createElement("th"); // 차량번호
					th_vehicleno.innerText = "차량번호"

					tr.appendChild(th_nodenm);
					tr.appendChild(th_vehicleno);

					for (let list of busloc) {
						let info_tag = document.createElement("tr");


						let td_nodenm = document.createElement("td"); //정류소 위치
						td_nodenm.innerText = list.nodenm;
						td_nodenm.setAttribute("onclick", "getbusloc(" + list.gpslati + "," + list.gpslong + ")")
						info_tag.appendChild(td_nodenm);

						let td_vehicleno = document.createElement("td"); // 차량번호
						td_vehicleno.innerText = list.vehicleno;
						info_tag.appendChild(td_vehicleno);

						table.appendChild(info_tag);
					}
				}
			</script>

			<script>
				//클릭한 버스위치 정보 확인
				function getbusloc(gpslati, gpslong) {
					console.log("gpslati" + gpslati);
					let busLoc = document.querySelector("#busLoc");
					busLoc.innerHTML = "";

					mapOption = {
						center: new kakao.maps.LatLng(gpslati, gpslong), // 지도의 중심좌표
						level: 3 // 지도의 확대 레벨
					};
					var map = new kakao.maps.Map(busLoc, mapOption);

					var markerPosition = new kakao.maps.LatLng(gpslati, gpslong);

					// 마커를 생성합니다
					var marker = new kakao.maps.Marker({
						position: markerPosition
					});

					// 마커가 지도 위에 표시되도록 설정합니다
					marker.setMap(map);
				}
			</script>

			<script>
				function getBusStnList(lati, longti) {
					$.ajax({
						type: "get",
						url: "getBusSttn",
						data: {
							"lati": lati,
							"longti": longti
						},
						dataType: "json",
						success: function (sttnList) {

							console.log(sttnList.length);
							getStnList(sttnList);
							// console.log("정류소 아이디 :"+stn.nodeid);
							// console.log("정류소 이름 :"+stn.nodenm);
							// console.log("도시코드 :"+stn.citycode);

						}
					})
				}

				function getStnList(list) {

					let btn_list = document.querySelector("#btn");
					let idx = 0;
					btn_list.innerHTML = "";

					for (let sttn of list) {
						let sttnBtn = document.createElement('button');
						sttnBtn.classList.add('sttnbtn');
						sttnBtn.setAttribute("onclick", "getBusArrInfo('" + sttn.nodeid + "')")

						sttnBtn.innerHTML = sttn.nodeno + "<br>" + sttn.nodenm;
						btn_list.appendChild(sttnBtn);
						idx++;
						if (idx % 5 == 0) {
							let br = document.createElement('br');
							btn_list.appendChild(br);
						}
					}
					console.log(btn_list);
				}
			</script>



		</body>

		</html>