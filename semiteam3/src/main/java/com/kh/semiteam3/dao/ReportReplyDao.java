package com.kh.semiteam3.dao;

import java.util.List;

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
	
	
	//댓글 신고는 전체 목록이 없게끔 만들겠다
	
	//댓글 신고 등록
	public int getSequence() {
	String sql = "select report_reply_seq.nexval from dual";
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
	
	
	
	
//	//통합 페이징(목록 + 검색)
//	public List<ReportReplyDto> selectListByPaging(PageVO pageVO){
//		if(pageVO.isSearch()) {
//			String sql = "select * from("
//					+ "select rownum rn, TMP.*from("
//					+ "select "
//						+ "report_reply_no, report_reply_content, "
//						+ "reply_no, member_id, report_reply_date, "
//						+ "report_reply_reason "
//					+ "from report_reply "
//					+ "where instr("+pageVO.getColumn()+", ?) > 0 "
//					+ "order by report_reply_no desc"
//					+ ")TMP"
//					+ ") where rn between ? and ?";
//			Object[] data = {
//                    pageVO.getKeyword(),
//                    pageVO.getBeginRow(), 
//                    pageVO.getEndRow()
//            };
//            return jdbcTemplate.query(sql, reportReplyMapper, data);
//		}
//		else {
//			String sql = "select * from("
//					+ "select rownum rn, TMP.*from("
//					+ "select "
//						+ "report_reply_no, report_reply_content, "
//						+ "reply_no, member_id, report_reply_date, "
//						+ "report_reply_reason "
//					+ "from report_reply "
//					+ "order by report_reply_no desc"
//					+ ")TMP"
//					+ ") where rn between ? and ?";
//			Object[] data = {
//                    pageVO.getBeginRow(), 
//                    pageVO.getEndRow()
//            };
//			return jdbcTemplate.query(sql, reportReplyMapper, data);
//		}
//		
//	}
//	
//	//통합 페이지 카운트(목록 + 검색)
//			public int count(PageVO pageVO) {
//				if(pageVO.isSearch()) {//검색
//					String sql = "select count(*) from report_reply "
//							+ "where instr("+pageVO.getColumn()+", ?) > 0";
//					Object[] data = {pageVO.getKeyword()};
//					return jdbcTemplate.queryForObject(sql, int.class, data);
//				}
//				else {//목록
//					String sql = "select count(*) from report_reply";
//					return jdbcTemplate.queryForObject(sql, int.class);
//				}
//			}
//				
//	//댓글 신고 등록
//	public void insert(ReportReplyDto reportReplyDto) {
//		String sql = "insert into report_reply("
//						+ "report_reply_no, report_reply_content, "
//						+ "reply_no, member_id, report_reply_reason "
//					+ ") values(?, ?, ?, ?, ?)";
//		Object[] data = {
//				reportReplyDto.getReportReplyNo(), 
//				reportReplyDto.getReportReplyContent(), 
//				reportReplyDto.getReportReplyOrigin(), 
//				reportReplyDto.getReportReplyWriter(),
//				reportReplyDto.getReportReplyReason() 
//		};
//		jdbcTemplate.update(sql, data);
//	}
//	public int getSequence() {
//		String sql = "select report_reply_seq.nexval from dual";
//		return jdbcTemplate.queryForObject(sql, int.class);
//	}
//	
//	//삭제
//	public boolean delete(int reportReplyNo) {
//		String sql = "delete report_reply where report_reply_no = ?";
//		Object[] data = {reportReplyNo};
//		return jdbcTemplate.update(sql, data) > 0;
//	}
//	
//	//상세 조회
//	public ReportReplyDto selectOne(int reportReplyNo) {
//		String sql = "select * from report_reply where report_reply_no = ?";
//		Object[] data = {reportReplyNo};
//		List<ReportReplyDto> list = jdbcTemplate.query(sql, reportReplyMapper, data);
//		return list.isEmpty() ? null : list.get(0);
//	}
}
