
package com.kh.semiteam3.interceptor;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
public class AdminInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession();//객체 꺼냄
		String loginGrade = (String)session.getAttribute("loginGrade");//등급 확인
		boolean isAdmin  = loginGrade != null && loginGrade.equals("관리자");//admin 판정
		
		if(isAdmin) {
			return true;
		}
		else {
//			response.sendError(403);
			response.sendRedirect("/member/login"); //로그인 페이지로
			return false;
		}
		
	}

	
}
