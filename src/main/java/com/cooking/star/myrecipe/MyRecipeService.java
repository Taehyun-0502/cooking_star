package com.cooking.star.myrecipe;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class MyRecipeService {

	@Autowired
	private MyRecipeMapper myRecipeMapper;
	
	public int create(MyRecipeDTO myRecipeDTO) throws Exception{
		return myRecipeMapper.create(myRecipeDTO);
	}
	
}
