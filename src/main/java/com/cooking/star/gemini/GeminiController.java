package com.cooking.star.gemini;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cooking.star.gemini.GeminiService; // GeminiService 경로
import java.time.LocalTime;
@Controller
public class GeminiController {

	@Autowired
    private GeminiService geminiService;
	
	@Autowired
	private GeminiMapper geminiMapper;

    @GetMapping("/") //index page
    public String index(Model model) throws Exception {
        //저장된 제미나이 문구를 가져오기
    	String menuDB=geminiMapper.getMenu();
      
    	model.addAttribute("gemini",menuDB);
        return "index"; 
    }
  
}

