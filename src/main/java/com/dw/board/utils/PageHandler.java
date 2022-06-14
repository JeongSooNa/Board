package com.dw.board.utils;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Component
public class PageHandler {
	private int total; // 전체 게시물 수
	private int pageNum; // 현재 페이지
	private int pageSize; // 1페이지에 몇 개의 게시물 표시할지
	private int startPage; // 현재 블록 첫 페이지
	private int endPage; // 현재 블록 마지막 페이지
	private boolean hasPreviousPage; // 이전 버튼 유무
	private boolean hasNextPage; // 다음 버튼 유무
	private int nowBlock; // 현재 블록
	private int lastBlock; // 마지막 블록
	private int navigatePages; // 한 블록에 몇 개의 페이지 표시할지 ex) 	1블록에 있으면 1~10
	
//	 필요한 상수들을 전부 set한 후 method에서 구현
//	 this.을 사용하느냐, parameter로 받느냐?
	
	/**
	 * @return
	 * @author : JeongSoo Na
	 * @date : 2022. 5. 31.
	 * comment : 총 페이지 수
	 */
	public int calcPage(int total, int pageSize) {
		int pages = 0;
		pages = total/pageSize;
		if(total%pageSize > 0) pages++;
		return pages;
	}
	
	/**
	 * 
	 * @author : JeongSoo Na
	 * @date : 2022. 5. 31.
	 * comment : 현재 내가 위치한 블록 알아내기
	 */
	public void setNowBlock(int pageNum, int navigatePages) {
		this.nowBlock = pageNum/navigatePages;
		if(pageNum%navigatePages > 0) this.nowBlock++;
	}
	
	/**
	 * @param total
	 * @author : JeongSoo Na
	 * @date : 2022. 5. 31.
	 * comment : 마지막 블록 알아내기
	 */
	public void setLastBlock(int total) {
		this.lastBlock = total/(this.navigatePages*this.pageSize);
		if(total%(this.navigatePages*this.pageSize) > 0) this.lastBlock++;
	}
	
	// start page
	public void setStartPage(int nowBlock) {
		this.startPage = (nowBlock-1)*this.navigatePages+1;
	}
	// end page
	public void setEndPage(int nowBlock, int pages) {
		this.endPage = nowBlock*this.navigatePages;
		if(nowBlock == this.lastBlock) this.endPage = pages;
	}
	// 이전 버튼, 다음 버튼 유무 판단
	public void setPreNext(int pageNum) {
		if(this.lastBlock == 1) {
			setHasPreviousPage(false);
			setHasNextPage(false);
		}
		if(this.lastBlock > 1 && this.lastBlock == this.nowBlock) {
			setHasPreviousPage(true);
			setHasNextPage(false);
		}
		if(this.lastBlock > 1 && pageNum <= this.navigatePages) {
			setHasPreviousPage(false);
			setHasNextPage(true);
		}
		
	}
	
}
