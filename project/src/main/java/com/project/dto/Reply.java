package com.project.dto;

import lombok.Data;

@Data
public class Reply {
	
	private int renum;          //댓글 번호
	private int rebno;          //게시판 번호
	private String remid;       //작성자 
	private String recomment;   //작성 내용
	private String redate;      //작성 일자	
	private String restate;     //작성 상태


}
