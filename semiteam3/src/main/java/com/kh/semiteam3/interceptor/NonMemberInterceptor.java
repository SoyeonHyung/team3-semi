package com.kh.semiteam3.interceptor;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
public class NonMemberInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        
        HttpSession session = request.getSession(); // 세션 객체 가져오기
        String loginId = (String) session.getAttribute("loginId"); // 사용자 아이디 추출
        
        // 만약 로그인 아이디가 없다면 (즉, 멤버가 아닌 경우)
        if (loginId == null) {
            // 현재 페이지 URL을 세션에 저장
        	String previousUrl = request.getHeader("referer"); // 이전 페이지의 URL을 가져옴
            session.setAttribute("previousUrl", previousUrl);
            // 로그인 페이지로 리다이렉트하고 접근 거부
            response.sendRedirect("/member/login");
            return false;
        } else {
            // 멤버인 경우 접근 허용
            return true;
        }
        
    }
}