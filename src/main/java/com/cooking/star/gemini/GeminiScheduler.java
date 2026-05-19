package com.cooking.star.gemini;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import jakarta.annotation.PostConstruct;

@Component
public class GeminiScheduler {

	@Autowired
	private GeminiService geminiService;
	
	@Autowired
	private GeminiMapper geminiMapper;
	
	
	@PostConstruct //처음 서버 시작시 데이터 넣어주기
	public void init() throws Exception {
        updateGemini();
    }
	
	
	@Scheduled(cron = "0 0 6,11,17 * * *")
	public void updateGemini()throws Exception{
		int hour=LocalDateTime.now().getHour();
		String mealTime=(hour < 11) ? "아침" : (hour < 16 ? "점심" : "저녁");
		
		String newMenu = geminiService.menu(mealTime);
		
		GeminiDTO geminiDTO=new GeminiDTO();
		geminiDTO.setGeminiContents(newMenu);
		geminiDTO.setMealTime(mealTime);
		geminiMapper.updateMenu(geminiDTO);
	}
}
