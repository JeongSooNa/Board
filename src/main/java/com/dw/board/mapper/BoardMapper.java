package com.dw.board.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.dw.board.vo.BoardVO;

@Mapper
public interface BoardMapper {
	
	// 게시물 생성 (C)
	public int insertSaveBoard(BoardVO vo);
	// 게시물 조회 (R)
	public List<Map<String,Object>> selectBoardAllList();
	// 게시물 삭제 (D)
	public int deleteBoard(int boardId);
	// 게시물 수정 (U)
	public int updateBoard(BoardVO vo);
	// 게시물 상세보기
	public BoardVO selectBoard(int boardId);	
	// delete all
	public int deleteAllBoard();
	// 조회수 증가
	public int updateBoardViews(BoardVO vo);
	// Search
	public List<Map<String,Object>> selectBoardSearch(@Param("writer") String writer);
}
