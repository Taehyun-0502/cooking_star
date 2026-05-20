package com.cooking.star.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.cooking.star.visit.VisitInterceptor;

import lombok.RequiredArgsConstructor;

@Configuration
@RequiredArgsConstructor
public class WebConfig implements WebMvcConfigurer{

	@Autowired
	private VisitInterceptor visitInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(visitInterceptor)
		.addPathPatterns("/**")
		.excludePathPatterns("/css/**","/js/**","/img/**","/lib/**","/scss/**","/webfonts/**","/favicon.ico","/error");
	}
}
