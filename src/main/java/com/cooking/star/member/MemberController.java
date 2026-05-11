package com.cooking.star.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	
	@GetMapping("join")
	public void join()throws Exception {
		
		
	}
	@PostMapping("join")
	public String join(MemberDTO memberDTO)throws Exception{
		
		memberService.join(memberDTO);
		
		return "/";
	}
	
	
	
}
