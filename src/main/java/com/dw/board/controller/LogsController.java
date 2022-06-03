package com.dw.board.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dw.board.service.LogsService;

@RestController
@RequestMapping("/api/v1")
public class LogsController {
	@Autowired
	private LogsService logsService;
	
	@GetMapping("/logs")
	public List<Map<String, Object>> getLogList(){
		return logsService.getLogsList();
	}
}
