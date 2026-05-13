package com.cooking.star.gemini;



import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class GeminiService {


	    @Value("${gemini.api.key}")
	    private String geminiKey;
	    
	    // 1. 주소는 가장 표준적인 1.5-flash로 설정 (latest를 빼보세요)
	    private final String API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent";
	    
	    public String menu(String mealTime) {
	        RestTemplate restTemplate = new RestTemplate();
	        
	        HttpHeaders headers = new HttpHeaders();
	        headers.setContentType(MediaType.APPLICATION_JSON);

	        String prompt ="한국인에게 어울리는 " + mealTime + " 메뉴를 하나만 추천해줘. "
	                + "다른 인사나 설명은 절대 하지 말고, "
	                + "반드시 '오늘 " + mealTime + " 메뉴로 [메뉴명]은 어떨까요?' 이 형식으로 딱 한 문장만 대답해.";
	        
	        Map<String, Object> requestBody = Map.of(
	            "contents", List.of(
	                Map.of("parts", List.of(Map.of("text", prompt)))
	            )
	        );

	        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);

	        try {
	            // 2. 키가 정상적으로 로드되었는지 체크
	            if (geminiKey == null || geminiKey.isEmpty()) {
	                return "에러: API 키가 로드되지 않았습니다. application.properties를 확인하세요.";
	            }

	            String fullUrl = API_URL + "?key=" + geminiKey;
	            
	            ResponseEntity<Map> responseEntity = restTemplate.exchange(fullUrl, HttpMethod.POST, entity, Map.class);
	            Map<String, Object> response = responseEntity.getBody();

	            List<Map<String, Object>> candidates = (List<Map<String, Object>>) response.get("candidates");
	            Map<String, Object> content = (Map<String, Object>) candidates.get(0).get("content");
	            List<Map<String, Object>> parts = (List<Map<String, Object>>) content.get("parts");
	            
	            return (String) parts.get(0).get("text");

	        } catch (org.springframework.web.client.HttpClientErrorException e) {
	            // 3. 구글 서버가 보내는 진짜 에러 메시지를 화면에 찍어줍니다.
	            e.printStackTrace();
	            return "구글 서버 에러: " + e.getResponseBodyAsString(); 
	        } catch (Exception e) {
	            e.printStackTrace();
	            return "기타 오류 발생: " + e.getMessage();
	        }
	    }
	   
}
	