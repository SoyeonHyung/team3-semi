package com.kh.semiteam3.restcontroller;
//형소연 댓글 신고 비동기 구현 중

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semiteam3.dao.MemberDao;
import com.kh.semiteam3.dao.ReplyDao;
import com.kh.semiteam3.dao.ReportReplyDao;
import com.kh.semiteam3.dto.ReportReplyDto;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/rest/reportReply")
public class ReportReplyRestController {
	@InitBinder 
	public void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
	}
	//댓글 신고 할때는 그 신고당한 번호랑 
	@Autowired
	private ReportReplyDao reportReplayDao;
	
	@Autowired
	private ReplyDao replyDao;
	
	@Autowired
	private MemberDao memberDao;
	
	//list가 굳이 필요할까
	
	//삭제는?
	
	//신고 등록(사용자가 댓글 신고하면 끝임 그냥!) 
	@PostMapping("/insert")
	public void insert(@ModelAttribute ReportReplyDto reportReplyDto, HttpSession session) {
		String loginId = (String) session.getAttribute("loginId");
		
		int sequence = reportReplayDao.getSequence();
		
		reportReplyDto.setReportReplyWriter(loginId);
		reportReplyDto.setReportReplyNo(sequence);
		
		reportReplayDao.insert(reportReplyDto);
	}
	
	
	
	
	
}
