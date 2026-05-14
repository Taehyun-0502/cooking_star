package com.cooking.star.cart;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cooking.star.search.SearchService;

@Controller
@RequestMapping("/cart/*")
public class CartController {

	@Autowired
	private CartService cartService;
	
	@Autowired
	private SearchService searchService;
	
	@GetMapping("search") //네이버 쇼핑 검색폼
	public void search(@RequestParam(name = "query", required = false) String query,Model model)throws Exception{
		if(query !=null&&!query.isEmpty()) {
			
			List<CartDTO> ar = searchService.shopping(query);
			model.addAttribute("list", ar);
		}
		
	}
	
	@PostMapping("insert")
	@ResponseBody
	public int insert(CartDTO cartDTO,Principal principal)throws Exception{
		//로그인 여부 확인
		if(principal == null) {
			return -1;
		}
		cartDTO.setUsername(principal.getName());
		return cartService.insert(cartDTO);
	}
	
	
	@GetMapping("/cart/list")
	public void list(Model model)throws Exception{
		
//		List<CartDTO> ar =cartService.list();
//		model.addAttribute("cart", ar);
//		
	}
}
