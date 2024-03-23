package com.kh.semiteam3.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiteam3.dto.ReplyDto;
import com.kh.semiteam3.mapper.ReplyMapper;
import com.kh.semiteam3.vo.PageVO;

@Repository
public class ReplyDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ReplyMapper replyMapper;
	
	//댓글은 전체 목록이 없다 (게시글마다 조회)
	public List<ReplyDto> selectList(int replyOrigin){
		String sql = "select * from reply "
				+ "where board_no=? "
				+ "order by reply_no asc";
		Object[] data = {replyOrigin};
		return jdbcTemplate.query(sql, replyMapper, data);
	}
	
	//댓글 등록
	public int sequence() {//ReplyRestController에서 reply_no에 시퀀스 넣어줌
		String sql = "select reply_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	public void insert(ReplyDto replyDto) {
		String sql = "insert into reply("
						+ "reply_no, member_id, reply_content, "
						+ "reply_time, board_no"
					+ ") "
					+ "values(?, ?, ?, sysdate, ?)";
		Object[] data = {
		replyDto.getReplyNo(), replyDto.getReplyWriter(),
		replyDto.getReplyContent(), replyDto.getReplyOrigin()
		};
		jdbcTemplate.update(sql, data);
	}
	
	//댓글 수정
	public boolean update(ReplyDto replyDto) {
		String sql = "update reply set reply_content = ? where reply_no = ?";
		Object[] data = { replyDto.getReplyContent(), replyDto.getReplyNo() };
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//댓글 삭제
	public boolean delete(int replyNo) {
		String sql = "delete reply where reply_no = ?";
		Object[] data = {replyNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//내가 쓴 댓글
    public List<ReplyDto> findBylist(String memberId, PageVO pageVO) {
		String sql = "select * from (" 
				+ "select rownum rn, TMP.* from (" 
				+ "select reply.reply_no,reply.reply_content,member.member_id "
				+ "as reply_writer,board.board_title "
				+ "as board_title from reply "
				+ "inner join member "
				+ "on reply.member_id = member.member_id "
				+ "inner join board on reply.board_no = board.board_no "
				+ "where member.member_id = ? "
				+ "order by reply_no desc"
				+ ")TMP"
				+ ") where rn between ? and ?";
        Object[] data = {memberId, pageVO.getBeginRow(), pageVO.getEndRow()};
        return jdbcTemplate.query(sql, replyMapper, data);
    }
    
    //내가 쓴 댓글을 위한 카운트
    public int countForMycomment(String memberId) {
    	String sql = "select count(*) from reply where member_id = ?";
    	Object[] data = {memberId};
    	return jdbcTemplate.queryForObject(sql, int.class, data);
    }
}




