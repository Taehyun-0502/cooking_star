package com.cooking.star.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.web.SecurityFilterChain;

import com.cooking.star.member.MemberService;
import com.cooking.star.security.AddLogout;
import com.cooking.star.security.AddLogoutHandler;
import com.cooking.star.security.LoginFailHandler;
import com.cooking.star.security.LoginSuccessHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	@Autowired
	private LoginSuccessHandler loginSuccessHandler;
	
	@Autowired
	private LoginFailHandler loginFailHandler;
	
	@Autowired
	private AddLogout addLogout;
	
	@Autowired
	private AddLogoutHandler logoutHandler;
	@Autowired
	private MemberService memberService;
	
	@Bean
	WebSecurityCustomizer customizer() {
		return web->{
			web.ignoring()
			.requestMatchers("/css/**")
			.requestMatchers("/images/**","/img/**","/js/**")
			.requestMatchers("/lib/**")
			.requestMatchers("/scss/**")
			;
			
		};
		
	}
	@Bean
	SecurityFilterChain securityFilterChain(HttpSecurity security)throws Exception {
		
		security.cors(cros->{cros.disable();})
		.csrf(csrf->{csrf.disable();})
		.authorizeHttpRequests(auth->{
			auth.requestMatchers(
			        "/", 
			        "/member/login",
			        "/member/join",
			        "/member/user",
			        "/myrecipe/allList",
			        "/myrecipe/detail",
			        "/mycooking/allList",
			        "/mycooking/detail"
			    ).permitAll()
			.requestMatchers("/admin/memberList")
			.hasRole("ADMIN")
			.requestMatchers("/admin/recipeList","/admin/dashboard","/myrecipe/deleteM").hasAnyRole("ADMIN","MANAGER")
			.requestMatchers("/admin/**")
			.hasRole("ADMIN");

		    auth.requestMatchers(
		        "/member/mypage",
		        "/member/update",
		        "/member/follower",
		        "/member/following",
		        "/myrecipe/create",
		        "/myrecipe/update",
		        "/myrecipe/delete",
		        "/myrecipe/comment",
		        "/myrecipe/commentD",
		        "/myrecipe/good",
		        "/myrecipe/myList",
		        "/mycooking/create",
		        "/mycooking/update",
		        "/mycooking/delete",
		        "/mycooking/myList",
		        "/bookmark/**",
		        "/cart/**",
		        "/buylist/**",
		        "/follow/**",
		        "/spot/**",
		        "/search/list",
		        "/search/save",
		        "/search/delete"
		    ).authenticated();
		    
		    auth.anyRequest().permitAll();	
			
		})
		.formLogin(form->{
			form.loginPage("/member/login")
			.usernameParameter("username")
			.passwordParameter("password")
			.loginProcessingUrl("/member/login")
			.successHandler(loginSuccessHandler)
			.failureHandler(loginFailHandler);
			
		})
		.logout(logout->{
			logout.logoutUrl("/member/logout")
			.invalidateHttpSession(true)
			.deleteCookies("JSESSIONID")
			.addLogoutHandler(addLogout)
			.logoutSuccessHandler(logoutHandler);
			
		})
		.rememberMe(remember->{
			remember.rememberMeParameter("rememberMe")
			.key("rememberKey")
			.tokenValiditySeconds(60*60*24*7)
			.userDetailsService(memberService)
			.authenticationSuccessHandler(loginSuccessHandler)
			.useSecureCookie(true);
			
		});
		
		
		
		
		return security.build();
		
	}
	
	
	
	
	
	
	
	
	
	
	
}
