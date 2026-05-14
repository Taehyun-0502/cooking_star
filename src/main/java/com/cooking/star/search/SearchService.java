package com.cooking.star.search;

import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.cooking.star.cart.CartDTO;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class SearchService {

	@Autowired
	private SearchMapper searchMapper;
	
	@Value("${naver.api.id}")
	private String clientId;
	@Value("${naver.secret}")
	private String secret;
	
	public String search(String query)throws Exception {
		URI uri = UriComponentsBuilder
				.fromUriString("https://openapi.naver.com")
				.path("/v1/search/blog.json")
				.queryParam("query",query)
				.queryParam("display", 10)
				.queryParam("start", 1)
				.queryParam("sort", "sim")
				.encode()
				.build()
				.toUri();
		
		HttpHeaders headers = new HttpHeaders();
		headers.set("X-Naver-Client-Id", this.clientId);
		headers.set("X-Naver-Client-Secret", this.secret);
		
		HttpEntity<String> entity = new HttpEntity<>(headers);
		
		RestTemplate restTemplate = new RestTemplate();
		
		ResponseEntity<String> response =restTemplate.
				exchange(uri, HttpMethod.GET, entity, String.class);
		
		return response.getBody();
		
	}
	
	
	//검색한 링크 저장하는 메서드
	public int save(SearchDTO searchDTO)throws Exception{
		
		int result = searchMapper.save(searchDTO);
		
		return result;
		
	}
	
	//자신의 저장한 링크 가져오는 메서드
	public List<SearchDTO>list(SearchDTO searchDTO)throws Exception{
		
		
		return searchMapper.list(searchDTO);
		
		
		
	}
	public int delete(SearchDTO searchDTO)throws Exception{
		int result = searchMapper.delete(searchDTO);
		
		return result;
	}
	
	public List<CartDTO> shopping(String query)throws Exception{
		
		RestTemplate restTemplate = new RestTemplate();
		
		URI uri=UriComponentsBuilder
				.fromUriString("https://openapi.naver.com")
				.path("/v1/search/shop.json")
				.queryParam("query",query)
				.queryParam("display",10)
				.encode(StandardCharsets.UTF_8)
				.build()
				.toUri()
				;
				
		HttpHeaders headers=new HttpHeaders();
		headers.set("X-Naver-Client-Id", clientId);
        headers.set("X-Naver-Client-Secret", secret);
        
        
        HttpEntity<String> entity = new HttpEntity<>(headers);

        // 3. API 호출
        ResponseEntity<String> response = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class);

        // 4. JSON 결과 파싱해서 CartDTO 리스트로 만들기
        ObjectMapper objectMapper = new ObjectMapper(); //java가 json데이터를 읽을수있게해주는 도구
        JsonNode root = objectMapper.readTree(response.getBody());
        JsonNode items = root.path("items");
        
        List<CartDTO> list = new ArrayList<>();
        for (JsonNode node : items) {
            CartDTO dto = new CartDTO();
            // <b> 태그 제거하고 이름 넣기
            dto.setProductName(node.path("title").asText().replaceAll("<(/)?b>", ""));
            dto.setProductPrice(node.path("lprice").asLong());
            dto.setProductImg(node.path("image").asText());
            dto.setProductEa(1L); // 기본 수량 1개 설정
            list.add(dto);
        }
        return list;
	}
    
        
		
	}

