package com.cooking.star.member;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.cooking.star.myrecipe.MyRecipeDTO;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberDTO implements UserDetails{

	@NotBlank(groups = GroupAdd.class,message = "ID는 필수 입니다")
	private String username;
	
	@Size(groups = GroupAdd.class,max=20,min=8)
	@NotBlank(groups = GroupAdd.class)
	@Pattern(groups = GroupAdd.class,
			regexp ="^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*])[A-Za-z\\d!@#$%^&*]{8,20}$"
	,message = "비밀번호는 영문, 숫자, 특수 문자를 포함해야 합니다")
	private String password;
	
	private String passwordCheck;
	
	@NotBlank(groups = {GroupAdd.class,GroupUpdate.class})
	private String name;
	
	@Email(groups = {GroupAdd.class,GroupUpdate.class})
	private String email;
	private boolean enabled;
	private boolean credentialsNonExpired;
	private boolean accountNonLocked;
	private boolean accountNonExpired;
	private ProfileDTO profileDTO;
	
	private List<RoleDTO> roles;
	
	private List<MyRecipeDTO> myRecipeList;
	
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
