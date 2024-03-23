package com.kh.semiteam3.controller;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

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

import com.kh.semiteam3.dao.InquiryDao;
import com.kh.semiteam3.dao.MemberDao;
import com.kh.semiteam3.dto.InquiryDto;
import com.kh.semiteam3.dto.MemberDto;
import com.kh.semiteam3.service.AttachService;
import com.kh.semiteam3.vo.PageVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/inquiry")
public class InquiryController {
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
	}
	
	@Autowired
	private InquiryDao inquiryDao;
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private AttachService attachService;
	
	@RequestMapping("/list")
	public String list(@ModelAttribute PageVO pageVO, 
						Model model) {
		int count = inquiryDao.count(pageVO);
	
		pageVO.setCount(count);
		
		model.addAttribute("pageVO", pageVO);
		
		List<InquiryDto> list;
		if (pageVO.getColumn().equals("member_nick")) { // 수정된 부분: 닉네임 검색일 경우 selectByNick 메소드 호출
	        list = inquiryDao.selectByNick(pageVO);
	    } else {
	        list = inquiryDao.selectListByPaging(pageVO);
	    }
		
		model.addAttribute("list", list);
		
	    for (InquiryDto inquiryDto : list) {
	        MemberDto memberDto = memberDao.selectOne(inquiryDto.getInquiryWriter());
	        if (memberDto != null) {
	        	inquiryDto.setInquiryWriter(memberDto.getMemberNick());
	        } else {
	        	inquiryDto.setInquiryWriter("탈퇴한사용자");
	        }
	    }
		
		return "/WEB-INF/views/inquiry/list.jsp";
	}

	@RequestMapping("/detail")
	public String detail(@RequestParam int inquiryNo, Model model) {
		InquiryDto inquiryDto = inquiryDao.selectOne(inquiryNo);
		model.addAttribute("inquiryDto", inquiryDto);
		if (inquiryDto.getInquiryWriter() != null) {// 작성자가 탈퇴하지 않았다면
			MemberDto memberDto = memberDao.selectOne(inquiryDto.getInquiryWriter());
			model.addAttribute("memberDto", memberDto);
		}
		return "/WEB-INF/views/inquiry/detail.jsp";
	}
	
	@GetMapping("/insert") // GET방식 - 일반적인 주소를 이용한 접근
	public String insert(@RequestParam(required = false) Integer inquiryTarget, Model model) {
		
		//답글일 경우는 작성 페이지로 답글의 정보를 전달(제목 등에 사용)
		if(inquiryTarget != null) {
			InquiryDto targetDto = inquiryDao.selectOne(inquiryTarget);
			model.addAttribute("targetDto", targetDto);
		}
		return "/WEB-INF/views/inquiry/insert.jsp";
	}
	
	@PostMapping("/insert")
	public String insert(@ModelAttribute InquiryDto inquiryDto, HttpSession session) {
		//새글이던 답글이던 작성자는 있어야 한다
		String loginId = (String)session.getAttribute("loginId");
		inquiryDto.setInquiryWriter(loginId);
		
		int sequence = inquiryDao.getsequence();
		inquiryDto.setInquiryNo(sequence);
		
			if(inquiryDto.getInquiryTarget() == null) {//새글(대상 == null)
				inquiryDto.setInquiryGroup(sequence);//그룹번호는 글번호로 설정
			}
			else {//답글(대상!=null)
				InquiryDto targetDto = inquiryDao.selectOne(inquiryDto.getInquiryTarget());
				inquiryDto.setInquiryGroup(targetDto.getInquiryGroup());//그룹번호를 대상글의 그룹번호로 설정
				inquiryDto.setInquiryDepth(targetDto.getInquiryDepth() + 1);//차수를 대상글의 차수+1 로 설정
			}
			inquiryDao.insert(inquiryDto);
			
			return "redirect:detail?inquiryNo="+sequence;
		}

	
	@GetMapping("/delete")
	public String delete(@RequestParam int inquiryNo) {
		InquiryDto inquiryDto = inquiryDao.selectOne(inquiryNo);
		
		Document document = Jsoup.parse(inquiryDto.getInquiryContent());
		Elements elements = document.select(".server-img");//태그찾기
		for(Element element : elements) {//반복문으로 한개씩 처리
			String key = element.attr("data-key");//data-key속성을 읽어라
			int attachNo = Integer.parseInt(key);//숫자로변환
			attachService.remove(attachNo);//파일삭제+DB삭제
		
		}
		inquiryDao.delete(inquiryNo);
		// return "redirect:/inquiry/list";
		return "redirect:list";
	}
	
	@GetMapping("/edit") // GET방식 - 일반적인 주소를 이용한 접근
	public String edit(@RequestParam int inquiryNo, Model model) {
		InquiryDto inquiryDto = inquiryDao.selectOne(inquiryNo);
		model.addAttribute("inquiryDto", inquiryDto);
		return "/WEB-INF/views/inquiry/edit.jsp";
	}

	@PostMapping("/edit") 
	public String edit(@ModelAttribute InquiryDto inquiryDto, HttpSession session) {
		Set<Integer> before = new HashSet<>();
		InquiryDto findDto = inquiryDao.selectOne(inquiryDto.getInquiryNo());
		Document doc = Jsoup.parse(findDto.getInquiryContent());//해석
		for(Element el : doc.select(".server-img")) {//태그 찾아서 반복
			String key = el.attr("data-key");//data-key추출
			int attachNo = Integer.parseInt(key);//숫자로 변환
			before.add(attachNo);//저장
		}
		//수정한 글 조사하여 수정 후 이미지 그룹을 조사
				Set<Integer> after = new HashSet<>();
				doc = Jsoup.parse(inquiryDto.getInquiryContent());//해석
				for(Element el : doc.select(".server-img")) {//태그 찾아서 반복
					String key = el.attr("data-key");//data-key 추출
					int attachNo = Integer.parseInt(key);//숫자로 변환
					after.add(attachNo);//저장
				}

				//before에만 있는 번호를 찾아서 모두 삭제
				before.removeAll(after);

				//before에 남은 번호에 대한 이미지를 모두 삭제
				for(int attachNo : before) {
					attachService.remove(attachNo);
				}
				inquiryDao.update(inquiryDto);
				return "redirect:detail?inquiryNo=" + inquiryDto.getInquiryNo();
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