package com.kh.semiteam3.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	//메인페이지는 가장 짧은주소로 서비스
	//- 공용주소를 부여하지 않고 /로 주소를 설정
	@RequestMapping("/")
	public String home() {
		return "/WEB-INF/views/home.jsp";
	}
}
