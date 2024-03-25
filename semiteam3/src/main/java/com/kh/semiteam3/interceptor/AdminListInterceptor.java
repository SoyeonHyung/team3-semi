package com.kh.semiteam3.interceptor;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
public class AdminListInterceptor implements HandlerInterceptor{

	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {

        HttpSession session = request.getSession();
        String loginGrade = (String) session.getAttribute("loginGrade");
        boolean isAdmin = "관리자".equals(loginGrade);

        // 여기서 'category' 파라미터를 가져옵니다.
        String category = request.getParameter("category");
        // 카테고리가 '관리자'인지 확인합니다.
        boolean isCategoryAdmin = "관리자".equals(category);

        // 카테고리가 '관리자'인 경우에만 접근을 허용합니다.
        if (isCategoryAdmin) {
            // 카테고리가 관리자인 경우에는 로그인한 사용자가 관리자인지 확인하여 접근을 허용 또는 거부합니다.
            if (isAdmin) {
                return true; // 관리자이면 접근 허용
            } else {
//                response.sendError(403); // 관리자가 아닌 경우에는 접근 거부
    			response.sendRedirect("/member/login"); //로그인 페이지로
                return false;
            }
        } else {
            // 카테고리가 관리자가 아닌 경우에는 모든 사용자에게 접근을 허용합니다.
            return true;
        }
    }
}
