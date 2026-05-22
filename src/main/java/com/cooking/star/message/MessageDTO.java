package com.cooking.star.message;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MessageDTO {

	private Long messageNum;
	private String writerType;
	private String username;
	private String guestName;
	private String guestEmail;
	private String messageType;
	private String title;
	private String contents;
	private String readYn;
	private LocalDateTime createDate;
	
}
