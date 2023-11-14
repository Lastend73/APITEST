package com.project.sockUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

public class ChatHandler extends TextWebSocketHandler {

	// 채팅 페이지에 접속하면
	private ArrayList<WebSocketSession> clientList = new ArrayList<WebSocketSession>();

	// 접속할떄
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("체팅 페이지 접속");

		Map<String, Object> sessionAttrs = session.getAttributes();
		String loginId = (String) sessionAttrs.get("loginMemberId");
		System.out.println("로그인 된 아이디 :" + loginId);
		
		
		Map<String, String> msgInfo = new HashMap<String, String>();
		msgInfo.put("msgtype","c"); // "c":접속 "d":접속헤제 "m":채팅
		msgInfo.put("msgid",loginId );
		msgInfo.put("msgcomm"," 접속 하셨습니다");

		Gson gson = new Gson();
		clientList.add(session); // 클라이언트 목록에 저장
		

		
//		 새 참여자 접속 안내


//				Map<String, Object> clientsessionAttrs = client.getAttributes();
//				String clientloginId = (String) clientsessionAttrs.get("loginMemberId");
//				System.out.println("client"+i+ ": "+clientloginId+" ");
//				joinMemberId.put("client"+i,clientloginId );
//				i++;
//				client.sendMessage(new TextMessage(gson.toJson(joinMemberId)));
			for (WebSocketSession client : clientList) {
				if (!client.getId().equals(session.getId())) {
					client.sendMessage(new TextMessage(gson.toJson(msgInfo)));
				}
			}
		for (WebSocketSession client : clientList) {
			
			Map<String, Object> clientAttrs = client.getAttributes();
			String clientMemberId = (String) clientAttrs.get("loginMemberId");
			
			Map<String, String> clientInfo = new HashMap<String, String>();
			clientInfo.put("msgtype","c"); // "c":접속 "d":접속헤제 "m":채팅
			clientInfo.put("msgid",clientMemberId );
			clientInfo.put("msgcomm"," 접속 하셨습니다");
			
			
			session.sendMessage(new TextMessage(gson.toJson(clientInfo)));
		}
		System.out.println("현재 접속자 수 : " + clientList.size());
		System.out.print("로그인 한 아이디 목록 : ");
				
		}
		

	

	// 서버가 클라이언트로 부터 메세지를 전달 받을때
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("체팅 메세지 전송");

		Map<String, Object> sessionAttrs = session.getAttributes();

		String loginId = (String) sessionAttrs.get("loginMemberId");
		
		System.out.println("전송한 ID : " + loginId);
		System.out.println("전송받은 메세지 : " + message.getPayload());

		Gson gson = new Gson();

		Map<String, String> msgInfo = new HashMap<String, String>();

		msgInfo.put("msgtype", "m");// "c":접속 "d":접속헤제 "m":채팅
		msgInfo.put("id", loginId);
		msgInfo.put("message", message.getPayload());

		for (WebSocketSession client : clientList) {
			if (!client.getId().equals(session.getId())) {
				client.sendMessage(new TextMessage(gson.toJson(msgInfo)));
			}

		}

	}

	// 클라이언트가 서버로 부터 접속 헤제 할때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("체팅 페이지 접속해제");
		clientList.remove(session); // 클라이언트 목록에서 제거

		Map<String, Object> sessionAttrs = session.getAttributes();
		String loginId = (String) sessionAttrs.get("loginMemberId");

		Gson gson = new Gson();

		Map<String, String> msgInfo = new HashMap<String, String>();
		msgInfo.put("msgtype", "d"); // "c":접속 "d":접속헤제 "m":채팅
		msgInfo.put("msgid", loginId);
		msgInfo.put("msgcomm", " 접속을 해제하였습니다.");

		for (WebSocketSession client : clientList) {
			// 접속해제 안내 메세지 전송
			client.sendMessage(new TextMessage(gson.toJson(msgInfo)));
		}
	}

}
