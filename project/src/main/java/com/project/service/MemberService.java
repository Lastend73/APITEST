package com.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.MemberDao;
import com.project.dto.*;

@Service
public class MemberService {

	@Autowired
	private MemberDao mdao;

	public String idCheck(String inputId) {
		System.out.println("SERVICE - midcheck() 호출");
		System.out.println("아이디 : " + inputId);

		// DAO - SELECT * FROM MEMBERS WHERE MID = #{아이디};
//		Member mid = mdao.selectMidCheck(inputId);

		MemberDto member = mdao.selectMemberInfo(inputId);
		System.out.println(member);
//		MemberDto member_mapper = mdao.selectMemberInfo11(inputId, inputId);

		System.out.println();
		String result = "N";

		if (member == null) {
			result = "Y";
		}
		return result;
	}

	public int InsertMemberJoin(MemberDto mem) {
		System.out.println("SERVICE - InsertMemberJoin() 호출");
		System.out.println(mem);

		int result = 0;
		try {
			result = mdao.InsertInfo(mem);
		} catch (Exception e) {
			e.printStackTrace();// 에외 발생시 콘솔 창에 출력
		}
		System.out.println(result);

		return result;
	}

	public MemberDto getLoginMemberInfo(MemberDto mem) {
		System.out.println("아이디 :" + mem.getMid());
		System.out.println("비밀번호 :" + mem.getMpw());

		MemberDto member  = mdao.findMemberInfo(mem);

		return member;
	}


	public MemberDto myinfo(String inputid) {
		
		MemberDto member  = mdao.selectMemberInfo(inputid);
//		System.out.println(member);
		return member;
	}

	public int changeInfo(MemberDto member, String loginId) {
		System.out.println(member);
		System.out.println("현재 로그인 아이디 : " + loginId);
		
		int changeInfo = 0;
		try {
			changeInfo = mdao.changeInfo(member,loginId);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return changeInfo;
	}

}
