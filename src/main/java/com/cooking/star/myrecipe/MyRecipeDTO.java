package com.cooking.star.myrecipe;

import java.time.LocalDate;

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
	private Long recipeGood;
	private Long recipeHit;
	private LocalDate recipeDate;
	
}
