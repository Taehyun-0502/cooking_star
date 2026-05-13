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

import com.cooking.star.member.MemberDTO;
import com.cooking.star.pager.Pager;

@Controller
@RequestMapping("/myrecipe/*")

public class MyRecipeController {

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
	
	@GetMapping("detail")
	public void detail(MyRecipeDTO myRecipeDTO,Model model)throws Exception{
		myRecipeService.updateHit(myRecipeDTO);
		myRecipeDTO=myRecipeService.detail(myRecipeDTO);
		model.addAttribute("dto",myRecipeDTO);
		
	}
	@GetMapping("update")
	public void update(MyRecipeDTO myRecipeDTO,Model model)throws Exception{
		myRecipeDTO=myRecipeService.detail(myRecipeDTO);
		model.addAttribute("dto",myRecipeDTO);
		
		
	}
	
	@PostMapping("update")
	public String update(@RequestParam(name = "attach", required = false) MultipartFile attach,MyRecipeDTO myRecipeDTO)throws Exception{
		int result=myRecipeService.update(myRecipeDTO,attach);
		return "redirect:/myrecipe/detail?recipeNum="+myRecipeDTO.getRecipeNum();
	}
	
}
