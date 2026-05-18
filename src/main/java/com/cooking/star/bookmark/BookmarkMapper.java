package com.cooking.star.bookmark;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BookmarkMapper {

	public int addBookmark(BookmarkDTO bookmarkDTO)throws Exception;
	
	public int bookmarkCount(BookmarkDTO bookmarkDTO)throws Exception;
	
	public List<BookmarkDTO>list (BookmarkDTO bookmarkDTO)throws Exception;
	
	public int bookmarkCheck(BookmarkDTO bookmarkDTO)throws Exception;
	
	public int deleteBookmark(BookmarkDTO bookmarkDTO)throws Exception;
	
	
}
