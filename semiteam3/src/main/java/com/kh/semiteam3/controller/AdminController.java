package com.kh.semiteam3.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.semiteam3.dao.MemberDao;
import com.kh.semiteam3.dao.ReportBoardDao;
import com.kh.semiteam3.dto.MemberDto;

import jakarta.servlet.http.HttpSession;
//관리자가 이용할 수 있는 기능을 제공하는 컨트롤러
@Controller
@RequestMapping("/admin")
public class AdminController implements HandlerInterceptor{
	
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private ReportBoardDao reportBoardDao;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	
		
	/*	일단 회원만 복붙했습니다
	//회원통계
		@RequestMapping("/stat/member")
		public String statmember(Model model) {
			List<StatVO> list = memberDao.statByType();
			model.addAttribute("list", list);
			return "/WEB-INF/views/admin/stat/member.jsp";
	}
	*/
	//회원 검색
		@RequestMapping("/member/search")
		public String memberList(@RequestParam(required=false)String column,
								@RequestParam(required=false)String keyword,
								Model model) {
			//컬럼과 키워드가 없어도 목록 출력 가능
			boolean isSearch = column !=null && keyword != null;
			
//			List<MemberDto> list = isSearch ?
//					memberDao.searchList(column, keyword) : memberDao.selectList();
//			model.addAttribute("list", list);
			if(isSearch) {//so, 이게 다야 코드가
				//지정한 항목에서만 검색이 가능하도록 구현(비밀번호로 들어가게 하면 안되자나)
				switch(column) {
				//case "member_id","member_nick","member_contact","member_email","member_birth"
				case "member_id" :
				case "member_nick" :
				case "member_contact":
				case "member_email":
				case "member_birth":
					List<MemberDto> list = memberDao.searchList(column, keyword);
					model.addAttribute("list", list);
				}
			}
			return "/WEB-INF/views/admin/member/search.jsp";
		}
	
		
		@RequestMapping("/member/detail")
		public String memberDetail(@RequestParam String memberId, Model model) {
			MemberDto memberDto = memberDao.selectOne(memberId);
			model.addAttribute("memberDto", memberDto);
			
			int reporterCountByMemberId = reportBoardDao.reporterCountByMemberId(memberId);
			model.addAttribute("reporterCountByMemberId", reporterCountByMemberId);
			
			int reporteeCountByMemberId = reportBoardDao.reporteeCountPostsByMemberId(memberId);
			model.addAttribute("reporteeCountByMemberId", reporteeCountByMemberId);
			
			return "/WEB-INF/views/admin/member/detail.jsp";
		}
		
		@GetMapping("/member/delete")
		public String memberDelete(@RequestParam String memberId) {
			memberDao.withdraw(memberId);
			return "redirect:search";
		}
		
		@GetMapping("/member/edit")
		public String edit(@RequestParam String memberId, Model model) {
			MemberDto memberDto = memberDao.selectOne(memberId);
			model.addAttribute("memberDto", memberDto);
			return "/WEB-INF/views/admin/member/edit.jsp";
		}
		
		@PostMapping("/member/edit")
		public String memberEdit(@ModelAttribute MemberDto memberDto) {
			memberDao.updateMemberByAdmin(memberDto);
			return "redirect:detail?memberId="+memberDto.getMemberId();			
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

		

















