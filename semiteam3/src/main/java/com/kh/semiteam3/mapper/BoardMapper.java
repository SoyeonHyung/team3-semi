package com.kh.semiteam3.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.semiteam3.dto.BoardDto;

@Service
public class BoardMapper implements RowMapper<BoardDto> {//boardContent 있는 Mapper

	@Override
	public BoardDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		BoardDto boardDto = new BoardDto();
		boardDto.setBoardNo(rs.getInt("board_no"));
		boardDto.setBoardTitle(rs.getString("board_title"));
		boardDto.setBoardContent(rs.getString("board_content"));
		boardDto.setBoardView(rs.getInt("board_view"));
		boardDto.setBoardLike(rs.getInt("board_like"));
		boardDto.setBoardReply(rs.getInt("board_reply"));
		boardDto.setBoardReport(rs.getInt("board_report"));
		boardDto.setBoardWriteTime(rs.getDate("board_write_time"));
		boardDto.setBoardEditTime(rs.getDate("board_edit_time"));
		boardDto.setBoardCategory(rs.getString("board_category"));
		boardDto.setBoardWriter(rs.getString("board_writer"));
		boardDto.setBoardLimitTime(rs.getString("board_limit_time"));
		return boardDto;
	}

}
