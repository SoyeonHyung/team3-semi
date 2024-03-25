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
        String loginId = (String)session.getAttribute("loginId"); // 사용자 아이디 추출
        
        // 만약 로그인 아이디가 없다면 (즉, 멤버가 아닌 경우)
        if (loginId == null) {
            return true;
        } else {
        	response.sendRedirect("/");
            return false;
        }
        
    }
}
