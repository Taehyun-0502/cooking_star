package com.cooking.star.spot;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SpotMapper {

	
	public int add(SpotDTO spotDTO)throws Exception;
	
}
