<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
		<!DOCTYPE html>
		<html>

		<head>

			<!-- toastr css-->
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.css"
				integrity="sha512-oe8OpYjBaDWPt2VmSFR+qYOdnTjeV9QPLJUeqZyprDEQvQLJ9C5PCFclxwNuvb/GQgQngdCXzKSFltuHD3eCxA=="
				crossorigin="anonymous" referrerpolicy="no-referrer" />

			<meta charset="UTF-8">
			<title>MebmerJoinForm</title>
			<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Main.css">
			<style type="text/css">
				div.formWrap {
					padding-left: 10px;
					width: 756px;
					margin: auto;
				}

				div.formWrap {
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

				div.formRow>input {
					width: 100%;
					outline: none;
					border: none;
					border-radius: 5px;
				}

				.formRow>input,
				.formRow>textarea {
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

				.cen {
					text-align: center;
					padding-left: 5px;
					padding-right: 5px;
				}

				.title {
					padding-left: 10px;
					width: 400px;
				}

				.cen,
				.title {
					padding-top: 5px;
					padding-bottom: 5px;
				}

				table {
					border-collapse: collapse;
				}

				td {
					border-top: 1px solid black;
				}
				a{
				text-decoration-line: none;
				}
			</style>

		</head>

		<body>
			<div class="mainWrap">

				<div class="header">
					<h1>views/board/boardList.jsp</h1>
				</div>
				<%@ include file="/WEB-INF/views/include/Menu.jsp" %>

					<div class="contents">
						<h2 style="text-align: center;">글목록페이지 - ${noticeMsg}</h2>
						<!-- 아이디, 비밀번호, 이름, 생년월일, 이메일 -->
						<div class="formWrap">
							<form action="${pageContext.request.contextPath}/boardWrite" method="post">
								<div class="formRow">
									<table>
										<tr>
											<th class="cen">번호</th>
											<th class="cen">제목</th>
											<th class="cen">작성자</th>
											<th class="cen">조회수</th>
											<th class="cen">작성일</th>
										</tr>
										<c:forEach var="List" items="${List }">
											<tr>
												<td class="cen">${List.bno}</td>
												<td class="title">
													<a
														href="${pageContext.request.contextPath}/boardview?bno=${List.bno}">
														${List.btitle}
													</a>
													<c:if test="${List.bfilename != null }">
														<span><i class="fa-regular fa-image"></i></span>
													</c:if>

													<span>
														<i class="fa-regular fa-message"></i>
														<span style="font-size: 10px;">${List.recount}</span>

													</span>
												</td>
												<td class="cen">${List.bwriter}</td>
												<td class="cen">${List.bhits}</td>
												<td class="cen">${List.bdate}</td>
											</tr>
										</c:forEach>
									</table>
								</div>

								<div class="formRow">
									<table>
										<tr>
											<th class="cen">번호</th>
											<th class="cen">제목</th>
											<th class="cen">작성자</th>
											<th class="cen">조회수</th>
											<th class="cen">작성일</th>
										</tr>
										<c:forEach var="bomap" items="${bListMap }">
											<tr>
												<td class="cen">${bomap.BNO}</td>
												<td class="title">
													<a
														href="${pageContext.request.contextPath}/boardview?bno=${bomap.BNO}">
														${bomap.BTITLE}
													</a>
													<c:if test="${bomap.BFILENAME != null }">
														<span><i class="fa-regular fa-image"></i></span>
													</c:if>

													<span>
														<i class="fa-regular fa-message"></i>
														<span style="font-size: 10px;">${bomap.RECOUNT}</span>

													</span>
												</td>
												<td class="cen">${bomap.BWRITER}</td>
												<td class="cen">${bomap.BHITS}</td>
												<td class="cen">${bomap.BDATE}</td>
											</tr>
										</c:forEach>
									</table>
								</div>
							</form>
						</div>

					</div>
			</div>
		</body>
		<script src="https://kit.fontawesome.com/5db7097b9a.js" crossorigin="anonymous"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jss/main.js"></script>

		
		<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jss/NoticeJS.js"></script>
		
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
		
		<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.min.js"
		integrity="sha512-lbwH47l/tPXJYG9AcFNoJaTMhGvYWhVM9YI43CT+uteTRRaiLCui8snIgyAN8XWgNjNhCqlAUdzZptso6OCoFQ=="
		crossorigin="anonymous" referrerpolicy="no-referrer"></script>

		<script type="text/javascript">
			let msg = '${msg}';
			if (msg.length > 0) {
				alert(msg);
			}
		</script>

		<script>
			let noticeSock = connectionNotice("${noticeMsg}");
		</script>




		</html>