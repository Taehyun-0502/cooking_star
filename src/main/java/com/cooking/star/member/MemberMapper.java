package com.cooking.star.member;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

@Mapper
public interface MemberMapper {

	public int join(MemberDTO memberDTO)throws Exception;
	
	public MemberDTO login(MemberDTO memberDTO)throws UsernameNotFoundException;
	
}
