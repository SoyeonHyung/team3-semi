package com.kh.semiteam3.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiteam3.dto.AttachDto;
import com.kh.semiteam3.dto.MemberDto;
import com.kh.semiteam3.mapper.MemberMapper;

@Repository
public class MemberDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private MemberMapper memberMapper;
	
	//등록(회원가입)
	public void insert(MemberDto memberDto) {
		String sql = "insert into member"
				+ "(member_id, member_pw, member_nick, member_contact, member_email, "
				+ "member_birth, member_post, member_address1, member_address2) "
				+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Object[] data = {
				memberDto.getMemberId(), memberDto.getMemberPw(), 
				memberDto.getMemberNick(), memberDto.getMemberContact(),
				memberDto.getMemberEmail(), memberDto.getMemberBirth(),memberDto.getMemberPost(),
				memberDto.getMemberAddress1(),memberDto.getMemberAddress2()
		};
		jdbcTemplate.update(sql, data);
	}
	
	//회원정보 수정
	public boolean updateMember(MemberDto memberDto) {
		String sql = "update member set "
				+ "member_nick = ?, member_contact = ?, member_email = ?, member_birth = ?, "
				+ "member_post = ?, member_address1 = ?, member_address2 = ? "
				+ "where member_id = ?";
		Object[] data = {
				memberDto.getMemberNick(), memberDto.getMemberContact(),
				memberDto.getMemberEmail(), memberDto.getMemberBirth(),
				memberDto.getMemberPost(), memberDto.getMemberAddress1(),
				memberDto.getMemberAddress2(), memberDto.getMemberId()
		};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//비밀번호 수정
	public boolean updateMemberPw(MemberDto memberDto) {
		String sql = "update member set member_pw = ? where member_id = ?";
		Object[] data = {memberDto.getMemberPw(), memberDto.getMemberId()};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//최종로그인 시각 업데이트
	public boolean updateMemberLogin(String memberId) {
		String sql = "update member set member_login = SYSDATE "
				+ "where member_id = ?";
		Object[] data = {memberId};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//목록(회원가입 최신순으로 정렬)
	public List<MemberDto> selectList(){
		String sql = "select * from member order by member_join desc";
		return jdbcTemplate.query(sql, memberMapper);
	}
	
	//상세
	public MemberDto selectOne(String memberId) {
		String sql = "select * from member where member_id = ?";
		Object[] data = {memberId};
		List<MemberDto> list = jdbcTemplate.query(sql, memberMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//검색
	public List<MemberDto> searchList(String column, String keyword){
		String sql = "select * from member where instr(" + column + ", ?) > 0 "
				+ "order by "+ column + " asc";
		Object[] data = {keyword};
		return jdbcTemplate.query(sql, memberMapper, data);
	}
	
	//관리자에 의한 회원 정보 수정
	public boolean updateMemberByAdmin(MemberDto memberDto) {
		String sql = "update member set "
				+ "member_nick = ?, member_contact = ?, member_grade = ?, "
				+ "member_email = ?, member_birth = ?, member_post = ?, "
				+ "member_address1 = ?, member_address2 = ? "
				+ "where member_id = ?";
		Object[] data = {
				memberDto.getMemberNick(), memberDto.getMemberContact(),
				memberDto.getMemberGrade(), memberDto.getMemberEmail(),
				memberDto.getMemberBirth(),
				memberDto.getMemberPost(), memberDto.getMemberAddress1(),
				memberDto.getMemberAddress2(), memberDto.getMemberId()
		};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//회원 탈퇴
	public boolean withdraw(String memberId) {
		String sql = "delete from member where member_id = ?";
		Object[] data = {memberId};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//프로필 이미지 연결
	public void connect(String memberId, int attachNo) {
		String sql = "insert into member_attach(member_id, attach_no) "
				+ "values(?, ?)";
		Object[] data = {memberId, attachNo};
		jdbcTemplate.update(sql, data);
	}
	
	public int findAttachNo(String memberId) {
		String sql = "select attach_no from member_attach where member_id = ?";
		Object[] data = {memberId};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
	
	// 닉네임검색
	public MemberDto selectOneByMemberNick(String memberNick) {
		String sql = "select * from member where member_nick = ?";
		Object[] data = { memberNick };
		List<MemberDto> list = jdbcTemplate.query(sql, memberMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//찜목록(좋아요 누른 글 목록)
	

	public boolean Update(MemberDto memberDto) {
		String sql = "update member "
				+ "set "
				+ "member_id = ?, member_pw = ?, "
				+ "member_nick = ?, member_contact = ?, member_grade = ?, "
				+ "member_email = ?, member_joib = ?, member_birth = ?, member_post = ?, "
				+ "member_address1 = ?, member_address2 = ?, member_login = ? "
				+ "where member_id = ?";
		Object[] data = {
				memberDto.getMemberId(), memberDto.getMemberPost(),
				memberDto.getMemberNick(), memberDto.getMemberContact(),
				memberDto.getMemberGrade(), memberDto.getMemberEmail(),
				memberDto.getMemberJoin(), memberDto.getMemberBirth(),
				memberDto.getMemberPost(), memberDto.getMemberAddress1(),
				memberDto.getMemberAddress2(), memberDto.getMemberLogin(),
		};
		return jdbcTemplate.update(sql, data)>0;
	}
}
	
	
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

