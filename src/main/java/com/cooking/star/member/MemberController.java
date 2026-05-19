package com.cooking.star.member;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.cooking.star.bookmark.BookmarkDTO;
import com.cooking.star.bookmark.BookmarkService;
import com.cooking.star.follow.FollowDTO;
import com.cooking.star.follow.FollowService;
import com.cooking.star.myrecipe.MyRecipeDTO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member/*")
@Slf4j
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private FollowService followService;

	@Value("${app.profile}")
	private String name;
	@ModelAttribute("name")
	public String getName() {
		return this.name;
	}
	@Autowired
	private BookmarkService bookmarkService;
	
	@GetMapping("join")
	public void join(MemberDTO memberDTO)throws Exception {
		
		
	}
	@PostMapping("join")
	public String join(@Validated(GroupAdd.class) MemberDTO memberDTO,BindingResult bindingResult,@RequestParam(name="attach",required = false) MultipartFile attach)throws Exception{
		if(memberService.doubleCheck(memberDTO, bindingResult)) {
			
			return "member/join";
			
		}
		
		
		
		int result=memberService.join(memberDTO,attach);
		
		if(result == 0) {
			
			
		}
		
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
		String username = principal.getName();
		MemberDTO memberDTO = new MemberDTO();
			memberDTO.setUsername(principal.getName());
		MemberDTO m=memberService.myProfile(memberDTO);
		// 로그인 한 사람을 팔로일 한 수
		int follower= memberService.followerCount(username);
		
		// 로그인 한 사람이 팔로잉 한 수 
		int following=memberService.followingCount(username);
		BookmarkDTO bookmarkDTO = new BookmarkDTO();
		bookmarkDTO.setUsername(principal.getName());
		
		
		int bookmarkCount=bookmarkService.bookCount(bookmarkDTO);
		
		model.addAttribute("bookmark", bookmarkCount);
		model.addAttribute("myProfile",m);
		model.addAttribute("follower", follower);
		model.addAttribute("following", following);
		
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
	public String myProfileUpdate(@Validated(GroupUpdate.class) MemberDTO memberDTO,BindingResult bindingResult,@RequestParam(name="attach", required = false) MultipartFile attach)throws Exception {
		
		if(bindingResult.hasErrors()) {
	        return "member/update";
		}
		int result = memberService.myProfileUpdate(memberDTO,attach);
		
		
		
		return "redirect:/member/mypage";
	}
	@GetMapping("user")
	public void user(MemberDTO memberDTO,Model model, Principal principal)throws Exception {
		
		
		List<MyRecipeDTO>ar =memberService.user(memberDTO);
		
		String targetuser=memberDTO.getUsername();
		
		
		model.addAttribute("targetuser", targetuser);
		model.addAttribute("list", ar);
		
		if(principal != null) {
			 String loginUser = principal.getName();

		        FollowDTO followDTO = new FollowDTO();
		        followDTO.setFollowerUser(loginUser);      // 현재 로그인한 사람
		        followDTO.setFollowingUser(targetuser);    // 레시피 작성자

		        int isFollow = followService.check(followDTO);

		        model.addAttribute("isFollow", isFollow);
		        model.addAttribute("loginUser", loginUser);
			
			
		}
		
		
	}
	@GetMapping("follower")
	public void followerList(Principal principal,Model model)throws Exception {
		String username =principal.getName();
		List<FollowDTO> ar=memberService.followerList(username);
		model.addAttribute("follower",ar);
		
	}
	
	
	@GetMapping("following")
	public void followingList(Principal principal,Model model) throws Exception{
		String username = principal.getName();
		List<FollowDTO> ar = memberService.followingList(username);
		model.addAttribute("following", ar);
		
		
	}
	
	
	
	
	
}
