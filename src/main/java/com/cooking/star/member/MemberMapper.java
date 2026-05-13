package com.cooking.star.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.cooking.star.follow.FollowDTO;
import com.cooking.star.myrecipe.MyRecipeDTO;

@Mapper
public interface MemberMapper {

	public int join(MemberDTO memberDTO)throws Exception;
	
	public MemberDTO login(MemberDTO memberDTO)throws UsernameNotFoundException;
	
	public int addProfile(ProfileDTO profileDTO)throws Exception;
	
	public MemberDTO myProfile(MemberDTO memberDTO)throws Exception;
	
	public int myProfileUpdate(MemberDTO memberDTO)throws Exception;
	
	
	public List<MyRecipeDTO> user(MemberDTO memberDTO)throws Exception;
	
	public List<FollowDTO>followingList(String username)throws Exception;
	
	public List<FollowDTO>followerList(String username)throws Exception;
	
	public int followerCount(String username)throws Exception;
	
	public int followingCount(String username)throws Exception;
	
}
