package com.project.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.dto.Board;
import com.project.dto.Reply;
import com.project.service.BoardService;

@Controller
public class BoardController {

	@Autowired
	private BoardService bsvc;

	@RequestMapping(value = "/boardWriteForm")
	public ModelAndView boardWriteForm() {
		System.out.println("글쓰기 요청");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("board/BoardWriteForm");
		return mav;
	}

	// 글등록기능
	@RequestMapping(value = "/boardWrite")
//	MultipartFile 형식이 파일을 가저올수 있음
	public ModelAndView boardWrite(Board board, HttpSession session, RedirectAttributes ra) throws IllegalStateException, IOException {
		System.out.println("글 등록 요청 - boardWrite");
		System.out.println(session.getServletContext().getRealPath(null));
		ModelAndView mav = new ModelAndView();
		String bwriter = (String) session.getAttribute("loginMemberId");
		board.setBwriter(bwriter);

		// 첨부 파일이름
		System.out.println(board.getBfile().getOriginalFilename());

		// SERVICE - 글 등록 기능 호출
		int writeResult = bsvc.resgistBoard(board, session);

		if (writeResult > 0) {
			System.out.println("글 등록 성공");
			mav.setViewName("redirect:/boardList"); // 글 목록 페이지
			ra.addFlashAttribute("noticeMsg", "newBoard");
			
		} else {
			System.out.println("글 등록 실패");
			mav.setViewName("redirect:/boardWriteForm"); // 글 작성 페이지
		}

		return mav;
	}

	// 글 상세보기 요청
	@RequestMapping(value = "/boardview")
	public ModelAndView boardview(int bno) {
		System.out.println("글 상세 보기 요청 - /boardview");
		ModelAndView mav = new ModelAndView();
		System.out.println("상세번호 글번호 : " + bno);

		// 1. 글정보 조회
		Board selectResult = bsvc.selectResult(bno);
		// 2. 글 상세보기 페이지
		System.out.println(selectResult);
		mav.addObject("view", selectResult);
		mav.setViewName("board/BoardView");

		return mav;
	}

	@RequestMapping(value = "/boardList")
	public ModelAndView boardList() {
		System.out.println("글 목록 페이지 이동요청 - /boardList");
		ModelAndView mav = new ModelAndView();

		// SELECT * FROM BOARDS WHERE BSTAT = '1' ORDER BY BNO DESC
		ArrayList<Board> boardList = bsvc.SelectBoardList();
		mav.addObject("List", boardList);

		// Hashmap
		ArrayList<HashMap<String, String>> blist_map = bsvc.getBoardList_map();
		System.out.println(blist_map);
		mav.addObject("bListMap", blist_map);
		mav.setViewName("board/BoardList");
		return mav;
	}

	@RequestMapping(value = "/replyWrite")
	public @ResponseBody String replyWrite(Reply re, HttpSession session) {
		System.out.println("댓글 등록 요청 - /replyWrite");
		String remid = (String) session.getAttribute("loginMemberId");
		re.setRemid(remid);
		System.out.println(re);
		int result = bsvc.resgistReply(re);
		System.out.println("result : " + result);
		return result + "";
	}
}
