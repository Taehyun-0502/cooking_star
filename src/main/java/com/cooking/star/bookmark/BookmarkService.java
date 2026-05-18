package com.cooking.star.bookmark;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import com.cooking.star.myrecipe.MyRecipeDTO;
import com.cooking.star.myrecipe.MyRecipeService;

@Service
public class BookmarkService {

	@Autowired
	private BookmarkMapper bookmarkMapper;
	@Autowired
	private MyRecipeService myRecipeService;
	
	public int addBookmark(BookmarkDTO bookmarkDTO)throws Exception {
		
		MyRecipeDTO myRecipeDTO = new MyRecipeDTO();
		
		myRecipeDTO.setRecipeNum(bookmarkDTO.getRecipeNum());
		
		myRecipeDTO=myRecipeService.detail(myRecipeDTO);
		
		if(myRecipeDTO.getUsername().equals(bookmarkDTO.getUsername()))	{
		
			return 0;
		}
		
		
		if(bookmarkMapper.bookmarkCheck(bookmarkDTO)>0) {
			return 0;
		}
		
		try {
			return bookmarkMapper.addBookmark( bookmarkDTO);
		} catch (DuplicateKeyException e) {
			return 0;
		}
	}

	public int bookCount(BookmarkDTO bookmarkDTO) throws Exception {
		
		return bookmarkMapper.bookmarkCount(bookmarkDTO);
	}

	public List<BookmarkDTO>list (BookmarkDTO bookmarkDTO)throws Exception{
		
		return bookmarkMapper.list(bookmarkDTO);
	}
	
	public int bookmarkCheck(BookmarkDTO bookmarkDTO)throws Exception{
		
		return bookmarkMapper.bookmarkCheck(bookmarkDTO);
	}
	
	public int deleteBookmark(BookmarkDTO bookmarkDTO)throws Exception{
		
		return bookmarkMapper.deleteBookmark(bookmarkDTO);
	}
	

}
