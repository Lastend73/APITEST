package com.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.ReplyDao;

@Service
public class ReplyService {

	@Autowired
	private ReplyDao rdao;

	public int replyNum(String loginId) {
		System.out.println("Service - replyNum() 호출");

		int boardNum = rdao.replyNum(loginId);
		return boardNum;

	}

}
