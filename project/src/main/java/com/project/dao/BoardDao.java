package com.project.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.project.dto.Board;
import com.project.dto.Reply;

public interface BoardDao {

	@Select ("SELECT NVL(MAX(BNO),0) FROM BOARDS")
	int SelectMaxBno();
	
//	@Insert("Insert INTO BOARDS (bno,bwriter,btitle,bcontents,bhits,bfilename,bdate,bstate)"
//			+ " values(#{bno},#{bwriter},#{btitle},#{bcontents},0,#{bfilename},sysdate,'1')")
	int InsertResult(Board board);

	@Select ("SELECT * FROM BOARDS WHERE BNO = #{bno}")
	Board SelectResult(int board);

	@Select("SELECT * FROM BOARDS WHERE BSTATE = '1' ORDER BY BNO")
	ArrayList<Board> SelectBoardList();

	@Select("SELECT NVL(MAX(RENUM),0) from REPLYS")
	int seletMaxRenum();

	@Insert("INSERT INTO REPLYS (RENUM,REBNO,REMID,RECOMMENT,REDATE,RESTATE)"
			+ " VALUES(#{renum},#{rebno},#{remid},#{recomment},sysdate,'1')")
	int insertReply(Reply re);

	@Select("Select count(*) From boards Where BWRITER = #{loginId}")
	int boardnum(String loginId);

	@Select("Select NVL(count(*),0) From replys where REBNO =#{i}")
	int ReplyCount(int i);

	ArrayList<HashMap<String, String>> selectBoards_map();
}
