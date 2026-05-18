package com.cooking.star.comment;

import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommentDTO {

	private Long commentNum;
	private String username;
	private Long recipeNum;
	private String contents;
	private LocalDate createDate;
	
	
	
}
