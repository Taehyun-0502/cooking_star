package com.cooking.star.myrecipe;

import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.cooking.star.comment.CommentMapper;
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

	public int deleteByManager(MyRecipeDTO myRecipeDTO)throws Exception {
		
	
		return myRecipeMapper.deleteByManager(myRecipeDTO);
	
	}
	

	
	
	
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

		Long totalCount=myRecipeMapper.getMyCount(pager, myRecipeDTO);
		if (totalCount == null || totalCount == 0) {
			// Pager 객체 내부에 전체 개수를 0으로 명시해주어 1페이지까지만 나오도록 방어막을 칩니다.
			// (만약 pager에 setTotalCount 메서드가 있다면 세팅해주셔도 좋습니다.)
			totalCount = 0L;
		}
		if (totalCount == 0) {
			// 만약 Pager 클래스 내부에 총 개수나 페이지 정보를 넣는 메서드가 있다면 강제로 0을 주입합니다.
			// 예: pager.setTotalCount(0); 
			
			// 💡 makeBlock 내부 로직을 타지 않게 하거나, 확실하게 0을 던져줍니다.
			pager.makeBlock(0L); 
			pager.makeStartNum();
			
			// 계산이 끝난 후 강제로 시작/끝 블록 번호를 1로 고정시켜버립니다.
			// (Pager 내부 변수명이 다를 수 있으니 만약 에러가 나면 주석 처리하세요)
			// pager.setStartNum(1);
			// pager.setLastNum(1);
		} else {
			// 글이 존재할 때만 정상적으로 계산을 태웁니다.
			pager.makeBlock(totalCount);
			pager.makeStartNum();
		}
		
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
		
		//기존파일에서 x버튼누를시 db에서 파일삭제 로컬에서도 삭제
		if(deleteFiles != null && !deleteFiles.isEmpty()) {
			
		    // 1. deleteFiles(파일번호 리스트)를 가지고 DB에서 기존 파일명(fileName)들을 먼저 SELECT
			List<RecipeFileDTO> ar=myRecipeMapper.fileList(deleteFiles);
		    // 2. 반복문을 돌며 fileManager.fileDelete("myrecipe", 꺼내온FileDTO)를 실행해 실물 파일을 지웁니다.
			if(ar!=null) {
				for(RecipeFileDTO files:ar) {
					fileManager.fileDelete(name, files);
				}
			}
		    
		    // 3. 그 후 기존에 작성하신 DB 삭제 쿼리를 실행합니다.
		    myRecipeMapper.deleteFiles(deleteFiles);
		}
		//업데이트시 파일이 새로 넘어왔다면
		if(attach !=null && attach.length >0) {
			
			for(MultipartFile file : attach) {
				if(file !=null && !file.isEmpty()) {
					//로컬에 파일 저장
					String savename =fileManager.fileSave("myrecipe", file);
					
					RecipeFileDTO recipeFileDTO = new RecipeFileDTO();
	                recipeFileDTO.setRecipeNum(myRecipeDTO.getRecipeNum());
	                recipeFileDTO.setFileName(savename);
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
