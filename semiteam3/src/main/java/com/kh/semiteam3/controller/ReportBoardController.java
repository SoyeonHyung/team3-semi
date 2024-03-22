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

import com.kh.semiteam3.dao.BoardDao;
import com.kh.semiteam3.dao.MemberDao;
import com.kh.semiteam3.dao.ReportBoardDao;
import com.kh.semiteam3.dto.ReportBoardDto;
import com.kh.semiteam3.service.AttachService;
import com.kh.semiteam3.vo.PageVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/reportBoard")
public class ReportBoardController {

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
	}

	@Autowired
	private ReportBoardDao reportBoardDao;

	@Autowired
	private MemberDao memberDao;

	@Autowired
	private AttachService attachService;

	@Autowired
	private BoardDao boardDao;

	//목록
	@RequestMapping("/list")
	public String list(
			@ModelAttribute PageVO pageVO,
			Model model) {
		int count = reportBoardDao.count(pageVO);
		pageVO.setCount(count);
		model.addAttribute("pageVO", pageVO);

		List<ReportBoardDto> list = reportBoardDao.selectListByPaging(pageVO);
		model.addAttribute("list", list);

		return "/WEB-INF/views/reportBoard/list.jsp";
	}

	//삭제
	@GetMapping("/delete")
	public String delete(@RequestParam int reportBoardNo) {
		ReportBoardDto reportBoardDto = reportBoardDao.selectOne(reportBoardNo);

		//Jsoup으로 내용을 탐색하는 과정
		Document document = Jsoup.parse(reportBoardDto.getReportBoardContent());
		Elements elements = document.select(".server-img");//태그 찾기
		for(Element element : elements) {//반복문으로 한개씩 처리
			String key = element.attr("data-key");//data-key 속성을 읽어라!
			int attachNo = Integer.parseInt(key);//숫자로 변환
			attachService.remove(attachNo);//파일삭제+DB삭제
		}

		reportBoardDao.delete(reportBoardNo);
		return "redirect:list";
	}

	//등록
    @GetMapping("/insert")
    public String insert(@RequestParam Integer reportBoardOrigin, Model model) {
        ReportBoardDto reportBoardDto = reportBoardDao.selectOne(reportBoardOrigin);
        return "/WEB-INF/views/reportBoard/insert.jsp";
    }

    @PostMapping("/insert")
    public String insert(@ModelAttribute ReportBoardDto reportBoardDto, 
                        HttpSession session, Model model) {
        String loginId = (String)session.getAttribute("loginId");
        reportBoardDto.setReportBoardWriter(loginId);

        boardDao.increaseBoardReport(reportBoardDto.getReportBoardOrigin());

        int sequence = reportBoardDao.getSequence();//DB에서 시퀀스 번호를 추출(번호 미리 뽑아)
        reportBoardDto.setReportBoardNo(sequence);//게시글 정보에 추출한 번호를 포함시킨다
        reportBoardDao.insert(reportBoardDto);

        return "redirect:http://localhost:8080/board/detail?boardNo="+reportBoardDto.getReportBoardOrigin();
    }


	//상세
	@RequestMapping("/detail")
	public String detail(@RequestParam int reportBoardNo, Model model) {
		ReportBoardDto reportBoardDto = reportBoardDao.selectOne(reportBoardNo);
		model.addAttribute("reportBoardDto", reportBoardDto);

//		if(reportBoardDto.getReportBoardWriter() != null) {
//			MemberDto memberDto = memberDao.selectOne(reportBoardDto.getReportBoardWriter());
//			model.addAttribute("memberDto", memberDto);
//		}

		return "/WEB-INF/views/reportBoard/detail.jsp";
	}
	
	//프로필 다운로드 페이지
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