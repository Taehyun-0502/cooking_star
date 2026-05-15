package com.cooking.star.myrecipe;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import org.springframework.web.multipart.MultipartFile;

import com.cooking.star.file.FileManager;
import com.cooking.star.mycooking.MyCookingDTO;
import com.cooking.star.pager.Pager;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MyRecipeService {

	@Value("${app.myrecipe}")
	private String name;

	@Autowired
	private MyRecipeMapper myRecipeMapper;

	@Autowired
	private FileManager fileManager;

	

	
	
	
	public int create(MyRecipeDTO myRecipeDTO, MultipartFile attach) throws Exception {

		int result = myRecipeMapper.create(myRecipeDTO);

		if (attach != null && !attach.isEmpty()) {
			String fileName = fileManager.fileSave(name, attach);
			RecipeFileDTO recipeFileDTO = new RecipeFileDTO();
			recipeFileDTO.setFileName(fileName);
			recipeFileDTO.setOriName(attach.getOriginalFilename());

			recipeFileDTO.setRecipeNum(myRecipeDTO.getRecipeNum());
			myRecipeMapper.addRecipeimg(recipeFileDTO);

		}
		return result;
	}
	
	public List<MyRecipeDTO> myList(Pager pager,MyRecipeDTO myRecipeDTO) throws Exception {

		
		pager.makeStartNum();

		pager.makeBlock(myRecipeMapper.getMyCount(pager,myRecipeDTO));
		
		return myRecipeMapper.myList(pager,myRecipeDTO);
	}
	

	public List<MyRecipeDTO> allList(Pager pager) throws Exception {

		pager.makeStartNum();

		pager.makeBlock(myRecipeMapper.getCount(pager));
		return myRecipeMapper.allList(pager);
	}

	public MyRecipeDTO detail(MyRecipeDTO myRecipeDTO)throws Exception{
		return myRecipeMapper.detail(myRecipeDTO);
	}
	
	public int update(MyRecipeDTO myRecipeDTO,MultipartFile attach)throws Exception{
		return myRecipeMapper.update(myRecipeDTO,attach);
	}
	
	public int updateHit(MyRecipeDTO myRecipeDTO)throws Exception{
		
		return myRecipeMapper.updateHit(myRecipeDTO);
	}
	
}
