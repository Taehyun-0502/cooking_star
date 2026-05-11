package com.cooking.star.member;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberDTO {

	private String username;
	private String password;
	private String name;
	private String follower;
	private String following;
	private String email;
	private boolean enabled;
	private boolean credentialsNonExpired;
	private boolean accountNonLocked;
	private boolean accountNonExpired;
	
	
}
