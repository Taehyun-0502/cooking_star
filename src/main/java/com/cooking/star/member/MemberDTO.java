package com.cooking.star.member;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberDTO implements UserDetails{

	private String username;
	private String password;
	private String name;
	private String email;
	private boolean enabled;
	private boolean credentialsNonExpired;
	private boolean accountNonLocked;
	private boolean accountNonExpired;
	private ProfileDTO profileDTO;
	
	private List<RoleDTO> roles;
	
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		
		List<GrantedAuthority>ar=new ArrayList<>();
		if(this.roles == null) {
			return ar;
		}
		
		
		for(RoleDTO roleDTO:this.roles) {
			GrantedAuthority g = new SimpleGrantedAuthority(roleDTO.getRoleName());
			ar.add(g);
			
		}
		return ar;
		
		
	}
	
}
