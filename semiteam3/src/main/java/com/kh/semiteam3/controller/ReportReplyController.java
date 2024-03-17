package com.kh.semiteam3.controller;

import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semiteam3.dao.MemberDao;
import com.kh.semiteam3.dao.ReportReplyDao;
import com.kh.semiteam3.dto.MemberDto;
import com.kh.semiteam3.dto.ReplyDto;
import com.kh.semiteam3.dto.ReportReplyDto;
import com.kh.semiteam3.service.AttachService;
import com.kh.semiteam3.vo.PageVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/reportReply")
public class ReportReplyController {

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
	}
	
	@Autowired
	private ReportReplyDao reportReplyDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private AttachService attachService;
	
	//목록
	@RequestMapping("/list")
	public String list(
			@ModelAttribute PageVO pageVO,
			Model model) {
		int count = reportReplyDao.count(pageVO);
		pageVO.setCount(count);
		model.addAttribute("pageVO", pageVO);
		
		List<ReportReplyDto> list = reportReplyDao.selectListByPaging(pageVO);
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/reportReply/list.jsp";
	}
	
	//삭제
	@GetMapping("/delete")
	public String delete(@RequestParam int reportReplyNo) {
		ReportReplyDto reportReplyDto =  reportReplyDao.selectOne(reportReplyNo);
		
		//Jsoup으로 내용을 탐색하는 과정
		Document document = Jsoup.parse(reportReplyDto.getReportReplyContent());
		Elements elements = document.select(".server-img");//태그 찾기
		for(Element element : elements) {//반복문으로 한개씩 처리
			String key = element.attr("data-key");//data-key 속성을 읽어라!
			int attachNo = Integer.parseInt(key);//숫자로 변환
			attachService.remove(attachNo);//파일삭제+DB삭제
		}
		
		reportReplyDao.delete(reportReplyNo);
		return "redirect:list";
	}
	
	//등록
		@GetMapping("/insert")
		public String insert(@RequestParam Integer reportReplyOrigin, Model model) {
			ReportReplyDto reportReplyDto = reportReplyDao.selectOne(reportReplyOrigin);
			model.addAttribute("reportReplyDto", reportReplyDto);
			return "/WEB-INF/views/reportReply/insert.jsp";
			
		}
		
		@PostMapping("/insert")
		public String insert(@ModelAttribute ReportReplyDto reportReplyDto, 
							@ModelAttribute ReplyDto replyDto,//댓글 달려잇는 게시글 번호 알아내기 위해 
							HttpSession session, Model model) {
			String loginId = (String)session.getAttribute("loginId");
			reportReplyDto.setReportReplyWriter(loginId);
			
			int sequence = reportReplyDao.getSequence();//번호 미리 추출
			reportReplyDto.setReportReplyNo(sequence);//댓글정보에 추출한 번호 포함  
			reportReplyDao.insert(reportReplyDto);
			
			//return "redirect:detail?reportReplyNo="+reportReplyDto.getReportReplyOrigin();
			return "redirect:http://localhost:8080/board/detail?boardNo="+replyDto.getReplyOrigin();
		}
		
		//상세
		@RequestMapping("/detail")
		public String detail(@RequestParam int reportReplyNo, Model model) {
			ReportReplyDto reportReplyDto = reportReplyDao.selectOne(reportReplyNo);
			model.addAttribute("reportReplyDto", reportReplyDto);
			
			if(reportReplyDto.getReportReplyWriter() != null) {
				MemberDto memberDto = memberDao.selectOne(reportReplyDto.getReportReplyWriter());
				model.addAttribute("memberDto", memberDto);
			}
			return "/WEB-INF/views/reportReply/detail.jsp";
		}
}
