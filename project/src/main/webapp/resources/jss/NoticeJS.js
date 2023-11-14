

function connectionNotice(noticeMsg) {

	var noticeSock = new SockJS('noticeSocket');

	//열때
	noticeSock.onopen = function () {
		console.log('noticeSocket 접속');
		if (noticeMsg.length > 0) {
			noticeSock.send(noticeMsg);
		}
	};

	//메세지 받을때
	noticeSock.onmessage = function (e) {
		console.log("새글이 등록되었습니다.");

		noticeAlert(e.data);
	};

	//나갈떄
	noticeSock.onclose = function () {
		console.log('noticeSocket 접속헤제');
	};

	return noticeSock;

}

function noticeAlert(msgJson) {
	let msgjObj = JSON.parse(msgJson);
	let mtype = msgjObj.msgtype;
	switch (mtype) {
		case "reply":
			toastr.options.onclick = function(){
				location.href = '/controller/boardView?bno='+msgoObj.msgcomm;
			}
			toastr.success(msgjObj.msgcomm + "번 글에 댓글이 등록되었습니다");
			break;
		case "board":
			toastr.options.onclick = function(){
				location.href = '/controller/boardList';
			}
			toastr.info(msgjObj.msgcomm);
			break;
	}
}

