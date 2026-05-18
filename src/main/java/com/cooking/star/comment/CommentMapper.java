package com.cooking.star.comment;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommentMapper {

	
	public List<CommentDTO>getCommentList(@Param("recipeNum") Long recipeNum)throws Exception;
	
	int addComment(CommentDTO commentDTO) throws Exception;

	int deleteComment(CommentDTO commentDTO) throws Exception;
	
	
	
	
}
