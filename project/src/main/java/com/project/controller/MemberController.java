package com.project.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.dto.MemberDto;
import com.project.service.BoardService;
import com.project.service.MemberService;
import com.project.service.ReplyService;

@Controller
public class MemberController {

	@Autowired
	private MemberService msvc;
	
	@Autowired
	private BoardService bsvc;
	
	@Autowired
	private ReplyService rsvc;

	ModelAndView mav = new ModelAndView();

	@RequestMapping(value = "/memberJoinForm")
	public ModelAndView memberJoinForm() {
		System.out.println("회원가입 이동 요청 -/");
		mav.setViewName("member/MebmerJoinForm");
		return mav;
	}

	@RequestMapping(value = "/memberIdCheck")
	public @ResponseBody String memberIdCheck(String inputId) {
		System.out.println("아이디 중복 확인 요청");
		System.out.println("중복 확인 할 아이디 : " + inputId);

		// 1. 서비스 호출 - 아이디 중복 확인 기능
		// MEMBER 테이블의 MID 컬럼에 저장된 아이디 인지 확인
		// SELECT * FROM MEMBER WHRER MID = #{아이디};
		String checkResult = msvc.idCheck(inputId);

		// 2. 중복 확인 결과 변환 Y: 사용가능 N: 사용불가
		return checkResult; // @ResponseBody 가 붙음으로써 Y.jsp가 아닌 Y를 반납하는거 임니다
	}

	@RequestMapping(value = "/memberJoin")
	public ModelAndView memberJoin(MemberDto mem, String memailDomain, String memailId, RedirectAttributes ra) {
		ModelAndView mav = new ModelAndView();
		System.out.println("회원 가입 요청");
		mem.setMemail(memailId + "@" + memailDomain);
		System.out.println(mem);

		int result = msvc.InsertMemberJoin(mem);
		System.out.println(result);
		if (result > 0) {
			/*
			 * views/Success.jsp alert{'${msg'}) location href = "${url};
			 * 
			 * mav.setViewName("Success"); mav.addObject("msg","회원가입에 성공 했습니다");
			 * mav.addObject("url","/");
			 */

			// 이동 요청 다시 요청
			/* redirect 일떄만 사용 가능 */
			System.out.println("가입 성공");
			mav.setViewName("redirect:/");
//			ra.addFlashAttribute("이름","값")
			ra.addFlashAttribute("msg", "회원가입 되었습니다.");
		} else {
			System.out.println("회원가입에 실패하였습니다");
			ra.addFlashAttribute("msg", "회원가입에 실패하였습니다.");
			mav.setViewName("redirect:/memberJoinForm");
		}
		return mav;
	}

	/* 1. 로그인 페이지 이동 요청에 대한 처리 /memberLoginForm */
	@RequestMapping(value = "/memberLoginForm")
	public ModelAndView memberLoginForm() {
		System.out.println("로그인 이동 요청 -/");
		mav.setViewName("member/MemberLoginForm");
		return mav;
	}

	/* 2. 로그인 요청에 대한 처리 /memberLogin */
	@RequestMapping(value = "/memberLogin")
	public ModelAndView memberLogin(MemberDto mem, HttpSession session, RedirectAttributes rs) {
		System.out.println("로그인 처리 요청 - /memberJoin");
		ModelAndView mav = new ModelAndView();
		// 1. 로그인할 아이디, 비밀번호 파라메터 확인
		// 2.Service - 로그인 회원정보 조히 호출
		MemberDto loginMember =  msvc.getLoginMemberInfo(mem);
		System.out.println(loginMember);
		if (loginMember == null) {
			System.out.println("로그인 실패");
			/*
			 * 아이디 또는 비밀번호가 일치하지 않습니다.|출력 로그인 페이지로 이동
			 */
			rs.addFlashAttribute("msg","로그인에 실패하였습니다");
			mav.setViewName("redirect:/memberLoginForm");
		} else {
			System.out.println("로그인 성공");
			/*
			 * 로그인 성공.|출력 메인 페이지로 이동
			 */
			rs.addFlashAttribute("msg","로그인에 성공하였습니다");
			session.setAttribute("loginMemberId", loginMember.getMid());
			mav.setViewName("redirect:/");
		}
		return mav;
	}
	
	@RequestMapping(value = "/memberLogout")
	public ModelAndView memberLogout(HttpSession session) {
		System.out.println("로그아웃 요청");
		ModelAndView mav = new ModelAndView();
//		session.invalidate(); // session 값 전부 초기화.
		session.removeAttribute("loginMemberId");
		mav.setViewName("redirect:/"); // 메인페이지
		return mav;
	}
	
	@RequestMapping(value = "/myinfo")
	public ModelAndView myinfo(HttpSession session) {
		System.out.println("회원정보 페이지 이동 요청 - myInfo");
		ModelAndView mav = new ModelAndView();
		// 1.SERVICE - 회웢넝보 조회
		// 회원정보를 조회할 아이디 = 세션 logniMemberId
		String loginId = (String)session.getAttribute("loginMemberId");
		MemberDto member = msvc.myinfo(loginId);
		mav.addObject("myInfo",member);
		
		int BoradNum = bsvc.boradnum(loginId);
		mav.addObject("boardnum",BoradNum);
		

		int ReplyNum = rsvc.replyNum(loginId);
		mav.addObject("replynum",ReplyNum);
		// 2. member/MyInfo.jsp 응답
		
		mav.setViewName("member/MyInfo");
		return mav;
	}
	
	@RequestMapping(value = "/memberModifyForm")
	public ModelAndView memberModifyForm(HttpSession session) {
		System.out.println("회원정보 페이지 이동 요청 - myInfo");
		ModelAndView mav = new ModelAndView();
		// 1.SERVICE - 회웢넝보 조회
		// 회원정보를 조회할 아이디 = 세션 logniMemberId
		MemberDto member = msvc.myinfo((String)session.getAttribute("loginMemberId"));
		mav.addObject("myInfo",member);
		
		// 2. member/MyInfo.jsp 응답
		mav.setViewName("member/memberModifyForm");
		return mav;
	}
	
	@RequestMapping(value = "/memberModify")
	public ModelAndView memberModify(MemberDto member, HttpSession session, RedirectAttributes ra) {
		System.out.println("회원정보 수정 요청");
		ModelAndView mav = new ModelAndView();
		String loginId = (String)session.getAttribute("loginMemberId");
		int changeInfo = msvc.changeInfo(member,loginId);
		
		if(changeInfo > 0) {
			System.out.println("회원정보 수정 성공");
			ra.addFlashAttribute("msg","회원정보가 수정 되었습니다.");
		} else {
			System.out.println("회원정보 수정 실패");
			ra.addFlashAttribute("msg","회원정보가 실패하였습니다.");
		}
		mav.setViewName("redirect:/");
		return mav;
	}

}
