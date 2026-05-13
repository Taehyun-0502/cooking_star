package com.cooking.star.gemini;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface GeminiMapper {

	//저장된 제미나이 문구 가져오기
	public String getMenu()throws Exception;
	
	//시간대별로 DB 업데이트하기
	public int updateMenu(GeminiDTO geminiDTO)throws Exception;
	
	
}
