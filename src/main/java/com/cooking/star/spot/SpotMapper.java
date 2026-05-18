package com.cooking.star.spot;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface SpotMapper {

	
	public int add(SpotDTO spotDTO)throws Exception;
	
	
	public List<SpotDTO>myList(@Param("username") String username)throws Exception;
	
	public int delete(SpotDTO spotDTO)throws Exception;
	
}
