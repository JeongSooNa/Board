package com.dw.board.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.dw.board.service.StudentsService;
import com.dw.board.vo.StudentsVO;

@RestController
@RequestMapping("/api/v1") // 중복 url
public class StudentsRestController {
	@Autowired
	private StudentsService StudentsService;
	
	// 중요한 정보를 서버에 전송할 때 POST 사용!
	// 로그인 정보 맞으면 true, 틀리면 false return
	@CrossOrigin
	@PostMapping("/login")
	public boolean callIsLogin(@RequestBody StudentsVO vo, HttpSession httpSession) {
		
		boolean isLogin = StudentsService.isStudents(vo);
		if(isLogin) {
			// 저장하는 방식 key, value
			httpSession.setAttribute("name","najeongsoo");
		}
		
		return StudentsService.isStudents(vo);
	}
	
	// 학생 저장
	// post는 body로 data를 받는다.(보안)
	@CrossOrigin
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
	@GetMapping("/students/map")
	public List<Map<String, Object>> callAllStudentsListByMap(HttpSession httpSession){
		// session
		String name = (String)httpSession.getAttribute("name");
		System.out.println("세션에서 가져온 이름은 : "+name);
		if(name == null) return null;
		//
		return StudentsService.getAllStudentsListByMap();
	}
	// 학생 id로 조회
	@GetMapping("/students/id/{id}")
	public StudentsVO callStudents(@PathVariable("id") int studentsId){
		return StudentsService.getStudents(studentsId);
	}
	// 학생 삭제
	@DeleteMapping("/students/id/{id}")
	public int callRemoveStudents(@PathVariable("id") int studentsId){
		return StudentsService.getRemoveStudents(studentsId);
	}
	// 학생 update
	@PatchMapping("/students/id/{id}")
	public int callUpdateStudents(@PathVariable("id") int studentsId, @RequestBody StudentsVO vo){
		return StudentsService.getUpdateStudents(studentsId,vo);
	}
	

}
