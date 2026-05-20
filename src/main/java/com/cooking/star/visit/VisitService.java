package com.cooking.star.visit;

import java.time.LocalDate;
import java.time.ZoneId;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service
public class VisitService {

	@Autowired
	private VisitMapper visitMapper;
	
	public void todayVisit(HttpServletRequest request)throws Exception{
		
		HttpSession session = request.getSession();
		
		String todayKey = "VISITED_"+LocalDate.now(ZoneId.of("Asia/Seoul"));
		
		if(session.getAttribute(todayKey)!= null) {
			return;
			
			
		}
		VisitDTO visitDTO = new VisitDTO();
		visitDTO.setSessionId(session.getId());
		visitMapper.todayVisit(visitDTO);
		
		session.setAttribute(todayKey, true);
		
	}
	
	public Long getTodayVisitCount()throws Exception{
		
		return visitMapper.getTodayVisitCount();
	
	}
	
	public Long getTotalMemberCount() throws Exception{
		
		return visitMapper.getTotalMemberCount();
	}
}
