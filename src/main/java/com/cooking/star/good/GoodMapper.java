package com.cooking.star.good;

import org.apache.ibatis.annotations.Mapper;

import com.cooking.star.myrecipe.MyRecipeDTO;

@Mapper
public interface GoodMapper {

	public int count(GoodDTO goodDTO)throws Exception;
	
	public int good(GoodDTO goodDTO)throws Exception;
	
	public int goodDelete(GoodDTO goodDTO)throws Exception;
	
	public int goodUp(MyRecipeDTO myRecipeDTO)throws Exception;
	
	public int goodDown(MyRecipeDTO myRecipeDTO)throws Exception;
	
	public int getGoodCount(GoodDTO goodDTO)throws Exception;
	
}
