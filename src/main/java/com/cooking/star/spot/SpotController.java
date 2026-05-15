package com.cooking.star.spot;

import java.security.Principal;
import java.util.List;

import com.cooking.star.cart.CartController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/spot/*")
public class SpotController {

    private final CartController cartController;

	@Autowired
	private SpotService spotService;

    SpotController(CartController cartController) {
        this.cartController = cartController;
    }
	
	@GetMapping("search")
	public String search(@RequestParam(name="query",required = false) String query,Model model,Principal principal)throws Exception{
		
		if(query != null && !query.trim().isEmpty()) {
		
			String username=principal.getName();
			List<SpotDTO>list = spotService.search(query,username);
			
			
			model.addAttribute("list", list);
			
			
		}
		model.addAttribute("query", query);

        return "spot/list";
		
	}
	@PostMapping("add")
	@ResponseBody
	public int add(SpotDTO spotDTO,Principal principal)throws Exception{
		String username=principal.getName();
		
		spotDTO.setUsername(username);
		
		int result=spotService.add(spotDTO);

		return result;
		
		
		
	}
	@GetMapping("myList")
	public void myList(Principal principal,Model model)throws Exception{
		String username= principal.getName();
		
		
		List<SpotDTO>ar=spotService.myList(username);
		
		model.addAttribute("myList", ar);
		
	}	
	
	
	
	
}
