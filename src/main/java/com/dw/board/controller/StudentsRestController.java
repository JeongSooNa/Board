package com.dw.board.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.dw.board.service.StudentsService;
import com.dw.board.vo.StudentsVO;

@RestController
@RequestMapping("/api/v1") // 중복 url
public class StudentsRestController {
	@Autowired
	private StudentsService StudentsService;
	
	// 학생 저장
	// post는 body로 data를 받는다.(보안)
	@PostMapping("/students")
	public int callSaveStudents(@RequestBody StudentsVO vo) {
		return StudentsService.setStudents(vo);
	}
	// 학생 전체 조회 (VO로 return)
	@GetMapping("/students")
	public List<StudentsVO> callAllStudentsList(){
		return StudentsService.getAllStudentsList();
	}
	// 학생 전체 조회 (Map으로 return)
	@GetMapping("students/map")
	public List<Map<String, Object>> callAllStudentsListByMap(){
		return StudentsService.getAllStudentsListByMap();
	}
	
	// 학생 id로 조회
	@GetMapping("/students/id/{id}")
	public StudentsVO callStudentsIdList(@PathVariable("id") int studentsId){
		return StudentsService.getStudentsIdList(studentsId);
	}
	
}
