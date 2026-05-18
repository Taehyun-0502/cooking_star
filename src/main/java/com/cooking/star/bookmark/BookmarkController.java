package com.cooking.star.bookmark;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("bookmark")
public class BookmarkController {

	@Autowired
	private BookmarkService bookmarkService;
	
	@GetMapping("add")
	public String addBookmark(Principal principal, BookmarkDTO bookmarkDTO)throws Exception{
		if(principal == null) {
			return "redirect:/member/login";
		}
		
		bookmarkDTO.setUsername(principal.getName());
		
		bookmarkService.addBookmark(bookmarkDTO);
		
		return "redirect:/myrecipe/detail?recipeNum="+bookmarkDTO.getRecipeNum();
	}
	
	@GetMapping("delete")
	public String deleteBookmark(Principal principal, BookmarkDTO bookmarkDTO)throws Exception{
		if(principal == null) {
			return "redirect:/member/login";
		}
		
		bookmarkDTO.setUsername(principal.getName());
		
		bookmarkService.deleteBookmark(bookmarkDTO);
		
		return "redirect:/myrecipe/detail?recipeNum="+bookmarkDTO.getRecipeNum();
	}
	
	@GetMapping("list")
	public void list (Principal principal , BookmarkDTO bookmarkDTO,Model model)throws Exception{
		
		bookmarkDTO.setUsername(principal.getName());
		List<BookmarkDTO> ar=bookmarkService.list(bookmarkDTO);
		
		model.addAttribute("list", ar);
		
	}
	
	
	
	
}
