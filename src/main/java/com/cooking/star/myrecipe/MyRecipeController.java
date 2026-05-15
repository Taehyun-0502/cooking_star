package com.cooking.star.myrecipe;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.cooking.star.good.GoodDTO;
import com.cooking.star.good.GoodService;
import com.cooking.star.member.MemberDTO;
import com.cooking.star.pager.Pager;

@Controller
@RequestMapping("/myrecipe/*")

public class MyRecipeController {

	@Autowired
	private GoodService goodService;
	
	@Autowired
	private MyRecipeService myRecipeService;
	
	@GetMapping("create")
	public void create() throws Exception{}
	
	@Value("${app.myrecipe}")
	private String name;
	
	@ModelAttribute("name")
	public String getName() {
		return this.name;
	}
	
	@PostMapping("create")
	public String create(@AuthenticationPrincipal MemberDTO memberDTO,MyRecipeDTO myRecipeDTO,Principal principal,@RequestParam(name =  "attach", required = false) MultipartFile attach)throws Exception{
//		MemberDTO memberDTO= new MemberDTO();
//		memberDTO.setUsername(principal.getName());
		myRecipeDTO.setUsername(memberDTO.getUsername());
		int result=myRecipeService.create(myRecipeDTO,attach);
		
		return "redirect:/myrecipe/allList";
	}
	@GetMapping("allList")
	public void allList(Pager pager,Model model)throws Exception{
		List<MyRecipeDTO> ar = myRecipeService.allList(pager);
		model.addAttribute("dto", ar);
		
	}
	
	@GetMapping("myList")
	public String myList(Pager pager,Principal principal,Model model) throws Exception{
		if(principal == null) {
			return "redirect:/member/login";
		}
		MyRecipeDTO myRecipeDTO = new MyRecipeDTO();
		myRecipeDTO.setUsername(principal.getName());
		List<MyRecipeDTO> ar = myRecipeService.myList(pager,myRecipeDTO);
		model.addAttribute("dto", ar);
		
		return "myrecipe/myList";
	}
	
	@GetMapping("detail")
	public void detail(MyRecipeDTO myRecipeDTO,Model model,Principal principal)throws Exception{
		myRecipeService.updateHit(myRecipeDTO);
		myRecipeDTO=myRecipeService.detail(myRecipeDTO);
		model.addAttribute("dto",myRecipeDTO);
		
		boolean isGood=false;
		
		if(principal != null) {
			GoodDTO goodDTO = new GoodDTO();
			goodDTO.setRecipeNum(myRecipeDTO.getRecipeNum());
			goodDTO.setUsername(principal.getName());
			
			isGood=goodService.isGood(goodDTO);
			
		}
		
		model.addAttribute("isGood", isGood);
		
	}
	@GetMapping("update")
	public String update(MyRecipeDTO myRecipeDTO,Model model,@AuthenticationPrincipal MemberDTO memberDTO)throws Exception{
		myRecipeDTO=myRecipeService.detail(myRecipeDTO);
		
		if(!myRecipeDTO.getUsername().equals(memberDTO.getUsername())) {
	        // 다르면 리스트로 쫓아내거나 에러 메시지 처리
	        return "redirect:/myrecipe/allList"; 
	    }
		
		
		
		model.addAttribute("dto",myRecipeDTO);
		
		return "myrecipe/update";
		
	}
	
	@PostMapping("update")
	public String update(@RequestParam(name = "attach", required = false) MultipartFile attach,MyRecipeDTO myRecipeDTO,@AuthenticationPrincipal MemberDTO memberDTO)throws Exception{
		MyRecipeDTO checkDTO= myRecipeService.detail(myRecipeDTO);
		
		if(!checkDTO.getUsername().equals(memberDTO.getUsername())) {
	        // 다르면 리스트로 쫓아내기
	        return "redirect:/myrecipe/allList"; 
	    }
		
		int result=myRecipeService.update(myRecipeDTO,attach);
		return "redirect:/myrecipe/detail?recipeNum="+myRecipeDTO.getRecipeNum();
	}
	
}
