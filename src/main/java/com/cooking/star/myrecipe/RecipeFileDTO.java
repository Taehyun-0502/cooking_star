package com.cooking.star.myrecipe;

import com.cooking.star.file.FileDTO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RecipeFileDTO extends FileDTO{

	private Long recipeNum;
}
