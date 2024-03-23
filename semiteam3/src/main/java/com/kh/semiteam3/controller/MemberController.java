package com.kh.semiteam3.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.semiteam3.dao.AttachDao;
import com.kh.semiteam3.dao.MemberDao;
import com.kh.semiteam3.dto.AttachDto;
import com.kh.semiteam3.dto.MemberDto;
import com.kh.semiteam3.service.AttachService;
import com.kh.semiteam3.service.EmailService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private AttachDao attachDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private AttachService attachService;
	
	@Autowired
	private EmailService emailService;
	
	
	//회원가입 페이지
	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/views/member/join.jsp";
	}
	
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto,
							@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		
		memberDao.insert(memberDto);
		
		//첨부파일 등록
		if(!attach.isEmpty()) {
			int attachNo = attachService.save(attach); //파일저장 + DB저장
			
			//주인공이 되는곳에 구현하는게 좋음
			memberDao.connect(memberDto.getMemberId(), attachNo); //연결
		}
		
		//가입 환영 메일 발송
		emailService.sendWelcomeMail(memberDto.getMemberEmail());
		
		return "redirect:/";
	}
	
	
	@RequestMapping("/joinFinish")
	public String joinFinish() {
		return "/WEB-INF/views/member/joinFinish.jsp";
	}
	
	//로그인 페이지
	@GetMapping("/login")
	public String login(HttpServletRequest request, Model model, HttpSession session) {
	    String referer = request.getHeader("referer");
	    model.addAttribute("referer", referer);

	    String loginId = (String)session.getAttribute("loginId");

	    if (loginId != null) {
	        // 이미 로그인된 상태라면 홈 페이지로 리다이렉트합니다.
	        return "redirect:/";
	    } else {
	        // 로그인 페이지를 반환합니다.
	        return "/WEB-INF/views/member/login.jsp";
	    }
	}
	
	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto inputDto, HttpSession session, @RequestParam(value = "referer", required = false) String referer) {

		MemberDto findDto = memberDao.selectOne(inputDto.getMemberId()); 

		//로그인 가능한지
		boolean isValid = findDto != null && inputDto.getMemberPw().equals(findDto.getMemberPw());
		
	    if (isValid) {
	        // 로그인 성공 시
	        session.setAttribute("loginId", findDto.getMemberId());
	        session.setAttribute("loginGrade", findDto.getMemberGrade());
	        session.setAttribute("loginNick", findDto.getMemberNick());

	        if (referer != null && !referer.isEmpty()) {
	            return "redirect:" + referer;
	        } else {
	            return "redirect:/";
	        }
	    } else {
	        // 로그인 실패 시
	        return "redirect:login?error";
	    }
	}
	
	//로그아웃 페이지
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("loginId"); //세션의 값 삭제
		session.removeAttribute("loginGrade"); //세션의 값 삭제
		
		return "redirect:/"; //홈화면으로 리다이렉트(or 원래있던 화면으로? -> 만약 회원만 가능한곳이라면 홈으로되게..?)
	}
	
	
	//마이페이지 
	@RequestMapping("/mypage")
	public String mypage(	HttpSession session, Model model) {

		String loginId = (String)session.getAttribute("loginId");
		
		MemberDto memberDto = memberDao.selectOne(loginId);
		
		model.addAttribute("memberDto", memberDto);
		
		return "/WEB-INF/views/member/mypage.jsp";
	}
	
	
	//비밀번호 변경
	@GetMapping("/password")
	public String password(){
		return "/WEB-INF/views/member/password.jsp";
	}
		
	@PostMapping("/password")
	public String password(@RequestParam String originPw,
										@RequestParam String changePw,
										HttpSession session) {
		//로그인된 사용자의 아이디를 추출
		String loginId = (String)session.getAttribute("loginId");
		
		//비밀번호 검사를 위해 DB에 저장된 정보를 불러온다
		MemberDto findDto = memberDao.selectOne(loginId);
		
		boolean isValid = findDto.getMemberPw().equals(originPw);
		String regexPattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*()-_=+[{]};:.,<>]).{8,}$";

		boolean isValidChangePw = changePw.matches(regexPattern);

		
		if(isValid) {//입력한 기존 비밀번호가 유효할 경우
			 // 추가: 새 비밀번호 형식 검사
	        if (!isValidChangePw) {
	            return "redirect:password?formatError";
	        }
	        else if(changePw.equals(originPw)) {
	        	return "redirect:password?equalsError";
	        }
			
			MemberDto memberDto = new MemberDto();
			
			memberDto.setMemberId(loginId);
			memberDto.setMemberPw(changePw);
			memberDao.updateMemberPw(memberDto);
			
			return "redirect:passwordFinish";
		}
		else {//입력한 기존 비밀번호가 유효하지 않을 경우
			return "redirect:password?originError";
		}
	}
		
		
	@RequestMapping("/passwordFinish")
	public String passwordFinish() {
		return "/WEB-INF/views/member/passwordFinish.jsp";
	}
	
	//개인정보 변경 페이지
	@GetMapping("/edit")
	public String edit(HttpSession session, Model model) {
		//사용자 아이디를 세션에서 추출
		String loginId = (String)session.getAttribute("loginId");
		
		//아이디로 정보 조회
		MemberDto memberDto = memberDao.selectOne(loginId);
		
		//모델에 정보 추가
		model.addAttribute("memberDto", memberDto);
		
		return "/WEB-INF/views/member/edit.jsp";
	}
	
	
	@PostMapping("/edit")
	public String edit(@ModelAttribute MemberDto memberDto, HttpSession session, 
			 			@ModelAttribute AttachDto attachDto) {
		//세션에서 아이디 추출
		String loginId = (String)session.getAttribute("loginId");
		
		//memberDto에 아이디 설정
		memberDto.setMemberId(loginId);
		
		//DB정보 조회
		MemberDto findDto = memberDao.selectOne(loginId);

		//판정
		boolean isValid = memberDto.getMemberPw().equals(findDto.getMemberPw());
		
		if(isValid) {
	        // 회원 정보 업데이트
	        memberDto.setMemberId(loginId);
	        memberDao.updateMember(memberDto);
	        
	        // 이미지 정보 업데이트
	        if (attachDto != null) {
	            attachDao.update(attachDto);
	        }
	        
			// 최신화된 닉네임을 세션에 설정
		    session.setAttribute("loginNick", memberDto.getMemberNick());
		    
	        return "redirect:mypage";
	    }
	    else {
	        // 이전 페이지로 리다이렉트
	        return "redirect:edit?error";
	    }
	}
	
	//회원 탈퇴 페이지
	@GetMapping("/exit")
	public String exit() {
		return "/WEB-INF/views/member/exit.jsp";
	}
	@PostMapping("/exit")
	public String exit(@RequestParam String memberPw, HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		
		MemberDto findDto = memberDao.selectOne(loginId);
		boolean isValid = findDto.getMemberPw().equals(memberPw);
		
		if(isValid) {
			//회원 탈퇴 전에 프로필 번호를 찾아서 삭제처리를 해야함
			try { //프로필사진이 없는경우
				int attachNo = memberDao.findAttachNo(loginId);
				attachService.remove(attachNo); //파일삭제 + DB 삭제
			}
			catch(Exception e) {
				e.printStackTrace();
			}
			
			memberDao.withdraw(loginId); //회원탈퇴
			session.removeAttribute("loginId");//로그아웃
			return "redirect:exitFinish"; 
		}
		else {
			return "redirect:exit?error";
		}
	}
	
	@RequestMapping("/exitFinish")
	public String exitFinish() {
		return "/WEB-INF/views/member/exitFinish.jsp";
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
	
	//아이디 찾기
	@GetMapping("/findId")
	public String findId() {
		return "/WEB-INF/views/member/findId.jsp";
	}
	
	@PostMapping("/findId")
	public String findId(@RequestParam String memberNick) {
		boolean result =  emailService.sendMemberId(memberNick);
		if(result) {
			return "redirect:findIdSuccess";
		}
		else {
			return "redirect:findIdFail";
		}
	}
	
	@RequestMapping("/findIdSuccess")
	public String findIdSuccess() {
		return "/WEB-INF/views/member/findIdSuccess.jsp";
	}
	
	//찾기 실패하면 ?error 로 만들지????말지 ?? 
	@RequestMapping("/findIdFail")
	public String findIdFail() {
		return "/WEB-INF/views/member/findIdFail.jsp";
	}
	
	
	//비밀번호 찾기 페이지
	@GetMapping("/findPw")
	public String findPw() {
		return "/WEB-INF/views/member/findPw.jsp";
	}
	
	@PostMapping("/findPw")
	public String findPw(@ModelAttribute MemberDto memberDto) {
	
		MemberDto findDto = memberDao.selectOne(memberDto.getMemberId());
	
	
		//아이디가 있으면서 이메일까지 일치
		boolean sendPwOk = findDto != null && findDto.getMemberEmail().equals(memberDto.getMemberEmail());
		if(sendPwOk) {
			emailService.sendTempPassword(findDto);
			return "redirect:findPwSuccess";
		}
		else {
			return "redirect:findPwFail";
		}
	}
	@RequestMapping("/findPwSuccess")
	public String findPwSuccess() {
		return "/WEB-INF/views/member/findPwSuccess.jsp";
	}
	@RequestMapping("/findPwFail")
	public String findPwFail() {
		return "/WEB-INF/views/member/findPwFail.jsp";
	}
	
	
	

	
}
