package com.cooking.star.myrecipe;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MyRecipeMapper {
	
	public int create(MyRecipeDTO myRecipeDTO);

}
