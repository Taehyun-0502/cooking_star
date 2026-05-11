package com.cooking.star.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.session.HttpSessionEventPublisher;

import com.sun.jdi.connect.Transport;

@Configuration
public class PasswordConfig {
	
	@Bean
	PasswordEncoder encoder() {
		
		
		return new BCryptPasswordEncoder();
	}
	
	HttpSessionEventPublisher sessionEventPublisher() {
		
		return new HttpSessionEventPublisher();
		
	}
	
	
	
	
	
}
