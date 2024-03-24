package com.kh.semiteam3.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.semiteam3.dto.ReplyDto;

@Service
public class ReplyForMycommentMapper implements RowMapper<ReplyDto> {

	@Override
	public ReplyDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ReplyDto replyDto = new ReplyDto();
		replyDto.setReplyNo(rs.getInt("reply_no"));
		replyDto.setReplyTime(rs.getString("reply_time"));
		replyDto.setReplyWriter(rs.getString("member_id"));
		replyDto.setReplyOrigin(rs.getInt("board_no"));
        replyDto.setBoardTitle(rs.getString("board_title")); 
        replyDto.setBoardView(rs.getInt("board_view"));
        replyDto.setBoardReply(rs.getInt("board_reply"));
		return replyDto;
	}

}
