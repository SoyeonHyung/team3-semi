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
	private ReportReplyDao reportReplyDao;
	
	@Autowired
	private ReplyDao replyDao;
	
	@Autowired
	private MemberDao memberDao;
	
	
	
	@PostMapping("/insert")
	public void insert(@ModelAttribute ReportReplyDto reportReplyDto, HttpSession session) {
		String loginId = (String) session.getAttribute("loginId");//댓글신고자아이디

		// 댓글 수 증가
		//boardDao.increaseBoardReply(replyDto.getReplyOrigin());

		int sequence = reportReplyDao.getSequence();

		reportReplyDto.setReportReplyWriter(loginId);
		reportReplyDto.setReportReplyNo(sequence);

		reportReplyDao.insert(reportReplyDto);
	}
	
}
