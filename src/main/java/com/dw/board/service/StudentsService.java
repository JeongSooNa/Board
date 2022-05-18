package com.dw.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dw.board.mapper.StudentsMapper;
import com.dw.board.vo.StudentsVO;

@Service
public class StudentsService {
	
	@Autowired
	private StudentsMapper studentsMapper;
	
	// 학생 저장
	public int setStudents(StudentsVO vo) {
		return studentsMapper.insertStudents(vo);
	}
	// 학생 전체 조회 (VO)
	public List<StudentsVO> getAllStudentsList(){
		return studentsMapper.selectAllStudentsList();
	}
	// 학생 전체 조회 (Map)
	public List<Map<String, Object>> getAllStudentsListByMap(){
		return studentsMapper.selectAllStudentsListByMap();
	}
	
	
	// 학생 id로 조회
	public StudentsVO getStudentsIdList(int studentsId){
		return studentsMapper.selectStudentsIdList(studentsId);
	}
	
}
