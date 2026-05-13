package com.cooking.star.follow;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FollowService {

	@Autowired
	private FollowMapper followMapper;
	
	public int follow(FollowDTO followDTO)throws Exception{
		if(followDTO.getFollowerUser().equals(followDTO.getFollowingUser())) {
			return -1;
		}
		
		int check= followMapper.check(followDTO);
		
		if(check>0) {
			return 0;
		}
		
		
		int result = followMapper.follow(followDTO);
		
		return result;
	}
	
	public int check(FollowDTO followDTO)throws Exception {
		return followMapper.check(followDTO);
		
	}
	
	public int unFollow(FollowDTO followDTO)throws Exception{
		
		return followMapper.unFollow(followDTO);
		
	}
	
	
}
