package com.cooking.star.spot;

import java.net.URI;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
public class SpotService {

	@Value("${kakao.api.key}")
	private String kakaoApiKey;
	
	@Autowired
	private SpotMapper spotMapper;
	
	public List<SpotDTO> search(String query)throws Exception{
		
		
		String url="https://dapi.kakao.com/v2/local/search/keyword.json";
		
		URI uri=UriComponentsBuilder
				.fromHttpUrl(url)
				.queryParam("query", query)
				.queryParam("category_group_code", "FD6")
				.queryParam("size", 10)
				.build()
				.encode()
				.toUri();
		HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "KakaoAK " + kakaoApiKey);
		
        HttpEntity<String> entity = new HttpEntity<>(headers);
        RestTemplate restTemplate = new RestTemplate();

        ResponseEntity<Map> response = restTemplate.exchange(
                uri,
                HttpMethod.GET,
                entity,
                Map.class
        );

        Map<String, Object> body = response.getBody();

        List<Map<String, Object>> documents =
                (List<Map<String, Object>>) body.get("documents");

        List<SpotDTO> result = new ArrayList<>();

        if (documents == null) {
            return result;
        }

        for (Map<String, Object> doc : documents) {
            SpotDTO dto = new SpotDTO();

            dto.setPlaceName((String) doc.get("place_name"));
            
            dto.setAddressName((String) doc.get("address_name"));
            
            dto.setPhone((String) doc.get("phone"));
            
            dto.setPlaceUrl((String) doc.get("place_url"));

            result.add(dto);
        }

        return result;
    }

	public int add(SpotDTO spotDTO)throws Exception {
		
		return spotMapper.add(spotDTO);
		
	}
	
	
        
		
		
	}
	
	
	
	
	
	
	
	
	

