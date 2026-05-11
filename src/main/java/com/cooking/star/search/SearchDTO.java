package com.cooking.star.search;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SearchDTO {

	private Long searachNum;
	private String searchTitle;
	private String searchContents;
	private String username;
}
