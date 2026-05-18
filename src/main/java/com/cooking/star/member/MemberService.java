package com.cooking.star.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;
import org.springframework.web.multipart.MultipartFile;

import com.cooking.star.file.FileManager;
import com.cooking.star.follow.FollowDTO;
import com.cooking.star.myrecipe.MyRecipeDTO;

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
		//권한 자동 memeber 인서트
		memberMapper.addRole(memberDTO.getUsername());
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
	
	public int myProfileUpdate(MemberDTO memberDTO,MultipartFile attach)throws Exception {
		
		int result = memberMapper.myProfileUpdate(memberDTO);
		
		if(attach!=null && !attach.isEmpty()) {
			//유저의 기존 정보 조회
			MemberDTO beforeInfo=memberMapper.myProfile(memberDTO);
			//프로필사진 파일명 조회
			if(beforeInfo != null &&beforeInfo.getProfileDTO()!=null&& beforeInfo.getProfileDTO().getFileName() != null) {
				
			
				fileManager.fileDelete(name,beforeInfo.getProfileDTO());
				memberMapper.deleteProfile(memberDTO.getUsername());
			}
			String newFile=fileManager.fileSave(name, attach);
			
			ProfileDTO profileDTO=new ProfileDTO();
			profileDTO.setFileName(newFile);
			profileDTO.setOriName(attach.getOriginalFilename());
			profileDTO.setUsername(memberDTO.getUsername());
			
			memberMapper.addProfile(profileDTO);
		}
		return result;
	}
	
	public List<MyRecipeDTO>user(MemberDTO memberDTO)throws Exception{
		
		List<MyRecipeDTO>ar=memberMapper.user(memberDTO);
		
		return ar;
	}
	//로그인한 사람이 팔로잉 하는 사람의 리스트
	public List<FollowDTO>followingList(String username)throws Exception{
		
		return memberMapper.followingList(username);
		
	}
	//로그인한 사람을 팔로잉 하는 사람의 리스트
	public List<FollowDTO>followerList(String username)throws Exception{
		
		return memberMapper.followerList(username);
	}
	//로그인 한 사람을 팔로잉 한 수 
	public int followerCount(String username)throws Exception{
		
		return memberMapper.followerCount(username);
	}
	//로그인 한 사람이 팔로우 한 수 
	public int followingCount(String username)throws Exception{
		
		return memberMapper.followingCount(username);
	}
	
}
