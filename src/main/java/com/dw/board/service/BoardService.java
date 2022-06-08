package com.dw.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dw.board.mapper.BoardMapper;
import com.dw.board.vo.BoardVO;
import com.github.pagehelper.PageHelper;

@Service
public class BoardService {
	@Autowired
	private BoardMapper boardMapper; 
	
	// insert (C)
	public int setSaveBoard(BoardVO vo) {
		return boardMapper.insertSaveBoard(vo);
	}
	
	// select all (R) 게시판 전체 조회
	// pageNum : 현재 페이지, pageSize : 한 페이지에 게시물 몇개?
	public List<Map<String,Object>> getBoardAllList(int pageNum, int pageSize){
		PageHelper.startPage(pageNum, pageSize);
		return boardMapper.selectBoardAllList();
	}
	// 제목 update 수정날짜 만
	// 게시물 삭제 (D)
	@Transactional(rollbackFor = {Exception.class})
	public int getRemoveBoard(int boardId){
		return boardMapper.deleteBoard(boardId);
	}
	// 게시물 수정 (U)
	@Transactional(rollbackFor = {Exception.class})
	public int getUpdateBoard(int boardId, BoardVO vo) {
		vo.setBoardId(boardId);
		return boardMapper.updateBoard(vo);
	}
	// 게시물 상세보기
	public BoardVO getBoard(int boardId) {
		return boardMapper.selectBoard(boardId);
	}
	
	// delete all
	public int setRemoveAllBoard() {
		return boardMapper.deleteAllBoard();
	}
	
	// 게시물 조회수
	public int getUpdateBoardViews(int boardId) {
		// 1. 게시판 번호를 이용해서 조회수를 select
		BoardVO vo = boardMapper.selectBoard(boardId);
		int views = vo.getCnt();
		// 2. 조회수 1 증가
		++ views; 
		vo.setBoardId(boardId);
		vo.setCnt(views);
		return boardMapper.updateBoardViews(vo);
	}
	
	// Search
	public List<Map<String,Object>> getBoardSearch(String writer, int pageNum, int pageSize){
		PageHelper.startPage(pageNum, pageSize);
		return boardMapper.selectBoardSearch(writer);
	}
	
	// Statistics
	public Map<String,Object> getBoardStatistics(){
		return boardMapper.selectBoardStatistics();
	}
	
	
}
