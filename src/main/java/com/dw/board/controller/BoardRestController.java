package com.dw.board.controller;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dw.board.service.BoardService;
import com.dw.board.vo.BoardVO;

@RestController
@RequestMapping("/api/v1")
public class BoardRestController {
	@Autowired
	private BoardService boardService;
	
	// 게시판 저장
	@CrossOrigin
	@PostMapping("/board")
	public int callSaveBoard(@RequestBody BoardVO vo) {
		return boardService.setSaveBoard(vo);
	}
	// 게시판 조회
	@CrossOrigin
	@GetMapping("/board")
	public List<Map<String,Object>> callBoardAllList() {
		return boardService.getBoardAllList();
	}
	
	
	// 게시판 전체 삭제
	@CrossOrigin
	@DeleteMapping("/board")
	public int callRemoveAllBoard() {
		return boardService.setRemoveAllBoard();
	}
	
}
