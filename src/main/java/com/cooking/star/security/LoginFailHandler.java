package com.cooking.star.security;

import java.io.IOException;
import java.net.URLEncoder;

import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class LoginFailHandler implements AuthenticationFailureHandler{

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		log.info("로그인 실패");
		String message="로그인 실패";
		if(exception instanceof AccountExpiredException) {
			//계정이 만료 되었을 때 
			message="계정이 만료";
		}
		if(exception instanceof LockedException) {
			//계정이 잠겨 있을 때 
			message="계정이 잠김";
		}
		if (exception instanceof CredentialsExpiredException) {
			//비번 유효기간이 만료 
			message="비번 만료";
		}
		if(exception instanceof DisabledException) {
			//휴면 계정
			message="휴면 계정";
		}
		if(exception instanceof BadCredentialsException) {
			//비번이 잘못됨
			message="비번을 다시 입력";
		}
		if(exception instanceof InternalAuthenticationServiceException) {
			//아이디가 틀림
			message="아이디 다시 입력";
		}
		message=URLEncoder.encode(message,"UTF-8");
		response.sendRedirect("./login?message="+message);
		
	}
	
	
	
}
