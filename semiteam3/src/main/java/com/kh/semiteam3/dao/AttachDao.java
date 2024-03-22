package com.kh.semiteam3.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiteam3.dto.AttachDto;
import com.kh.semiteam3.mapper.AttachMapper;

@Repository
public class AttachDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private AttachMapper attachMapper;
	
	//시퀀스 값 가져오기
	public int getSequence() {
		String sql = "select attach_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	//등록
	public void insert(AttachDto attachDto) {
		String sql = "insert into attach ("
				+ "attach_no, attach_name, attach_type, attach_size"
				+ ") values(?, ?, ?, ?)";
		Object[] data = {
				attachDto.getAttachNo(), attachDto.getAttachName(),
				attachDto.getAttachType(), attachDto.getAttachSize()
		};
		jdbcTemplate.update(sql, data);
	}
	
	//검색
	public AttachDto selectOne(int attachNo) {
		String sql = "select * from attach where attach_no = ?";
		Object[] data = {attachNo};
		List<AttachDto> list = jdbcTemplate.query(sql, attachMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	//삭제
	public boolean delete(int attachNo) {
		String sql = "delete attach where attach_no = ?";
		Object[] data = {attachNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	

	//변경
	public boolean update(AttachDto attachDto) {
	    String sql = "UPDATE attach SET "
	                 + "attach_name = ?, "
	                 + "attach_type = ?, "
	                 + "attach_size = ? "
	                 + "WHERE attach_no = ?";
	    Object[] data = {
	            attachDto.getAttachName(),
	            attachDto.getAttachType(),
	            attachDto.getAttachSize(),
	            attachDto.getAttachNo()
	    };
	    return jdbcTemplate.update(sql, data) > 0;
	}

	public int findAttachNo(String memberId) {
		String sql = "select attach_no from member_attach where member_id = ?";
		Object[] data = {memberId};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
}