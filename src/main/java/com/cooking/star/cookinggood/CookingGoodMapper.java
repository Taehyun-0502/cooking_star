package com.cooking.star.cookinggood;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CookingGoodMapper {
	
	// 이미 좋아요를 누른 상태인지 확인 (1이면 누름, 0이면 안 누름)
	public int count(CookingGoodDTO cookingGoodDTO) throws Exception;

	// 좋아요 등록 (하트 채우기)
	public int good(CookingGoodDTO cookingGoodDTO) throws Exception;

	// 좋아요 취소 (하트 비우기)
	public int goodDelete(CookingGoodDTO cookingGoodDTO) throws Exception;
	
	public int goodUp(CookingGoodDTO cookingGoodDTO)throws Exception;
	
	public int goodDown(CookingGoodDTO cookingGoodDTO)throws Exception;
	
	public int getGoodCount(CookingGoodDTO cookingGoodDTO) throws Exception;
}