package com.project.sockUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class NoticeHandler extends TextWebSocketHandler {

	private ArrayList<WebSocketSession> clientList = new ArrayList<WebSocketSession>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// NoticeSock에 접속
		clientList.add(session);

	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// NoticeSock에 메세지 전송
		System.out.println(message.getPayload());

		// {"noticeType":"reply","bno":10,"bwriter":"작성자"}
		JsonObject noticeobj = JsonParser.parseString(message.getPayload()).getAsJsonObject();

		String noticeType = noticeobj.get("noticeType").getAsString();
		System.out.println("noticeType : " + noticeType);
		
		Map<String, String> msgInfo = new HashMap<String, String>();
		msgInfo.put("msgtype",noticeType);



		// 클라이언트가 웹소켓에 메세지를 전송 했을 때 실행

		// Message >>공지종류, 댓글이 작성된 글의 글번호, 댓글이 작성된 글작성자
		// 공지종류 : 새 글 등록 알림(전체), 댓글 등록 알림(개별)

		switch (noticeType) {
		case "reply": // 개별 전송 - bwriter에게 전송
			String bno = noticeobj.get("noticeMsg").getAsString();
			String bwriter = noticeobj.get("received").getAsString();
			msgInfo.put("msgcomm", bno);
//			msgInfo.put("bwriter", bwriter);
			
			for (WebSocketSession client : clientList) {
				
				Map<String, Object> clientAttrs = client.getAttributes();
				String clientMemberId = (String) clientAttrs.get("loginMemberId");
				
				if(clientMemberId.equals(bwriter)) {
					client.sendMessage(new TextMessage(new Gson().toJson(msgInfo) ) );
				}
			}
			break;

		case "board": // 전체전송
			msgInfo.put("msgcomm", "새 글이 등록 되었습니다");
			for (WebSocketSession client : clientList) {
				client.sendMessage(new TextMessage(new Gson().toJson(msgInfo) ) );
			}
			break;
		}

		// 새글 등록 알림 : "새 글이 등록 되었습니다."
		// 글번호, 알림을 받을 대상

		// 댓글 등록 알림 : "??번글에 댓글이 등록되었습니다"

		// 서버가 접속중인 클라이언트들에게 메세지 전송
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// NoticeSock에 접속헤제
		
		clientList.remove(session);
	}
	
}


