package com.cooking.star.myrecipe;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/myrecipe/*")
public class MyRecipeController {

	@Autowired
	private MyRecipeService myRecipeService;
	
	@GetMapping("create")
	public void create() throws Exception{}
	
	@PostMapping("create")
	public int create(MyRecipeDTO myRecipeDTO)throws Exception{
		
		int result=myRecipeService.create(myRecipeDTO);
		return result;
	}
	
	
}
