package com.dw.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dw.board.mapper.BoardMapper;
import com.dw.board.vo.BoardVO;

@Service
public class BoardService {
	@Autowired
	private BoardMapper boardMapper; 
	
	// insert (C)
	public int setSaveBoard(BoardVO vo) {
		return boardMapper.insertSaveBoard(vo);
	}
	
	// select all (R)
	public List<Map<String,Object>> getBoardAllList(){
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
}
