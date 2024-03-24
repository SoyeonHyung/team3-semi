package com.kh.semiteam3.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.semiteam3.dto.BoardDto;

@Service
public class BoardWithNicknameMapper implements RowMapper<BoardDto>{
	@Override
	public BoardDto mapRow(ResultSet rs, int rowNum) throws SQLException {
	    BoardDto board = new BoardDto();
	    board.setBoardNo(rs.getInt("board_no"));
	    board.setBoardTitle(rs.getString("board_title"));
	    board.setBoardContent(rs.getString("board_content"));
	    
	    // 회원 닉네임을 가져와서 설정
	    board.setBoardWriterNickname(rs.getString("boardWriterNickname"));
	    
	    return board;
	}
}



