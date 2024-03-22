package com.kh.semiteam3.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class BoardLikeDao {//*좋아요*는 수정이 없어!(인증번호 같은 것도 수정 없음)
	//좋아요는 비동기 통신으로 찍어야해 전부 다
	//클릭할때마다 C/D 계속 일어나지
	
	//[C]좋아요 내역을 등록
	//[D]좋아요 내역을 삭제
	//[R]좋아요 여부를 확인--조회인데 논리가 나와야지 (눌렀나요? 네 or 아니요)
	//[R]특정 글의 좋아요 개수를 확인
	
	@Autowired 
	private JdbcTemplate jdbcTemplate;
	
	public void insert(String memberId, int boardNo) {//어느 회원이 어느 글에 좋아요를 눌렀는지 알려줘라
		String sql = "insert into board_like(member_id, board_no) values(?,?)";
		Object[] data = {memberId, boardNo};
		jdbcTemplate.update(sql, data);
	}
	
	public boolean delete(String memberId, int boardNo) {//어느 회원이 어느글에 좋아요를 지웠는지 알려줘라
		String sql = "delete board_like where member_id = ? and board_no = ?";
		Object[] data = {memberId, boardNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	public boolean check(String memberId, int boardNo) {//이 회원이 이 글에 좋아요를 눌렀는지 안눌렀는지!
		String sql = "select count(*) from board_like "
				+ "where member_id = ? and board_no = ?";//이 아이디가 이 게시글에 좋아요 누른 개수 알려줘(그럼 0아니면1이겠지)
		Object[] data = {memberId, boardNo};
		int count = jdbcTemplate.queryForObject(sql, int.class,data);
		return count > 0;//좋아요 눌렀냐?
	}
	
	public int count(int boardNo) {//내가 게시글 번호 알려줄테니까 좋아요 몇개 붙어있는지 알아와
		String sql = "select count(*) from board_like where board_no = ?";
		Object[] data = {boardNo};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
}

