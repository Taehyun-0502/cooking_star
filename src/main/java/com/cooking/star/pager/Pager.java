package com.cooking.star.pager;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Pager {

	//현재 페이지번호
	private Long page;
	//한페이지당 글의 겟수
	private Long perPage; 
	//블록 시작번호
	private Long startNum;
	//이전블록 유무
	private boolean pre=true;
	//다음블록 유무
	private boolean next=true;
	//검색어
	private String search="";
	//검색컬럼
	private String kind;
	//n번째 블록일때 시작 페이지 번호
	private Long start;
	//n번째 블록일때 끝 페이지 번호
	private Long end;
	
	//현재페이지 번호
	public Long getPage() {
		if(this.page==null||this.page <1) {
			this.page=1L;
		}return page;	
	}
	//한페이지당 글갯수
	public Long getPerPage() {
		if(this.perPage==null||this.perPage<1) {
			this.perPage=5L;
		}return perPage;
	}
	
	public void makeStartNum() {
		this.startNum=(this.getPage()-1)*this.getPerPage();
	}
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	//블록 출력메서드
	public void makeBlock(Long totalCount) {
		//한블럭당 페이지넘버 갯수
		Long perBlock=5L;
		
		if(totalCount==0) {
			perBlock=1L;
			next=false; //다음블럭은 없음
			pre=false; //이전블럭 없음
		}
		//총 페이지수
		Long totalPage=totalCount/this.getPerPage();
		if(totalCount % getPerPage()!=0) {
			totalPage++;
		}
		//총 블럭갯수
		Long totalBlock=totalPage/perBlock;
		if(totalPage % perBlock !=0) {
			totalBlock++;
		}
		//현재 블럭번호
		Long curBlock=this.getPage()/perBlock;
		if(getPage()%perBlock !=0) {
			curBlock++;
		}
		
		//시작번호와 끝번호
		start=(curBlock-1)*perBlock+1;
		end=curBlock*perBlock;
		
		
		if(curBlock==totalBlock) { //현재블럭이 마지막블럭이라면
			end=totalPage; //마지막번호는 계산한 마지막페이지번호로
			next=false; //다음블럭은 없음
		}
		if(curBlock<2) { //현재블럭이 2보다 작다면
			pre=false; //이전블럭 없음
		}
	}
}
