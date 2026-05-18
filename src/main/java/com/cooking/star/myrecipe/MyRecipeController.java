package com.cooking.star.myrecipe;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cooking.star.comment.CommentDTO;
import com.cooking.star.comment.CommentMapper;
import com.cooking.star.good.GoodDTO;
import com.cooking.star.good.GoodService;
import com.cooking.star.member.MemberDTO;
import com.cooking.star.pager.Pager;

@Controller
@RequestMapping("/myrecipe/*")

public class MyRecipeController {

	@Autowired
	private GoodService goodService;
	
	@Autowired
	private MyRecipeService myRecipeService;
	
	@GetMapping("create")
	public void create() throws Exception{}
	
	@Value("${app.myrecipe}")
	private String name;
	
	@ModelAttribute("name")
	public String getName() {
		return this.name;
	}
	
	@Autowired
	private CommentMapper commentMapper;
	
	
	@PostMapping("create")
	public String create(MemberDTO memberDTO,MyRecipeDTO myRecipeDTO,Principal principal,
			@RequestParam(name =  "attach", required = false) MultipartFile[] attach,
			RedirectAttributes redirectAttributes,Model model)throws Exception{
		//MemberDTO memberDTO= new MemberDTO();
		
		if (principal == null) {
	        return "redirect:/member/login";
	    }
		// 🌟 2. [제목 필수 검증] null 체크와 더불어 스페이스바만 친 공백("" 또는 "   ")까지 깐깐하게 컷!
	    if (myRecipeDTO.getRecipeTitle() == null || myRecipeDTO.getRecipeTitle().trim().isEmpty()) {
	        // 일회성 휘발성 데이터로 메시지를 심어서 보냅니다 (새로고침하면 사라짐)
	    	model.addAttribute("dto", myRecipeDTO);
	        model.addAttribute("message", "레시피 제목은 필수 입력 사항입니다.");
	        
	        
	        // 데이터가 날아가지 않게 가던 길을 멈추고 다시 레시피 작성 폼으로 리다이렉트 시킵니다.
	        return "myrecipe/create";
	    }
		
		myRecipeDTO.setUsername(principal.getName());
		int result=myRecipeService.create(myRecipeDTO,attach);
		
		return "redirect:/myrecipe/allList";
	}
	
	@GetMapping("allList")
	public void allList(Pager pager,Model model)throws Exception{
		List<MyRecipeDTO> ar = myRecipeService.allList(pager);
		model.addAttribute("dto", ar);
		
	}
	
	@GetMapping("myList")
	public String myList(Pager pager,Principal principal,Model model) throws Exception{
		if(principal == null) {
			return "redirect:/member/login";
		}
		MyRecipeDTO myRecipeDTO = new MyRecipeDTO();
		myRecipeDTO.setUsername(principal.getName());
		List<MyRecipeDTO> ar = myRecipeService.myList(pager,myRecipeDTO);
		model.addAttribute("dto", ar);
		
		return "myrecipe/myList";
	}
	
	@GetMapping("detail")
	public void detail(MyRecipeDTO myRecipeDTO,Model model,Principal principal)throws Exception{
		myRecipeService.updateHit(myRecipeDTO);
		myRecipeDTO=myRecipeService.detail(myRecipeDTO);
		model.addAttribute("dto",myRecipeDTO);
		
		boolean isGood=false;
		
		if(principal != null) {
			GoodDTO goodDTO = new GoodDTO();
			goodDTO.setRecipeNum(myRecipeDTO.getRecipeNum());
			goodDTO.setUsername(principal.getName());
			
			isGood=goodService.isGood(goodDTO);
			
		}
		List<CommentDTO>comment=commentMapper.getCommentList(myRecipeDTO.getRecipeNum());
		model.addAttribute("comment", comment);
		
		model.addAttribute("isGood", isGood);
		
	}
	@GetMapping("update")
	public String update(MyRecipeDTO myRecipeDTO,Model model,@AuthenticationPrincipal MemberDTO memberDTO)throws Exception{
		myRecipeDTO=myRecipeService.detail(myRecipeDTO);
		
		if(!myRecipeDTO.getUsername().equals(memberDTO.getUsername())) {
	        // 다르면 리스트로 쫓아내거나 에러 메시지 처리
	        return "redirect:/myrecipe/allList"; 
	    }

		
		model.addAttribute("dto",myRecipeDTO);
		
		return "myrecipe/update";
		
	}
	
	@PostMapping("update")
	public String update(@RequestParam(name = "attach", required = false) MultipartFile[] attach,@RequestParam(name = "deleteFiles", required = false) List<Long> deleteFiles,MyRecipeDTO myRecipeDTO,@AuthenticationPrincipal MemberDTO memberDTO)throws Exception{
		MyRecipeDTO checkDTO= myRecipeService.detail(myRecipeDTO);
		
		if(!checkDTO.getUsername().equals(memberDTO.getUsername())) {
	        // 다르면 리스트로 쫓아내기
	        return "redirect:/myrecipe/allList"; 
	    }
		
		int result=myRecipeService.update(myRecipeDTO,attach,deleteFiles);
		return "redirect:/myrecipe/detail?recipeNum="+myRecipeDTO.getRecipeNum();
	}
	
	@PostMapping("delete")
	@ResponseBody
	public int delete(MyRecipeDTO myRecipeDTO,Principal principal) throws Exception{
		
		//로그인이 안되있다면 -1을 js로 전송 -> js에서 -1을 받았다면 로그인화면으로 보냄
		if(principal == null) {
			return -1;
		}
		myRecipeDTO.setUsername(principal.getName());
		
		int result= myRecipeService.delete(myRecipeDTO);
		
		return result;
	}
	
	@PostMapping("comment")
	public String addComment(CommentDTO commentDTO, Principal principal)throws Exception{
		
		if(principal == null) {
			return "redirect:/member/login";
		}
		
		commentDTO.setUsername(principal.getName());
		commentMapper.addComment(commentDTO);
		
		return "redirect:/myrecipe/detail?recipeNum=" + commentDTO.getRecipeNum();
	}
	@PostMapping("commentD")
	public String deleteComment(CommentDTO commentDTO,Principal principal) throws Exception{
		
		if(principal == null) {
			return "redirect:/member/login";
		}
		
		commentDTO.setUsername(principal.getName());
		commentMapper.deleteComment(commentDTO);
		
		return "redirect:/myrecipe/detail?recipeNum="+commentDTO.getRecipeNum();
	}
	
	
}
