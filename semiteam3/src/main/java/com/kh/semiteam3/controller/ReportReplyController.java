package com.kh.semiteam3.controller;

import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semiteam3.dao.MemberDao;
import com.kh.semiteam3.dao.ReportReplyDao;
import com.kh.semiteam3.dto.MemberDto;
import com.kh.semiteam3.dto.ReportReplyDto;
import com.kh.semiteam3.service.AttachService;
import com.kh.semiteam3.vo.PageVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/reportReply")
public class ReportReplyController {

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));//페이지네이션때문에
	}
	
	@Autowired
	private ReportReplyDao reportReplyDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private AttachService attachService;
	
	//목록--관리자만 보든거 가능!
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
	
	//삭제--관리자가 댓글 신고한 글 삭제할 수 있도록.. 댓글 달린 게시글 가서 판단 후에 그 댓글 삭제할 수 있도록..
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
	
	//등록 -- ReportReplyRestController로 처리하였음
//		@GetMapping("/insert")
//		public String insert(@RequestParam Integer reportReplyOrigin, Model model) {
//			ReportReplyDto reportReplyDto = reportReplyDao.selectOne(reportReplyOrigin);
//			return "/WEB-INF/views/reportReply/insert.jsp";
//		}
//		
//		@PostMapping("/insert")
//		public String insert(@ModelAttribute ReportReplyDto reportReplyDto, 
//							HttpSession session, Model model) {
//			String loginId = (String)session.getAttribute("loginId");
//			reportReplyDto.setReportReplyWriter(loginId);
//			
//			reportReplyDao.insert(reportReplyDto);
//			
//			return "redirect:detail?reportReplyNo="+reportReplyDto.getReportReplyOrigin();
//		}
		
		//상세--관리자만 상세 보는거 가능
		@RequestMapping("/detail")
		public String detail(@RequestParam int reportReplyNo, Model model) {
			ReportReplyDto reportReplyDto = reportReplyDao.selectOne(reportReplyNo);
			model.addAttribute("reportReplyDto", reportReplyDto);
			
			if(reportReplyDto.getReportReplyWriter() != null) {
				MemberDto memberDto = memberDao.selectOne(reportReplyDto.getReportReplyWriter());
				model.addAttribute("memberDto", memberDto);
			}
			// 신고된 댓글이 있는 원본 게시글 번호를 가져옴
	        int originalBoardNo = reportReplyDao.getReportReplyBoardOrigin(reportReplyNo);
	        model.addAttribute("originalBoardNo", originalBoardNo);//신고당한 댓글이 달린 원본게시글 번호 
	        
	        // 신고당한 댓글의 내용을 가져와 모델에 추가
	        Map<String, Object> reportedReplyData = reportReplyDao.getReportReplyContent(reportReplyNo);
	        model.addAttribute("reportedReplyData", reportedReplyData);
			
			return "/WEB-INF/views/reportReply/detail.jsp";
		}
		
		//프로필 다운로드 페이지--사이드바에 프로필 이미지 안되는거 해결
				@RequestMapping("/image")
				public String image(HttpSession session) {
					try {
						String loginId = (String)session.getAttribute("loginId");
					int attachNo = memberDao.findAttachNo(loginId);
					return "redirect:/download?attachNo=" + attachNo;
				}
				catch(Exception e) {
					return "redirect:/image/user.svg";
					}
				}
}











