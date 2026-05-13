package com.cooking.star.gemini;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class GeminiDTO {

	private Long geminiNum;
	private String mealTime;
	private String geminiContents;
	private LocalDateTime updateTime;
}
