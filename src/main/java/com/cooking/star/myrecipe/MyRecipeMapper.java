package com.cooking.star.myrecipe;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.cooking.star.pager.Pager;

@Mapper
public interface MyRecipeMapper {
	public Long getCount(@Param("pager")Pager pager)throws Exception;
	public Long getMyCount(@Param("pager")Pager pager,@Param("dto") MyRecipeDTO myRecipeDTO)throws Exception;
	public int create(MyRecipeDTO myRecipeDTO)throws Exception;
	public List<MyRecipeDTO> allList(@Param("pager")Pager pager)throws Exception;
	public MyRecipeDTO detail(MyRecipeDTO myRecipeDTO)throws Exception;
	//마이레시피 작성 or 수정시 이미지추가 메서드
	public int addRecipeimg(RecipeFileDTO recipeFileDTO)throws Exception;
	public int update(@Param("dto") MyRecipeDTO myRecipeDTO )throws Exception;
	//마이레시피 수정시 기존이미지 삭제 메서드 DB
	public int deleteFiles(@Param("deleteFiles") List<Long> deleteFiles) throws Exception;
	//마이레시피 수정시 하드디스크에서 기존이미지 삭제 하기위한 조회 
	public List<RecipeFileDTO> fileList(@Param("deleteFiles") List<Long> deleteFiles) throws Exception;
	
	public List<MyRecipeDTO> myList(@Param("pager") Pager pager,@Param("dto") MyRecipeDTO myRecipeDTO)throws Exception;
	public int delete(MyRecipeDTO myRecipeDTO)throws Exception;
	
	//디테일 조회시 조회수 증가 메서드
	public int updateHit(MyRecipeDTO myRecipeDTO) throws Exception;
	
	public int deleteByManager(MyRecipeDTO myRecipeDTO)throws Exception;
}
