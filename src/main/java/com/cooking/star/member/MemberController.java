package com.cooking.star.member;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member/*")
@Slf4j
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
	@GetMapping("mypage")
	public void mypage(Principal principal,Model model)throws Exception {
		
		MemberDTO memberDTO = new MemberDTO();
			memberDTO.setUsername(principal.getName());
		MemberDTO m=memberService.myProfile(memberDTO);
		
		model.addAttribute("myProfile",m);
		
		
		
	}
	@GetMapping("update")
	public void update(MemberDTO memberDTO,Principal principal, Model model)throws Exception{

	    String username = principal.getName();

	    MemberDTO m = new MemberDTO();
	    memberDTO.setUsername(username);

	    MemberDTO myInfo = memberService.myProfile(memberDTO);
 
	    model.addAttribute("memberDTO", myInfo);

	   
	}
	@PostMapping("update")
	public String myProfileUpdate(MemberDTO memberDTO)throws Exception {
		
		
		int result = memberService.myProfileUpdate(memberDTO);
		
		
		
		return "redirect:/member/mypage";
	}
	
	
	
}
