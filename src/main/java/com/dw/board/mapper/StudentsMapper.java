package com.dw.board.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.dw.board.vo.StudentsVO;

@Mapper
public interface StudentsMapper {
	
	/**
	 * @param vo
	 * @return
	 * @author : JeongSoo Na
	 * @date : 2022. 5. 18.
	 * comment : 학생 저장
	 */
	public int insertStudents(StudentsVO vo);
	/**
	 * @return
	 * @author : JeongSoo Na
	 * @date : 2022. 5. 18.
	 * comment : 학생 전체 조회 (VO)
	 */
	public List<StudentsVO> selectAllStudentsList();
	/**
	 * @return
	 * @author : JeongSoo Na
	 * @date : 2022. 5. 18.
	 * comment : 학생 전체 조회 (Map)
	 */
	public List<Map<String, Object>> selectAllStudentsListByMap();
	
	/**
	 * @return
	 * @author : JeongSoo Na
	 * @date : 2022. 5. 18.
	 * comment : id로 학생 조회
	 */
	public StudentsVO selectStudents(int studentsId);
	/**
	 * @param studentsId
	 * @return
	 * @author : JeongSoo Na
	 * @date : 2022. 5. 18.
	 * comment : id로 delete
	 */
	public int deleteStudents(int studentsId);
	/**
	 * @param studentsId
	 * @return
	 * @author : JeongSoo Na
	 * @date : 2022. 5. 18.
	 * comment : update
	 */
	public int updateStudents(StudentsVO vo);
	
	/**
	 * @param vo
	 * @return
	 * @author : JeongSoo Na
	 * @date : 2022. 5. 19.
	 * comment : 학생 이름으로 학생 정보 조회
	 */
	public StudentsVO selectStudentsOne(StudentsVO vo);
}
