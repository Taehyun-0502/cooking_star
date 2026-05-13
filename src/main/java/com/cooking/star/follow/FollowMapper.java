package com.cooking.star.follow;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FollowMapper {

	public int follow(FollowDTO followDTO)throws Exception;
	
	public int unFollow(FollowDTO followDTO)throws Exception;
	
	public int  check(FollowDTO followDTO)throws Exception;
	
	
	
	
}
