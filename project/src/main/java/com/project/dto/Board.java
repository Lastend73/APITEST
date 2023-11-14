package com.project.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Board {
	
	private int bno;
	private String bwriter;
	private String btitle;
	private String bcontents;
	private int bhits;
	private String bdate;
	private String bstate;

	private String bfilename;   	// 파일 이름
	private MultipartFile bfile;	// 첨부 파일
	
	private int recount; // 댓글수
}
