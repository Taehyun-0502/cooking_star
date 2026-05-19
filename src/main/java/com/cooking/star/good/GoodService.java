package com.cooking.star.good;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cooking.star.myrecipe.MyRecipeDTO;

@Service
public class GoodService {
	@Autowired
	private GoodMapper goodMapper;
	
	@Transactional
	public GoodResponseDTO toggleGood(MyRecipeDTO myRecipeDTO, GoodDTO goodDTO,String username)throws Exception {
		
		 boolean isGood;
		
		Long recipeNum=myRecipeDTO.getRecipeNum();
		
		goodDTO.setRecipeNum(recipeNum);
		goodDTO.setUsername(username);
		
		int goodCheck=goodMapper.count(goodDTO);
		
		if(goodCheck == 0) {
			
			goodMapper.good(goodDTO);
			
			goodMapper.goodUp(myRecipeDTO);
			
			isGood=true;
			
			
		}else {
			goodMapper.goodDelete(goodDTO);
			
			goodMapper.goodDown(myRecipeDTO);
			
			isGood=false;
		}
		
		int goodCount=goodMapper.getGoodCount(goodDTO);
		
		GoodResponseDTO goodResponseDTO = new GoodResponseDTO();
		goodResponseDTO.setGood(isGood);
		goodResponseDTO.setGoodCount(goodCount);
		
		return goodResponseDTO;
	}
	

	public boolean isGood(GoodDTO goodDTO)throws Exception{
		int result = goodMapper.count(goodDTO);
		
		return result>0;
		
	}
	
	
	
}
