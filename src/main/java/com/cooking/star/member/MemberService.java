package com.cooking.star.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {

	@Autowired
	private MemberMapper memberMapper;
	
	public int join(MemberDTO memberDTO)throws Exception{
		
		return memberMapper.join(memberDTO);
		
		
	}
	
	
	
}
