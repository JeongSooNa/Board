package com.dw.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dw.board.mapper.LogsMapper;
import com.dw.board.vo.LogVO;
import com.github.pagehelper.PageHelper;

@Service
public class LogsService {
	@Autowired
	private LogsMapper logsMapper;
	
	// insert
	public int setLogs(LogVO vo) {
		return logsMapper.insertLogs(vo);
	}
	// select all
	public List<Map<String, Object>> getLogsList(int pageNum, int pageSize){
		PageHelper.startPage(pageNum, pageSize);
		return logsMapper.selectBoardLogs(0);
	}
	// select
	public Map<String, Object> getLogs(int logId){
		return logsMapper.selectBoardLogs(logId).get(0);
	}
	
}
