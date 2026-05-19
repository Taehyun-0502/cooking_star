package com.cooking.star.cookinggood;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/mycooking/*")
public class CookingGoodController {
	
	@Autowired
	private CookingGoodService cookingGoodService;
	
	
	@PostMapping("good")
	@ResponseBody
	public CookingGoodResponseDTO good(CookingGoodDTO cookingGoodDTO, Principal principal) throws Exception {
		
		// 1. 현재 로그인한 유저명 가져오기
		String username = principal.getName();
		
		// 2. 주머니에 유저명 채워넣기
		cookingGoodDTO.setUsername(username);
		
		// 3. 서비스 호출해서 결과 바로 리턴하기
		return cookingGoodService.toggleGood(cookingGoodDTO);
	}
}