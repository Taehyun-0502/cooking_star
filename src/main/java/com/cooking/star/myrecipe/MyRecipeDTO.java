package com.cooking.star.myrecipe;

import java.time.LocalDate;
import java.util.List;

import com.cooking.star.pager.Pager;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
@Setter
@Getter
@ToString
public class MyRecipeDTO {

	private Long recipeNum;
	private String username;
	private String recipeTitle;
	private String recipeContents;
	private Long recipeGoodCount;
	private Long recipeHit;
	private LocalDate recipeDate;
	private List<RecipeFileDTO> recipeFileDTO;
	private Pager pager;
}
