package com.cooking.star.search;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SearchMapper {

	public int save(SearchDTO searchDTO)throws Exception;
	
	public List<SearchDTO>list(SearchDTO searchDTO)throws Exception;
	
	public int delete(SearchDTO searchDTO)throws Exception;
	
	
	
}
