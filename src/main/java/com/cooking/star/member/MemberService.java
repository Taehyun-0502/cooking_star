package com.cooking.star.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;
import org.springframework.web.multipart.MultipartFile;

import com.cooking.star.file.FileManager;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemberService implements UserDetailsService{

	@Autowired
	private MemberMapper memberMapper;
	@Autowired
	private PasswordEncoder passwordEncoder;
	@Autowired
	private FileManager fileManager;
	@Value("${app.profile}")
	private String name;
	
	
	public MemberDTO myProfile(MemberDTO memberDTO)throws Exception {
		
		MemberDTO m=memberMapper.myProfile(memberDTO);
		
		return m;
	}
	
	
	
	
	public int join(MemberDTO memberDTO,MultipartFile attach)throws Exception{
		
		memberDTO.setPassword(passwordEncoder.encode(memberDTO.getPassword()));
		int result =memberMapper.join(memberDTO);
		
		if(attach != null && !attach.isEmpty()) {
			String fileName= fileManager.fileSave(name, attach);
			
			ProfileDTO profileDTO = new ProfileDTO();
			
			profileDTO.setFileName(fileName);
			profileDTO.setOriName(attach.getOriginalFilename());
			profileDTO.setUsername(memberDTO.getUsername());
			memberMapper.addProfile(profileDTO);
			
		}
		
		
		return result;
		
	}
	
	public MemberDTO login(MemberDTO memberDTO)throws Exception{
		
		MemberDTO check= memberMapper.login(memberDTO);
		if(check !=null) {
			
			if(check.getPassword().equals(memberDTO.getPassword())) {
				return check;
			}
		}
		
		
		return null;
		
	}
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		
		MemberDTO memberDTO =new MemberDTO();
		memberDTO.setUsername(username);
		memberDTO=memberMapper.login(memberDTO);
		log.info("{}",memberDTO);
		if (memberDTO == null) {
	        throw new UsernameNotFoundException("존재하지 않는 회원입니다: " + username);
	    }
		
		
		
		return memberMapper.login(memberDTO);
	}
	
	public boolean doubleCheck(MemberDTO memberDTO , BindingResult bindingResult)throws Exception{
		
		boolean result = false;
		
		result = bindingResult.hasErrors();
		
		if(!memberDTO.getPassword().equals(memberDTO.getPasswordCheck())) {
			
			bindingResult.rejectValue("passwordCheck", "member.passwordCheck.notEqual");
			result=true;
		}
		MemberDTO m= memberMapper.login(memberDTO);
		if(m != null) {
			result=true;
			bindingResult.rejectValue("username", "member.username.equal");
			
		}
		return result;
		
	}
	
	public int myProfileUpdate(MemberDTO memberDTO)throws Exception {
		
		int result = memberMapper.myProfileUpdate(memberDTO);
		return result;
	}
	
	
	
	
}
