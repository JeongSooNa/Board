package com.dw.board;

import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.dw.board.mapper.BoardMapper;
import com.dw.board.utils.PageHandler;

@SpringBootTest
class BoardApplicationTests {
	
	@Autowired
	private PageHandler pageHandeler;
	
	@Autowired
	private BoardMapper boardMapper;
	
	@Test
	void contextLoads() {
		int total = boardMapper.selectAllBoardTotal(); // 전체 게시글 수
		System.out.println("total : "+total);
		int pageNum = 1;		// 현재 페이지 번호
		int pageSize = 10;		// 한 페이지에 게시물 10개
		int navigatePages = 5; 	// 한 블록에 페이지 5개
		
		pageHandeler.setTotal(total);
		pageHandeler.setPageNum(pageNum);
		pageHandeler.setPageSize(pageSize);
		pageHandeler.setNavigatePages(navigatePages);
		
		pageHandeler.setNowBlock(pageNum);
		int nowBlock = pageHandeler.getNowBlock(); // 현재 블록
		System.out.println("현재 블록 : "+nowBlock);
		
		pageHandeler.setLastBlock(total);
		int lastBlock = pageHandeler.getLastBlock();
		System.out.println("마지막 블록 : "+lastBlock);
		
		pageHandeler.setStartPage(nowBlock);
		int startPage = pageHandeler.getStartPage();
		System.out.println("현재 페이지 : "+startPage);
		
		int pages = pageHandeler.calcPage(total, pageSize);
		pageHandeler.setEndPage(nowBlock, pages);
		int lastPage = pageHandeler.getEndPage();
		System.out.println("마지막 페이지 : "+lastPage);
		
		pageHandeler.setPreNext(pageNum);
		boolean hasPreviousPage = pageHandeler.isHasPreviousPage();
		boolean hasNextPage = pageHandeler.isHasNextPage();
		System.out.println("이전 버튼 유무 : "+hasPreviousPage);
		System.out.println("다음 버튼 유무 : "+hasNextPage);
		
		int limitStart = ((pageNum-1)*pageSize);
		List<Map<String,Object>> list = boardMapper.selectBoardAllListTest(limitStart,pageSize);
		for(Map<String,Object> l : list) {
			System.out.println(l.get("boardId"));
		}
	}

}
