package com.cooking.star.message;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MessageService {
	
	@Autowired
	private MessageMapper messageMapper;
	
	
	
	
	public MessageAlarmDTO create(MessageDTO messageDTO, String loginUsername) throws Exception {
		if (loginUsername != null && !loginUsername.isBlank()) {
			messageDTO.setWriterType("MEMBER");
			messageDTO.setUsername(loginUsername);
			messageDTO.setGuestName("");
			messageDTO.setGuestEmail("");
		} else {
			messageDTO.setWriterType("GUEST");
			messageDTO.setUsername("");
		}

		messageDTO.setReadYn("N");

		MessageAlarmDTO messageAlarmDTO = new MessageAlarmDTO();
	
		messageMapper.create(messageDTO);
		
		String writerName;
		if ("MEMBER".equals(messageDTO.getWriterType())) {
			writerName = messageDTO.getUsername();
		} else {
			writerName = messageDTO.getGuestName();
		}
	
		String preview = messageDTO.getContents();
	
		if (preview != null && preview.length() > 40) {
			preview = preview.substring(0, 40) + "...";
		}
		String now = LocalDateTime.now()
				.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	
		messageAlarmDTO.setMessageNum(messageDTO.getMessageNum());
		messageAlarmDTO.setWriterType(messageDTO.getWriterType());
		messageAlarmDTO.setWriterName(writerName);
		messageAlarmDTO.setMessageType(messageDTO.getMessageType());
		messageAlarmDTO.setTitle(messageDTO.getTitle());
		messageAlarmDTO.setContentPreview(preview);
		messageAlarmDTO.setCreatedAt(now);
		messageAlarmDTO.setUnreadCount(messageMapper.noreadCount());
	  
	  
		return messageAlarmDTO;
	
	}
	
	public List<MessageDTO>list () throws Exception{
		
		return messageMapper.list();
	} 
	
	@Transactional
	public MessageDTO detail(MessageDTO messageDTO)throws Exception{
		messageMapper.updateRead(messageDTO);
		
		return messageMapper.detail(messageDTO);
	}
	
//	public int updateRead(MessageDTO messageDTO)throws Exception{
//		
//		return messageMapper.updateRead(messageDTO);
//	}
	
	public Long noreadCount()throws Exception{
		
		return messageMapper.noreadCount();
	}
	
	
	
	
	
}
