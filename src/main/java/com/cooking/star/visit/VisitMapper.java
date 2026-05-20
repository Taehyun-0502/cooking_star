package com.cooking.star.visit;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface VisitMapper {

	public int todayVisit(VisitDTO visitDTO)throws Exception;
	
	public Long getTodayVisitCount()throws Exception;
	
	public Long getTotalMemberCount()throws Exception;
	
	
}
