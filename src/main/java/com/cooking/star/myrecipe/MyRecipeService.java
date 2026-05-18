package com.cooking.star.myrecipe;

import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
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

	

	
	
	
	public int create(MyRecipeDTO myRecipeDTO, MultipartFile[] attach) throws Exception {

		int result = myRecipeMapper.create(myRecipeDTO);

		if (attach != null && attach.length >0) {
			
			for(MultipartFile attachs: attach) {
				
				if (attachs != null && !attachs.isEmpty()) {
			String fileName = fileManager.fileSave(name, attachs);
			RecipeFileDTO recipeFileDTO = new RecipeFileDTO();
			recipeFileDTO.setFileName(fileName);
			recipeFileDTO.setOriName(attachs.getOriginalFilename());

			recipeFileDTO.setRecipeNum(myRecipeDTO.getRecipeNum());
			myRecipeMapper.addRecipeimg(recipeFileDTO);
				}
		}
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
	
	public int update(MyRecipeDTO myRecipeDTO,MultipartFile[] attach,List<Long> deleteFiles)throws Exception{
		
		//기존파일에서 x버튼누를시 db에서 파일삭제
		if(deleteFiles !=null && !deleteFiles.isEmpty()) {
			myRecipeMapper.deleteFiles(deleteFiles);
		}
		//로컬에서도 삭제
		if(deleteFiles != null && !deleteFiles.isEmpty()) {
		    // 1. deleteFiles(파일번호 리스트)를 가지고 DB에서 기존 파일명(fileName)들을 먼저 SELECT해옵니다.
		    // 2. 반복문을 돌며 fileManager.fileDelete("myrecipe", 꺼내온FileDTO)를 실행해 실물 파일을 지웁니다.
		    
		    // 3. 그 후 기존에 작성하신 DB 삭제 쿼리를 실행합니다.
		    myRecipeMapper.deleteFiles(deleteFiles);
		}
		//업데이트시 파일이 새로 넘어왔다면
		if(attach !=null && attach.length >0) {
			
			for(MultipartFile file : attach) {
				if(file !=null && !file.isEmpty()) {
					//로컬에 파일 저장
					String name =fileManager.fileSave("myrecipe", file);
					
					RecipeFileDTO recipeFileDTO = new RecipeFileDTO();
	                recipeFileDTO.setRecipeNum(myRecipeDTO.getRecipeNum());
	                recipeFileDTO.setFileName(name);
	                recipeFileDTO.setOriName(file.getOriginalFilename());
	                
	                //db에도 인서트
	                myRecipeMapper.addRecipeimg(recipeFileDTO);
				}
			}
		}
		
		return myRecipeMapper.update(myRecipeDTO);
	}
	
	public int updateHit(MyRecipeDTO myRecipeDTO)throws Exception{
		
		return myRecipeMapper.updateHit(myRecipeDTO);
	}
	
	@Transactional
	public int delete(MyRecipeDTO myRecipeDTO)throws Exception{
		
		//글정보와 파일정보 조회
		MyRecipeDTO detail = myRecipeMapper.detail(myRecipeDTO);
		
		// DB에 저장된 파일이 CASCADE로 날아가기 전에 FileDTO 객체를 자바 변수에 따로 안전하게 복사해둡니다.
	   List<RecipeFileDTO> targetFile = null;
	    if (detail != null && detail.getRecipeFileDTO() != null) {
	        targetFile = detail.getRecipeFileDTO();
	    }
	    
		//db의 recipefile테이블에서 포링키 케스케이드설정하면 db에서 파일정보도 같이지워짐
		int result=myRecipeMapper.delete(myRecipeDTO);
		
		for (RecipeFileDTO fileDTO : targetFile) {
		
		 //DB 삭제가 성공했고, 아까 따로 빼둔 파일 정보(targetFile)가 존재한다면 로컬에서 파일 삭제
			if (fileDTO != null && fileDTO.getFileName() != null && !fileDTO.getFileName().isEmpty()) {
	        
	    
	        fileManager.fileDelete("myrecipe",fileDTO);
	     
		}
		}
	    return result;
	}
	
}
