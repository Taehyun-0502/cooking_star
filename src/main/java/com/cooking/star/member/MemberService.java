package com.cooking.star.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemberService implements UserDetailsService{

	@Autowired
	private MemberMapper memberMapper;
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	public int join(MemberDTO memberDTO)throws Exception{
		
		memberDTO.setPassword(passwordEncoder.encode(memberDTO.getPassword()));
		
		
		
		return memberMapper.join(memberDTO);
		
		
	}
	
	public MemberDTO login(MemberDTO memberDTO)throws Exception{
		
		
		
		return memberMapper.login(memberDTO);
		
	}
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		
		MemberDTO memberDTO =new MemberDTO();
		memberDTO.setUsername(username);
		memberDTO=memberMapper.login(memberDTO);
		log.info("{}",memberDTO);
		
		
		return memberMapper.login(memberDTO);
	}
}
