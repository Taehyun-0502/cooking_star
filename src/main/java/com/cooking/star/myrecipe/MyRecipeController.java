package com.cooking.star.myrecipe;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

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
	public String create(MyRecipeDTO myRecipeDTO,@RequestParam(name =  "attach", required = false) MultipartFile attach)throws Exception{
		
		int result=myRecipeService.create(myRecipeDTO,attach);
		
		return "redirect:/myrecipe/list";
	}
	@GetMapping("list")
	public void list(Pager pager,Model model)throws Exception{
		List<MyRecipeDTO> ar = myRecipeService.list(pager);
		model.addAttribute("dto", ar);
		return;
	}
	
	@GetMapping("detail")
	public void detail(MyRecipeDTO myRecipeDTO,Model model)throws Exception{
		List<MyRecipeDTO>ar=myRecipeService.detail(myRecipeDTO);
		model.addAttribute("dto", ar);
		
	}
	
	
}
