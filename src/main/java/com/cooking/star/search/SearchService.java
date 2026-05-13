package com.cooking.star.search;

import java.net.URI;
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
	
	
}
