package com.cooking.star.myrecipe;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import org.springframework.web.multipart.MultipartFile;

import com.cooking.star.file.FileManager;
import com.cooking.star.pager.Pager;
@Service
public class MyRecipeService {
	
	@Value("${app.myrecipe}")
	private String name;

	@Autowired
	private MyRecipeMapper myRecipeMapper;
	
	@Autowired
	private FileManager fileManager;
	
	
	
	public int create(MyRecipeDTO myRecipeDTO,MultipartFile attach) throws Exception{
		
		
		int result=myRecipeMapper.create(myRecipeDTO);
		if(attach !=null && !attach.isEmpty()) {
			String fileName=fileManager.fileSave(name, attach);
			
			RecipeFileDTO recipeFileDTO=new RecipeFileDTO();
			recipeFileDTO.setFileName(fileName);
			recipeFileDTO.setOriName(attach.getOriginalFilename());
			recipeFileDTO.setRecipeNum(myRecipeDTO.getRecipeNum());
			result=myRecipeMapper.addRecipeimg(recipeFileDTO);
			
		}
		return result;
	}
	public List<MyRecipeDTO> list(Pager pager) throws Exception{
		
		pager.makeStartNum();
		
		pager.makeBlock(myRecipeMapper.getCount(pager));
		return myRecipeMapper.list(pager);
	}
	
}
