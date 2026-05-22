package com.cooking.star.message;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MessageMapper {

	public int create(MessageDTO messageDTO)throws Exception;
	
	public List<MessageDTO>list () throws Exception; 
	
	public MessageDTO detail(MessageDTO messageDTO)throws Exception;
	
	public int updateRead(MessageDTO messageDTO)throws Exception;
	
	public Long noreadCount()throws Exception;
	
	
	
}
