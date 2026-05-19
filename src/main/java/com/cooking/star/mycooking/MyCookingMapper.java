package com.cooking.star.mycooking;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.security.access.method.P;

import com.cooking.star.pager.Pager;

@Mapper
public interface MyCookingMapper {

	
	public int create(MyCookingDTO myCookingDTO)throws Exception;
	
	public List<MyCookingDTO>list()throws Exception;
	
	public List<MyCookingDTO>allList(@Param("pager")Pager pager)throws Exception;
	
	public Long getAllCount(@Param("pager")Pager pager)throws Exception;
	
	public int update(MyCookingDTO myCookingDTO)throws Exception;
	
	public int delete(MyCookingDTO myCookingDTO)throws Exception;
	
	public int addFile(MyCookingFIleDTO myCookingFIleDTO) throws Exception;
	
	public MyCookingDTO detail(MyCookingDTO myCookingDTO)throws Exception;
	//조회수 증가
	public int updateHit(MyCookingDTO myCookingDTO)throws Exception;
	
	 public MyCookingFIleDTO fileDetail(Long fileNum) throws Exception;

	   public int deleteFile(@Param("fileNum") Long fileNum) throws Exception;
	
	   public int fileCount(@Param("cookingNum")Long cookingNum)throws Exception;
	   
	   List<MyCookingFIleDTO> fileList(Long cookingNum) throws Exception;

	    int deleteFileAll(Long cookingNum) throws Exception;

	public List<MyCookingDTO>myList(@Param("username")String username,@Param("pager")Pager pager)throws Exception;
	   
	   public Long getCount(String username)throws Exception;
	
}
