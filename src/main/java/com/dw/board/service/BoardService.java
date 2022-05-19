package com.dw.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dw.board.mapper.BoardMapper;
import com.dw.board.vo.BoardVO;

@Service
public class BoardService {
	@Autowired
	private BoardMapper boardMapper; 
	
	// insert
	public int setSaveBoard(BoardVO vo) {
		return boardMapper.insertSaveBoard(vo);
	}
	// select all
	public List<BoardVO> getBoardAllList(){
		return boardMapper.selectBoardAllList();
	}
}
