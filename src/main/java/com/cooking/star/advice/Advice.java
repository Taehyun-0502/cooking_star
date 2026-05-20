package com.cooking.star.advice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.cooking.star.visit.VisitService;

import lombok.RequiredArgsConstructor;

@ControllerAdvice
@RequiredArgsConstructor
public class Advice {

	@Autowired
	private VisitService visitService;
	
	 	@ModelAttribute("todayVisitCount")
	    public Long todayVisitCount() throws Exception {
	        return visitService.getTodayVisitCount();
	    }

	    @ModelAttribute("totalMemberCount")
	    public Long totalMemberCount() throws Exception {
	        return visitService.getTotalMemberCount();
	    }
	
}
