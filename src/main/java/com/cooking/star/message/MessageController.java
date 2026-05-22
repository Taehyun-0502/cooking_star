package com.cooking.star.message;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("message")
public class MessageController {

	@Autowired
	private MessageService messageService;

	@Autowired
	private SimpMessagingTemplate messagingTemplate;
	
	@GetMapping("create")
	public void create()throws Exception{
		
	}
	@PostMapping("create")
	@ResponseBody
	public int create(MessageDTO messageDTO , Principal principal)throws Exception{
	
		String loginUsername = principal == null ? null : principal.getName();
		MessageAlarmDTO messageAlarmDTO = messageService.create(messageDTO, loginUsername);
		messagingTemplate.convertAndSend("/topic/admin/messages", messageAlarmDTO);
		
		
		return 1;
		
	}
	@GetMapping("alarm/count")
	@ResponseBody
	public Long alarmCount()throws Exception{
		
		return messageService.noreadCount();
		
	}
	@GetMapping("list")
	public void list (Model model)throws Exception{
		
		List<MessageDTO>ar=messageService.list();
		
		model.addAttribute("list", ar);
		
		
	}
	@GetMapping("detail")
	public void detail(MessageDTO messageDTO,Model model)throws Exception{
		
		messageDTO=messageService.detail(messageDTO);
		
		model.addAttribute("detail", messageDTO);
		
	}
	
	
	
	
	
	
	
	
	
}
