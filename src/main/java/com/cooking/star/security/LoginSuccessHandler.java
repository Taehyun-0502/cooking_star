package com.cooking.star.security;


import java.io.IOException;


import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class LoginSuccessHandler implements AuthenticationSuccessHandler{

  

	@Override
		public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
				Authentication authentication) throws IOException, ServletException {
			
		String s= request.getParameter("rememberId");
		
		try {
		if(s.equals("1")) {
			log.info("로그인 성공");
			Cookie c= new Cookie("rememberId",authentication.getName());
			c.setMaxAge(600);
			c.setPath("/");
			response.addCookie(c);
		}else {
			throw new Exception();
		}
		}
		catch(Exception e){
			Cookie c= new Cookie("rememberId",authentication.getName());
			c.setMaxAge(0);
			c.setPath("/");
			response.addCookie(c);
			log.info("로그인 ?");
			
		}
		response.sendRedirect("/");	
		log.info("로그인 ??");
		
	}
	
}
