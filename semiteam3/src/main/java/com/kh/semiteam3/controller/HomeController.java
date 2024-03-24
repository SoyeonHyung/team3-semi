package com.kh.semiteam3.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.semiteam3.dao.BoardDao;
import com.kh.semiteam3.dao.MemberDao;
import com.kh.semiteam3.dto.BoardDto;
import com.kh.semiteam3.dto.MemberDto;
import com.kh.semiteam3.vo.PageVO;

import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		//binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
		// new StringTrimmerEditor(true)문자열을 자르는 편집도구를 사용하여라 문자열에 대해서(String.class)를
		//이걸 사용하면 이 컨트롤러 내에서 empty string 을 null로 간주하도록 설정된다
		binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
	}
	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private MemberDao memberDao;
	

	@RequestMapping("/")
	public String home(@ModelAttribute PageVO pageVO,
										Model model) {
		
	    List<BoardDto> footballList = boardDao.boardStatus(pageVO, "축구", "recruiting");
	    List<BoardDto> baseballList = boardDao.boardStatus(pageVO, "야구", "recruiting");
	    List<BoardDto> basketballList = boardDao.boardStatus(pageVO, "농구", "recruiting");
	    List<BoardDto> ESportsList = boardDao.boardStatus(pageVO, "E-스포츠", "recruiting");
	    
	    
	    for (BoardDto boardDto : footballList) {
	        MemberDto memberDto = memberDao.selectOne(boardDto.getBoardWriter());
	        if (memberDto != null) {
	            boardDto.setBoardWriter(memberDto.getMemberNick());
	        } else {
	            boardDto.setBoardWriter("탈퇴한사용자");
	        }
	    }
	    
	    for (BoardDto boardDto : baseballList) {
	        MemberDto memberDto = memberDao.selectOne(boardDto.getBoardWriter());
	        if (memberDto != null) {
	            boardDto.setBoardWriter(memberDto.getMemberNick());
	        } else {
	            boardDto.setBoardWriter("탈퇴한사용자");
	        }
	    }
	    
	    for (BoardDto boardDto : basketballList) {
	        MemberDto memberDto = memberDao.selectOne(boardDto.getBoardWriter());
	        if (memberDto != null) {
	            boardDto.setBoardWriter(memberDto.getMemberNick());
	        } else {
	            boardDto.setBoardWriter("탈퇴한사용자");
	        }
	    }
	    
	    for (BoardDto boardDto : ESportsList) {
	        MemberDto memberDto = memberDao.selectOne(boardDto.getBoardWriter());
	        if (memberDto != null) {
	            boardDto.setBoardWriter(memberDto.getMemberNick());
	        } else {
	            boardDto.setBoardWriter("탈퇴한사용자");
	        }
	    }
		
		model.addAttribute("footballList", footballList);
		model.addAttribute("baseballList", baseballList);
		model.addAttribute("basketballList", basketballList);
		model.addAttribute("ESportsList", ESportsList);
		
		return "/WEB-INF/views/home.jsp";
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
