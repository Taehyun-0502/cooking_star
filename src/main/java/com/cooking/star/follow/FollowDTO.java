package com.cooking.star.follow;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FollowDTO {

	private Long followNum;
	private String followerUser;
	private String followingUser;
	
}
