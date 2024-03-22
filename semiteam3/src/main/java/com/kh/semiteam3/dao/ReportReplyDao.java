package com.kh.semiteam3.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiteam3.dto.ReportReplyDto;
import com.kh.semiteam3.mapper.ReportReplyMapper;
import com.kh.semiteam3.vo.PageVO;

@Repository
public class ReportReplyDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired  
	private ReportReplyMapper reportReplyMapper;
	
	//통합 페이징(목록 + 검색)
	public List<ReportReplyDto> selectListByPaging(PageVO pageVO){
		if(pageVO.isSearchOther()) {
			String sql = "select * from("
					+ "select rownum rn, TMP.*from("
					+ "select "
						+ "report_reply_no, report_reply_content, "
						+ "reply_no, member_id, report_reply_date, "
						+ "report_reply_reason "
					+ "from report_reply "
					+ "where instr("+pageVO.getColumn()+", ?) > 0 "
					+ "order by report_reply_no desc"
					+ ")TMP"
					+ ") where rn between ? and ?";
			Object[] data = {
                    pageVO.getKeyword(),
                    pageVO.getBeginRow(), 
                    pageVO.getEndRow()
            };
            return jdbcTemplate.query(sql, reportReplyMapper, data);
		}
		else {
			String sql = "select * from("
					+ "select rownum rn, TMP.*from("
					+ "select "
						+ "report_reply_no, report_reply_content, "
						+ "reply_no, member_id, report_reply_date, "
						+ "report_reply_reason "
					+ "from report_reply "
					+ "order by report_reply_no desc"
					+ ")TMP"
					+ ") where rn between ? and ?";
			Object[] data = {
                    pageVO.getBeginRow(), 
                    pageVO.getEndRow()
            };
			return jdbcTemplate.query(sql, reportReplyMapper, data);
		}
		
	}
	
	//통합 페이지 카운트(목록 + 검색)
			public int count(PageVO pageVO) {
				if(pageVO.isSearchOther()) {//검색
					String sql = "select count(*) from report_reply "
							+ "where instr("+pageVO.getColumn()+", ?) > 0";
					Object[] data = {pageVO.getKeyword()};
					return jdbcTemplate.queryForObject(sql, int.class, data);
				}
				else {//목록
					String sql = "select count(*) from report_reply";
					return jdbcTemplate.queryForObject(sql, int.class);
				}
			}
				
	//댓글 신고 등록
	public int getSequence() {
		String sql = "select report_reply_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	public void insert(ReportReplyDto reportReplyDto) {
		String sql = "insert into report_reply("
						+ "report_reply_no, report_reply_content, "
						+ "reply_no, member_id, report_reply_reason "
						+ ") values(?,?,?,?,?)";
		Object[] data = {
				reportReplyDto.getReportReplyNo(),
				reportReplyDto.getReportReplyContent(),
				reportReplyDto.getReportReplyOrigin(),
				reportReplyDto.getReportReplyWriter(),
				reportReplyDto.getReportReplyReason()
		};
		jdbcTemplate.update(sql, data);
	}
	
	//삭제
	public boolean delete(int reportReplyNo) {
		String sql = "delete report_reply where report_reply_no = ?";
		Object[] data = {reportReplyNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//상세 조회
	public ReportReplyDto selectOne(int reportReplyNo) {
		String sql = "select * from report_reply where report_reply_no = ?";
		Object[] data = {reportReplyNo};
		List<ReportReplyDto> list = jdbcTemplate.query(sql, reportReplyMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//원본 게시글 번호 불러오는 메소드
	public int getReportReplyBoardOrigin(int reportReplyNo){
		String sql = "select b.board_no "
				+ "from report_reply rr "
				+ "inner join reply r on rr.reply_no = r.reply_no "
				+ "inner join board b on r.board_no = b.board_no "
				+ "where rr.report_reply_no = ?";
		Object[] data = {reportReplyNo};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
	// 신고당한 댓글 번호, 내용 불러오는 메소드
	public Map<String, Object> getReportReplyContent(int reportReplyNo) {
	    String sql = "SELECT rr.report_reply_no, rr.report_reply_content, r.reply_no, r.reply_content " +
	                 "FROM report_reply rr " +
	                 "JOIN reply r ON rr.reply_no = r.reply_no " +
	                 "WHERE rr.report_reply_no = ?";
	    Object[] data = {reportReplyNo};
	    return jdbcTemplate.queryForMap(sql, data);
	}
	
}