package com.cooking.star.search;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/search/*")
@Slf4j
public class SearchController {
	
	@Value("${app.myrecipe}")
	private String name;
	

	@Autowired
	private SearchService searchService;
	
	@GetMapping("result")
	public String resultPage(@RequestParam(name="query") String query, Model model) {
		
		model.addAttribute("searchQuery", query);
		
		
		return "search/blog";
	}
	
	@PostMapping("blog")
	@ResponseBody
	public String search(@RequestParam(name="query") String query)throws Exception{
		String result =searchService.search(query);
		
		
		return result;	
	}

	
	
	
	
	
	
}
