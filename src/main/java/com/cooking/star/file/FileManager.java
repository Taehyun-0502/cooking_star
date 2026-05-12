package com.cooking.star.file;

import java.io.File;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;



@Component
public class FileManager {
	
	@Value("${app.upload.base}")
	private String path;

	//파일삭제
	public boolean fileDelete(String name,FileDTO fileDTO)throws Exception{
		File file=new File(path,name);
		file=new File(file,fileDTO.getFileName());
		return file.delete();		
	}
	
	public String fileSave(String name,MultipartFile mf)throws Exception{
		//저장경로는 path 
		File file= new File(path,name);
		//경로에 name로 지정한 폴더가 없으면 생성
		if(!file.exists()) {
			file.mkdir();
		}
		//파일명
		String fileName=UUID.randomUUID().toString();
		//확장자
		fileName=fileName+"_"+mf.getOriginalFilename();
		//저장
		mf.transferTo(file);
		
		return fileName;
		
		
	}
}
