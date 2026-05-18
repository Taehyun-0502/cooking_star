package com.cooking.star.mycooking;

import java.security.Principal;
import java.util.List;

import com.cooking.star.cookinggood.CookingGoodDTO;
import com.cooking.star.cookinggood.CookingGoodService;
import com.cooking.star.pager.Pager;
import com.cooking.star.security.AddLogout;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/mycooking/*")
public class MyCookingController {

    

	@Autowired
	private MyCookingService myCookingService;
	
	@Autowired
	private CookingGoodService cookingGoodService;

	@Value("${app.mycooking}")
	private String name;
	@ModelAttribute("name")
	public String getName() {
		
		return this.name;
	}
	@GetMapping("myList")
	public void myList(Principal principal,Model model,Pager pager)throws Exception{
		String username=principal.getName();
		List<MyCookingDTO>ar=myCookingService.myList(username,pager);
		model.addAttribute("myList", ar);
		
	}
	
	
	
	
	
	@GetMapping("create")
	public void create()throws Exception {
		
		
	}
	@PostMapping("create")
	public String create(MyCookingDTO myCookingDTO,Principal principal,@RequestParam(name="attach",required = false) MultipartFile[] attach,RedirectAttributes redirectAttributes)throws Exception{
		String username=principal.getName();
		myCookingDTO.setUsername(username);
		
		try {
	        myCookingService.create(myCookingDTO, attach);
	    } catch (IllegalArgumentException e) {
	        redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
	        redirectAttributes.addFlashAttribute("dto", myCookingDTO);

	        return "redirect:./create";
	    }
		
		return "redirect:/";
		
	}
	//인덱스에 뿌려 주기 때문에 다른 곳에서 요청을 처리함
//	@GetMapping("list")
//	public void list (Model model)throws Exception{
//		
//		List<MyCookingDTO> ar=myCookingService.list();
//		
//		model.addAttribute("list", ar);
//	}
//	
	@GetMapping("detail")
	public void detail (MyCookingDTO myCookingDTO,Model model,Principal principal,CookingGoodDTO cookingGoodDTO)throws Exception{
		
		myCookingDTO=myCookingService.detail(myCookingDTO);
		model.addAttribute("dto", myCookingDTO);
		
		boolean isGood = false;
	    if (principal != null) { // 로그인한 유저가 있다면
	        cookingGoodDTO.setUsername(principal.getName());
	        // 아까 서비스에 만들어둔 count 메서드로 이미 눌렀는지 확인 (1이면 true)
	        isGood = cookingGoodService.count(cookingGoodDTO) > 0; 
	    }
	    
	    // 🔥 중요: JSP의 ${isGood}과 이름을 똑같이 맞춰서 던집니다!
	    model.addAttribute("isGood", isGood);
	
	}
	 @GetMapping("update")
	    public String update(
	            MyCookingDTO myCookingDTO,
	            Model model,
	            Principal principal
	    ) throws Exception {

	        // 로그인한 사용자 정보 세팅
	        myCookingDTO.setUsername(principal.getName());

	        // 기존 글 정보 조회
	        MyCookingDTO dto = myCookingService.detail(myCookingDTO);

	        model.addAttribute("dto", dto);
	        model.addAttribute("name", "mycooking");

	        return "mycooking/update";
	    }
	 	@PostMapping("update")
	    public String update(MyCookingDTO myCookingDTO,   @RequestParam(name = "attach", required = false) MultipartFile[] attach,  @RequestParam(name = "deleteFileNums", required = false) List<Long> deleteFileNums,
	            Principal principal,RedirectAttributes redirectAttributes) throws Exception {

	        // 수정 권한 확인용 username 세팅
	        myCookingDTO.setUsername(principal.getName());

	        try {
	            myCookingService.update(myCookingDTO, attach, deleteFileNums);
	        } catch (IllegalArgumentException e) {

	            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());

	            return "redirect:./update?cookingNum=" + myCookingDTO.getCookingNum();
	        }
	        return "redirect:./detail?cookingNum=" + myCookingDTO.getCookingNum();
	    }
	
@PostMapping("delete")
public String delete(MyCookingDTO myCookingDTO,Principal principal)throws Exception{
	
	myCookingDTO.setUsername(principal.getName());
	
	myCookingService.delete(myCookingDTO);
	
	return "redirect:/";
	
}
	 

	 	
	 	
	 	
	 	
	 	
	 	
	 	
	 	
	 	
	 	
	 	
}
	
	
	
	

