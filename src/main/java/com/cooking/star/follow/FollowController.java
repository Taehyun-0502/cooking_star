package com.cooking.star.follow;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/follow")
@ResponseBody
public class FollowController {

	@Autowired
	private FollowService followService;
	
	@PostMapping("following")
	public int follow(FollowDTO followDTO,Principal principal)throws Exception{
		
		String username =principal.getName();
		
		followDTO.setFollowerUser(username);
			
		int result = followService.follow(followDTO);

		return result;
	}
	@PostMapping("unFollowing")
	public int unFolloew(FollowDTO followDTO,Principal principal)throws Exception{
		String username =principal.getName();
		
		followDTO.setFollowerUser(username);
		
		return followService.unFollow(followDTO);
		
	}
	
	
}
