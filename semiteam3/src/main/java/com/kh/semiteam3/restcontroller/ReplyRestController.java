package com.kh.semiteam3.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semiteam3.dao.BoardDao;
import com.kh.semiteam3.dao.MemberDao;
import com.kh.semiteam3.dao.ReplyDao;
import com.kh.semiteam3.dto.MemberDto;
import com.kh.semiteam3.dto.ReplyDto;

import jakarta.servlet.http.HttpSession;

//@CrossOrigin
@RestController
@RequestMapping("/rest/reply")
public class ReplyRestController {

	@Autowired
	private ReplyDao replyDao;

	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private MemberDao memberDao;

	@PostMapping("/list")
	public List<ReplyDto> list(@RequestParam int replyOrigin) {
	    List<ReplyDto> list = replyDao.selectList(replyOrigin);

	    for (ReplyDto replyDto : list) {
	        MemberDto memberDto = memberDao.selectOne(replyDto.getReplyWriter());
	        if (memberDto != null) {
	            replyDto.setReplyWriter(memberDto.getMemberNick());
	        } else {
	            replyDto.setReplyWriter("탈퇴한 사용자");
	        }
	    }
	    return list;
	}

	@PostMapping("/delete")
	public void delete(@RequestParam int replyNo, @RequestParam int replyOrigin) {
	    // 댓글 수 감소
	    boardDao.decreaseBoardReply(replyOrigin);
	    
	    replyDao.delete(replyNo);
	}

	@PostMapping("/insert")
	public void insert(@ModelAttribute ReplyDto replyDto, HttpSession session) {
		String loginId = (String) session.getAttribute("loginId");

		// 댓글 수 증가
		boardDao.increaseBoardReply(replyDto.getReplyOrigin());

		int sequence = replyDao.sequence();

		replyDto.setReplyWriter(loginId);
		replyDto.setReplyNo(sequence);

		replyDao.insert(replyDto);
	}

	@PostMapping("/edit")
	public void edit(@ModelAttribute ReplyDto replyDto) {
		replyDao.update(replyDto);
	}
}