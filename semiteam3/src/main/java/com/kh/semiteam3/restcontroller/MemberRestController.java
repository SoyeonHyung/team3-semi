package com.kh.semiteam3.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semiteam3.dao.CertDao;
import com.kh.semiteam3.dao.MemberDao;
import com.kh.semiteam3.dto.CertDto;
import com.kh.semiteam3.dto.MemberDto;
import com.kh.semiteam3.service.EmailService;

@RestController
@RequestMapping("/rest/member")
public class MemberRestController {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private EmailService emailService;
	
	
	//DB에 동일한 아이디 있는 지 없는지 체크
	@RequestMapping("/checkId")
	public String checkId(@RequestParam String memberId) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		
		if(memberDto == null) {
			return "able";//사용 가능한 경우(DB에 없는 경우)
		}
		else {
			return "unable";//사용 불가능한 경우(DB에 있는 경우)
		}
	}
	
	//멤버 닉네임 중복체크
	@RequestMapping("/checkMemberNick")
    public boolean checkMemberNick(@RequestParam String memberNick) {
        MemberDto memberDto = memberDao.selectOneByMemberNick(memberNick);
        return memberDto == null;
	}
	
	// 이메일 인증을 위한 페이지
    @RequestMapping("/sendCert")
    public void sendCert(@RequestParam String memberEmail) {
        MemberDto memberDto = memberDao.selectOne(memberEmail);//memberEmail에 있는지 찾기 없으면 null이 뜰것임
        if (memberDto == null) {
            // 중복된 이메일이 없는 경우에만 이메일을 보내기
            emailService.sendCert(memberEmail);
        }
    }

	@Autowired
	private CertDao certDao;
	
	//메일 인증
	@RequestMapping("/checkCert")
	public boolean checkCert(@ModelAttribute CertDto certDto) {
		boolean isValid = certDao.checkValid(certDto);
		if(isValid) { //인증 성공 시 인증번호 삭제
			certDao.delete(certDto.getCertEmail());
		}
		return isValid;
	}	
}