package com.kh.semiteam3.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiteam3.dto.BoardDto;
import com.kh.semiteam3.dto.MemberDto;
import com.kh.semiteam3.dto.ReportBoardDto;
import com.kh.semiteam3.mapper.ReportBoardMapper;
import com.kh.semiteam3.vo.PageVO;

@Repository
public class ReportBoardDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired  
	private ReportBoardMapper reportBoardMapper;
	
	//통합 페이징(목록 + 검색)
	public List<ReportBoardDto> selectListByPaging(PageVO pageVO){
		if(pageVO.isSearchOther()) {
			String sql = "select * from("
					+ "select rownum rn, TMP.*from("
					+ "select "
						+ "report_board_no, report_board_content, "
						+ "board_no, member_id, report_board_date, "
						+ "report_board_reason "
					+ "from report_board "
					+ "where instr("+pageVO.getColumn()+", ?) >0 "
					+ "order by report_board_no desc"
					+ ")TMP"
					+ ") where rn between ? and ?";
			Object[] data = {
                    pageVO.getKeyword(),
                    pageVO.getBeginRow(), 
                    pageVO.getEndRow()
            };
			 return jdbcTemplate.query(sql, reportBoardMapper, data);
		}
		else {
			String sql = "select * from("
					+ "select rownum rn, TMP.*from("
					+ "select "
						+ "report_board_no, report_board_content, "
						+ "board_no, member_id, report_board_date, "
						+ "report_board_reason "
					+ "from report_board "
					+ "order by report_board_no desc"
					+ ")TMP"
					+ ") where rn between ? and ?";
			Object[] data = {
                    pageVO.getBeginRow(), 
                    pageVO.getEndRow()
            };
			return jdbcTemplate.query(sql, reportBoardMapper, data);
		
		}
	}
	
	//통합 페이지 카운트(목록 + 검색)
		public int count(PageVO pageVO) {
			if(pageVO.isSearchOther()) {//검색
				String sql = "select count(*) from report_board "
						+ "where instr("+pageVO.getColumn()+", ?) > 0";
				Object[] data = {pageVO.getKeyword()};
				return jdbcTemplate.queryForObject(sql, int.class, data);
			}
			else {//목록
				String sql = "select count(*) from report_board";
				return jdbcTemplate.queryForObject(sql, int.class);
			}
		}
					
	//게시글 신고 등록
	public void insert(ReportBoardDto reportBoardDto) {
		String sql = "insert into report_board("
						+ "report_board_no, report_board_content, "
						+ "board_no, member_id, report_board_reason "
					+ ") values(?, ?, ?, ?, ?)";
		Object[] data = {
				reportBoardDto.getReportBoardNo(), 
				reportBoardDto.getReportBoardContent(), 
				reportBoardDto.getReportBoardOrigin(), 
				reportBoardDto.getReportBoardWriter(),
				reportBoardDto.getReportBoardReason() 
		};
		jdbcTemplate.update(sql, data);
	}
	
	public int getSequence() {
		String sql = "select report_board_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);//내가 실행할 구문을 인트로 실행해라
	}

	//삭제
	public boolean delete(int reportBoardNo) {
		String sql = "delete report_board where report_board_no = ?";
		Object[] data = {reportBoardNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//상세 조회
	public ReportBoardDto selectOne(int reportBoardNo) {
		String sql = "select * from report_board where report_board_no = ?";
		Object[] data = {reportBoardNo};
		List<ReportBoardDto> list = jdbcTemplate.query(sql, reportBoardMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	//신고 개수 카운트(원본게시글 번호로 조회)
	public int reportCountByReportBoardOrigin(int reportBoardOrigin) {
	    String sql = "SELECT COUNT(*) FROM report_board WHERE board_no = ?";
	    return jdbcTemplate.queryForObject(sql, Integer.class, reportBoardOrigin);

	}
	
	// 신고 개수 카운트(회원 아이디로 조회) - 신고한 횟수
	public int reporterCountByMemberId(String memberId) {
	    String sql = "SELECT COUNT(*) FROM report_board WHERE member_id = ?";
	    return jdbcTemplate.queryForObject(sql, Integer.class, memberId);
	}
	
	// 신고 개수 카운트(회원 아이디로 조회) - 신고당한 횟수
	public int reporteeCountPostsByMemberId(String memberId) { //rb는 report_board의 별칭, b는 board의 별칭
	    String sql = "SELECT COUNT(*) FROM report_board rb " +
	                 "JOIN board b ON rb.board_no = b.board_no " +
	                 "WHERE b.board_writer = ?";
	    return jdbcTemplate.queryForObject(sql, Integer.class, memberId);
	}
	
}	
