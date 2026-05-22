package com.cooking.star.message;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class MessageAlarmDTO {

	private Long messageNum;
	private String writerType;
    private String writerName;
	private String messageType;
	private String title;
	private String contentPreview;
	private String createdAt;
	private Long unreadCount;
	
	
}
