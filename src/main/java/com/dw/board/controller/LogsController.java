package com.dw.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LogsController {
	@GetMapping("logs")
	public String loadLogsPage() {
		return "logs";
	}
}
// 뭔가 오류가 뜬다.. 찾자 천천히
