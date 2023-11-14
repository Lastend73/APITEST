package com.project.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.project.dao.BoardDao;
import com.project.dto.Board;
import com.project.dto.Reply;

@Service
public class BoardService {

	@Autowired
	BoardDao bdao;

	// 글 등록 기능
	public int resgistBoard(Board board, HttpSession session) throws IllegalStateException, IOException {
		System.out.println("Service - resgistBoard() 호출");
		// 업로드된 파일 저장 - 저장경로 설정, 파일명 처리
		// 업로드된 파일 이름 추출

		MultipartFile bfile = board.getBfile();
		String bfilename = ""; // 파일명 저장할 변수

		String savePath = session.getServletContext().getRealPath("/resources/boardUpload"); // 파일을 저장할 경로

		// .isEmpty 비어있으면 true 없우묜 false
		if (!bfile.isEmpty()) { // 첨부파일 확인
			// bfile.isEmpty() 첨부파일이 없는 경우 true
			// !bfile.isEmpty() 파일이 있는 경우 true
			System.out.println("첨부파일 있음");

			// 임의의 코드 + img3.jpg
			// UUID 32자리 랜덤 코드
			UUID uuid = UUID.randomUUID();

			String code = uuid.toString();
			System.out.println("code : " + code);

			bfilename = code + "_" + bfile.getOriginalFilename();
			System.out.println("savePath  :" + savePath);

//			File newFile = new File("경로","파일명");
			File newFile = new File(savePath, bfilename);
			bfile.transferTo(newFile);

			// 저장할 경로 resources/boardUpload 폴더에 파일저장
			// D:\spring-workspace\project\src\main\webapp\resources\boardUpload
		}

		System.out.println("파일이름 : : " + bfilename);
		board.setBfilename(bfilename);
		// 글번호 생성 (최대값 + 1) - SELECT MAX(BNO) FROM BOARDS;
		int MaxNum = bdao.SelectMaxBno() + 1;
		board.setBno(MaxNum);
		System.out.println(board);
		// DAO - INSERT INTO BOARDS..

		// INSERT 결과 변환
		int result = 0;
		try {
			result = bdao.InsertResult(board);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}

	public Board selectResult(int bno) {
		System.out.println("Service - selectResult() 호출");

		Board SelectResult = bdao.SelectResult(bno);
		return SelectResult;
	}

	public ArrayList<Board> SelectBoardList() {
		System.out.println("Service - SelectBoardList() 호출");

		/*
		 * 글번호가 1번인 글의 댓글 수
		 * 
		 */

		ArrayList<Board> boardList = bdao.SelectBoardList();
		System.out.println(boardList);
		for (int i = 0; i < boardList.size(); i++) {
			int ReplyCount = bdao.ReplyCount(boardList.get(i).getBno());
			boardList.get(i).setRecount(ReplyCount);
		}
		System.out.println("boardList 출력");
		System.out.println(boardList);
		
		
		
		return boardList;
	}

	public int resgistReply(Reply re) {
		System.out.println("Service - resgistReply() 호출");

		// 1. 댓글 번호 생성
		int renum = bdao.seletMaxRenum() + 1;
		re.setRenum(renum);

		// 2.DAO - INSERT문 호출
		int insertResult = 0;
		try {
			System.out.println(renum);
			insertResult = bdao.insertReply(re);

		} catch (Exception e) {
			// TODO: handle exception
		}
		return insertResult;
	}

	public int boradnum(String loginId) {
		System.out.println("Service - boradnum() 호출");

		int boardNum = bdao.boardnum(loginId);
		return boardNum;
	}

	public ArrayList<HashMap<String, String>> getBoardList_map() {
		System.out.println("Service - getBoardList_map() 호출");
		return bdao.selectBoards_map();
	}

}
