package com.cooking.star.myrecipe;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.cooking.star.pager.Pager;

@Mapper
public interface MyRecipeMapper {
	public Long getCount(Pager pager);
	public int create(MyRecipeDTO myRecipeDTO);
	public List<MyRecipeDTO> list(Pager pager);
	public List<MyRecipeDTO> detail(MyRecipeDTO myRecipeDTO);
	public int addRecipeimg(RecipeFileDTO recipeFileDTO);

}
