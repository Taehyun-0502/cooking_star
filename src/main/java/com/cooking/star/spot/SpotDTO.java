package com.cooking.star.spot;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class SpotDTO {

	private Long spotNum;
   private String username;
	private String placeName;
	 private String addressName;
	 private String phone;
	 private String placeUrl;
	 private boolean saved;




}
