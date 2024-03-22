package com.kh.semiteam3.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.semiteam3.dto.MemberDto;

@Service
public class MemberMapper implements RowMapper<MemberDto>{

	@Override
	public MemberDto mapRow(ResultSet rs, int idx) throws SQLException {
		MemberDto memberDto = new MemberDto();
		memberDto.setMemberId(rs.getString("member_id"));
		memberDto.setMemberPw(rs.getString("member_pw"));
		memberDto.setMemberNick(rs.getString("member_nick"));
		memberDto.setMemberContact(rs.getString("member_contact"));
		memberDto.setMemberGrade(rs.getString("member_grade"));
		memberDto.setMemberEmail(rs.getString("member_email"));
		memberDto.setMemberJoin(rs.getDate("member_join"));
		memberDto.setMemberBirth(rs.getString("member_birth"));
		memberDto.setMemberPost(rs.getString("member_post"));
		memberDto.setMemberAddress1(rs.getString("member_address1"));
		memberDto.setMemberAddress2(rs.getString("member_address2"));
		memberDto.setMemberLogin(rs.getDate("member_login"));
		return memberDto;
	}

}
