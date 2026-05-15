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
	
	
	@GetMapping("list")
	public String list(Model model,Principal principal)throws Exception{
		if(principal != null) {
			CartDTO cartDTO = new CartDTO();
	        cartDTO.setUsername(principal.getName()); // 내 아이디 세팅
	        
	        // 2. 내 아이디에 해당하는 목록만 가져오기
	        List<CartDTO> ar = cartService.list(cartDTO);
	        model.addAttribute("list", ar);
	        return "cart/list";
		}
		return "redirect:/member/login";
	}
	
	@PostMapping("updateEa")
	@ResponseBody
	public int updateEa(CartDTO cartDTO) throws Exception {
	    // JS에서 보낸 데이터가 cartDTO의 cartNum, productEa에 자동으로 매칭됩니다.
	    return cartService.updateEa(cartDTO);
	}

	@PostMapping("delete")
	@ResponseBody
	public int delete(CartDTO cartDTO, Principal principal) throws Exception {
	    // 1. 로그인 안 되어 있으면 거절
	    if (principal == null) return -1;

	   
	    cartDTO.setUsername(principal.getName());
	    
	    
	    return cartService.delete(cartDTO);
	}
}
