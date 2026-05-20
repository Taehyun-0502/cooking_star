package com.cooking.star.visit;

import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class VisitDTO {

	private Long visitNum;
	
	private LocalDate visitDate;
	
	private String sessionId;
	
	
	
}
