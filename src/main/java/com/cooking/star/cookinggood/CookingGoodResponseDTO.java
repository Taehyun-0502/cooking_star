package com.cooking.star.cookinggood;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CookingGoodResponseDTO {

	private boolean isGood; // true: 하트 채우기, false: 하트 비우기
	private int goodCount; // 총 좋아요 개수
}
