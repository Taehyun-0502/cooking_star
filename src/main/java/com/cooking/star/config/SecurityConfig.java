package com.cooking.star.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.web.SecurityFilterChain;

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
	
	@Bean
	WebSecurityCustomizer customizer() {
		return web->{
			web.ignoring();
			
		};
		
	}
	@Bean
	SecurityFilterChain securityFilterChain(HttpSecurity security)throws Exception {
		
		security.cors(cros->{cros.disable();})
		.csrf(csrf->{csrf.disable();})
		.authorizeHttpRequests(auth->{
			auth.requestMatchers("/notice/create","/notice/update","/notice/delete")
			.hasRole("ADMIN")
			.requestMatchers("/qna/detail","/qna/create","/qna/update","/qna/delete").hasRole("MEMBER")
			.requestMatchers("/bank/create","/bank/update","/bank/delete").hasAnyRole("ADMIN","MANAGER","MEMBER")
			.requestMatchers("/member/mypage","/member/logout","/member/update").authenticated()
			.anyRequest().permitAll()
			;
		;	
			
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
			
		});
		
		
		
		
		return security.build();
		
	}
	
	
	
	
	
	
	
	
	
	
	
}
