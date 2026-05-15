package com.cooking.star.search;

import java.security.Principal;
import java.util.List;

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

import com.cooking.star.log.LogDTO;
import com.cooking.star.log.LogService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/search/*")
@Slf4j
public class SearchController {
	
	@Value("${app.myrecipe}")
	private String name;
	

	@Autowired
	private SearchService searchService;
	
	@Autowired
	private LogService logService;
	
	@GetMapping("result")
	public String resultPage(@RequestParam(name="query") String query,Principal principal,Model model) throws Exception{
		
		//log db에 관련된 코드
		//검색어 저장
		LogDTO logDTO= new LogDTO();
		
		
		logDTO.setLogTitle(query);
		
		//로그인 유무 확인해서 유저네임저장
		if(principal != null) {
			logDTO.setUsername(principal.getName());
		}
		
		logService.insertLog(logDTO);
		
		
		
		model.addAttribute("searchQuery", query);
		
		
		return "search/blog";
	}
	
	@PostMapping("blog")
	@ResponseBody
	public String search(@RequestParam(name="query") String query)throws Exception{
		String result =searchService.search(query);
		
		
		return result;	
	}
	@PostMapping("save")
	@ResponseBody
	public int save(SearchDTO searchDTO,Principal principal )throws Exception {
		String username=principal.getName();
		searchDTO.setUsername(username);
		
		int result =searchService.save(searchDTO);
	
		return result;
	}
	@GetMapping("list")
	public void list(SearchDTO searchDTO, Principal principal,Model model)throws Exception{
		
		String username= principal.getName();
		searchDTO.setUsername(username);
		List<SearchDTO> ar=searchService.list(searchDTO);
		
		model.addAttribute("list",ar);
		
	}
	@PostMapping("delete")
	@ResponseBody
	public int delete(SearchDTO searchDTO,Principal principal)throws Exception{
		String username = principal.getName();
		
		searchDTO.setUsername(username);
		
		int result=searchService.delete(searchDTO);
		
		return result;
		
	}
	
	
}
