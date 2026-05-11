package com.cooking.star.member;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {

	public int join(MemberDTO memberDTO)throws Exception;
	
	
	
}
