package com.cooking.star.mycooking;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.cooking.star.file.FileManager;
import com.cooking.star.pager.Pager;

@Service
public class MyCookingService {

	@Autowired
	private MyCookingMapper myCookingMapper;
	@Autowired
	private FileManager fileManager;
	
	@Value("${app.mycooking}")
	private String name;
	
	public List<MyCookingDTO>myList(String username,Pager pager)throws Exception{
		
		pager.makeBlock(myCookingMapper.getCount(username));
		pager.makeStartNum();
		
		
		
		
		
		return myCookingMapper.myList(username,pager);
	}
	
	
	
	public int delete(MyCookingDTO cookingDTO)throws Exception{
		
		 List<MyCookingFIleDTO> fileList =
		            myCookingMapper.fileList(cookingDTO.getCookingNum());
		
		myCookingMapper.deleteFileAll(cookingDTO.getCookingNum());
		
		int result = myCookingMapper.delete(cookingDTO);
		
		
		if (result > 0 && fileList != null && !fileList.isEmpty()) {
		        for (MyCookingFIleDTO fileDTO : fileList) {
		            fileManager.fileDelete(name, fileDTO);
		        }
		    }
		
		
		
	 return	result;
		
		
			}
	
	
	
	public int update( MyCookingDTO myCookingDTO, MultipartFile[] attach,  List<Long> deleteFileNums)throws Exception{
		 // 1. 이미지 개수 검증
		//한 글의 최대 이미지 갯수
	    int maxFileCount = 5;

	    //업데이트할 글의 현재 파일 갯수
	    int existingFileCount = myCookingMapper.fileCount(myCookingDTO.getCookingNum());


	    //기존에 있던 이미지를 삭제할 갯수
	    int deleteFileCount = 0;
	    if (deleteFileNums != null) {
	        deleteFileCount = deleteFileNums.size();
	    }

	    //추가할 파일의 갯수를 담을 변수
	    int newFileCount = 0;
	    if (attach != null) {
	        for (MultipartFile multipartFile : attach) {
	            if (multipartFile != null && !multipartFile.isEmpty()) {
	                newFileCount++;
	            }
	        }
	    }

	    //최종 이미지 갯수 =현재 글 이미지 갯수- 삭제할 이미지 + 추가할 이미지 갯수 
	    int finalFileCount = existingFileCount - deleteFileCount + newFileCount;

	    //최종 이미지 갯수가 앞서 선언한 max=5 의 갯수를 넘을때 예외 발생
	    if (finalFileCount > maxFileCount) {
	        throw new IllegalArgumentException("이미지는 최대 5장까지만 등록할 수 있습니다.");
	    }
		
		
		
		//글 업데이트
		int result = myCookingMapper.update(myCookingDTO);

		 
		 
		    // 2. 기존 파일 삭제
		    if (deleteFileNums != null && !deleteFileNums.isEmpty()) {

		        for (Long fileNum : deleteFileNums) {

		            // 삭제할 파일 정보 조회
		            MyCookingFIleDTO fileDTO = myCookingMapper.fileDetail(fileNum);

		            if (fileDTO == null) {
		                continue;
		            }
		            	
		            // DB에서 파일 정보 삭제// DB에서 파일 정보 삭제
		            int deleteResult = myCookingMapper.deleteFile(fileNum);

		         // DB 삭제가 성공했을 때 실제 파일 삭제
		         if (deleteResult > 0) {
		             fileManager.fileDelete(name, fileDTO);
		         }
		            
		        }
		    }

		    // 3. 새 파일 추가
		    if (attach != null && attach.length > 0) {

		        for (MultipartFile multipartFile : attach) {

		            if (multipartFile == null || multipartFile.isEmpty()) {
		                continue;
		            }

		            // 파일 저장
		            String fileName = fileManager.fileSave(name, multipartFile);

		            // 파일 DB 저장용 DTO 생성
		            MyCookingFIleDTO myCookingFileDTO = new MyCookingFIleDTO();

		            myCookingFileDTO.setCookingNum(myCookingDTO.getCookingNum());
		            myCookingFileDTO.setOriName(multipartFile.getOriginalFilename());
		            myCookingFileDTO.setFileName(fileName);

		            // 파일 정보 DB insert
		            myCookingMapper.addFile(myCookingFileDTO);
		        }
		    }

		    return result;
		    
	}
	
	
	
	
	
	
	
	
	
	public MyCookingDTO detail(MyCookingDTO myCookingDTO)throws Exception{
		
		return myCookingMapper.detail(myCookingDTO);
	}
	
	
	
	
	public List<MyCookingDTO> list()throws Exception{
		
		return myCookingMapper.list();
		
	}	
	
	
	
	
	public int create(MyCookingDTO myCookingDTO,MultipartFile [] attach)throws Exception {
		
		
		boolean hasFile=false;
		
		if(attach != null) {
			for(MultipartFile multipartFile : attach) {
				
				if(multipartFile != null && !multipartFile.isEmpty()) {
					
					hasFile=true;
					break;
					
				}
				
			}
			
		}
		if(!hasFile) {
			throw new IllegalArgumentException("사진은 최소 1장 이상 등록해야 합니다.");
	    
		}
		
		
		
		
		
		int result = myCookingMapper.create(myCookingDTO);
		
		if(attach == null) {
			
			return result;
		}
		for(MultipartFile f : attach) {
			
			if(f.isEmpty() || f == null) {
				continue;
			}
			
			String fileName=fileManager.fileSave(name, f);
			
			MyCookingFIleDTO myCookingFIleDTO = new MyCookingFIleDTO();
			myCookingFIleDTO.setCookingNum(myCookingDTO.getCookingNum());
			myCookingFIleDTO.setOriName(f.getOriginalFilename());
			myCookingFIleDTO.setFileName(fileName);
			
			result= myCookingMapper.addFile(myCookingFIleDTO);
			
		}
		
		return result;
		
		
	
	}
	
	
	
}
