package com.project.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.project.dto.MemberDto;

public interface ReplyDao {
	
	@Select("Select NVL(count(*),0) From replys where REMID=#{loginId}")
	int replyNum(String loginId);




}
