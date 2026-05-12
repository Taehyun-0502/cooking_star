package com.cooking.star.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	
	@GetMapping("join")
	public void join(MemberDTO memberDTO)throws Exception {
		
		
	}
	@PostMapping("join")
	public String join(@Validated(GroupAdd.class) MemberDTO memberDTO,BindingResult bindingResult,@RequestParam(name="attach",required = false) MultipartFile attach)throws Exception{
		if(memberService.doubleCheck(memberDTO, bindingResult)) {
			
			return "member/join";
			
		}
		
		int result=memberService.join(memberDTO,attach);
		
		return "redirect:/";
	}
	@GetMapping("login")
	public void login() throws Exception{
		
	}
//	@PostMapping
//	public String login(MemberDTO memberDTO)throws Exception{
//		
//		memberService.login(memberDTO);
//		
//		
//		return "redirect:/";
//	}
	
	
	
}
