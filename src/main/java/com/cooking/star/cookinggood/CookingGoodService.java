package com.cooking.star.cookinggood;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CookingGoodService {
	
	@Autowired
	private CookingGoodMapper cookingGoodMapper;

	public int count(CookingGoodDTO cookingGoodDTO) throws Exception{
		return cookingGoodMapper.count(cookingGoodDTO);
	}

	@Transactional
	public CookingGoodResponseDTO toggleGood(CookingGoodDTO cookingGoodDTO)throws Exception{
		
		boolean isGood;
		//유저가 좋아요를 눌렀는지 확인
		int check = cookingGoodMapper.count(cookingGoodDTO);
		
		if(check >0) {
			cookingGoodMapper.goodDelete(cookingGoodDTO);
			cookingGoodMapper.goodDown(cookingGoodDTO);
			isGood=false;
			
		}
		else {
			cookingGoodMapper.good(cookingGoodDTO);
			cookingGoodMapper.goodUp(cookingGoodDTO);
			isGood=true;
		}
		int goodCount=cookingGoodMapper.getGoodCount(cookingGoodDTO);
		
		CookingGoodResponseDTO responseDTO=new CookingGoodResponseDTO();
		responseDTO.setGood(isGood);
		responseDTO.setGoodCount(goodCount);
		
		return responseDTO;
	}
}
