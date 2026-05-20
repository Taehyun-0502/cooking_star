package com.cooking.star.visit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class VisitInterceptor implements HandlerInterceptor {

	@Autowired
	private VisitService visitService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		if("GET".equalsIgnoreCase(request.getMethod())) {
			visitService.todayVisit(request);
		}
		return true;
	}
	
}
