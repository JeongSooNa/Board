package com.dw.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dw.board.mapper.LogsMapper;
import com.dw.board.vo.LogVO;

@Service
public class LogsService {
	@Autowired
	private LogsMapper logsMapper;
	
	// insert
	public int setLogs(LogVO vo) {
		return logsMapper.insertLogs(vo);
	}
	// select
	public List<Map<String, Object>> getLogsList(){
		return logsMapper.selectBoardLogs();
	}
	
}
