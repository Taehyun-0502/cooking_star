package com.cooking.star.gemini;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cooking.star.gemini.GeminiService; // GeminiService 경로
import com.cooking.star.log.LogService;
import com.cooking.star.mycooking.MyCookingDTO;
import com.cooking.star.mycooking.MyCookingService;

import java.time.LocalTime;
import java.util.List;
import java.util.Map;
@Controller
public class GeminiController {

	@Autowired
    private GeminiService geminiService;
	
	@Autowired
	private GeminiMapper geminiMapper;
	
	@Autowired
	private MyCookingService myCookingService;
	
	
	@Autowired
	private LogService logService;
    @GetMapping("/") //index page
    public String index(Model model) throws Exception {
        //저장된 제미나이 문구를 가져오기
    	String menuDB=geminiMapper.getMenu();
      
    	model.addAttribute("gemini",menuDB);
    	
    	//실시간검색어 메인화면에 뿌리기
    	List<Map<String,Object>> ar = logService.logRanking();
    	model.addAttribute("ranking",ar);
    	
    	List<MyCookingDTO> list=myCookingService.list();
		
		model.addAttribute("myCookingList", list);
    	
    	
    	
        return "index"; 
    }
  
}

