package com.project.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.project.dto.MemberDto;

public interface MemberDao {

	@Select("SELECT MID, MPW, MNAME, TO_CHAR(MBIRTH, 'YYYY-MM-DD') AS MBIRTH, MEMAIL FROM MEMBERS WHERE MID = #{inputId}")
	MemberDto selectMemberInfo(String inputId);

	// 매게 변수가 2개이상 (inputId & inputpw) 일떄는
	@Select("SELECT * FROM MEMBERS WHERE MID = #{mid} AND MPW = #{inputPw}")
	MemberDto selectMemberInfo11(@Param("mid") String inputId, @Param("inputPW") String inputPw);

	
	//mapper
	MemberDto selectMemberInfo_mapper(@Param("inputId") String inputId);

	@Insert ("INSERT INTO MEMBERS(MID,MPW,MNAME,MBIRTH,MEMAIL,MSTATE) VALUES (#{mid},#{mpw},#{mname},#{mbirth},#{memail},1)")
	int InsertInfo(MemberDto mem);

//	@Select("SELECT * FROM MEMBERS WHERE MID = #{mid} AND MPW = #{mpw}")
	MemberDto findMemberInfo(MemberDto mem);

	@Update("Update MEMBERS SET MID = #{member.mid}, MPW =#{member.mpw},MNAME = #{member.mname}, MBIRTH = #{member.mbirth}, MEMAIL = #{member.memail} WHERE MID=#{loginId} ")
	int changeInfo(@Param("member")MemberDto member, @Param("loginId")String loginId);


}
