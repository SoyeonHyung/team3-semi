package com.kh.semiteam3.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.semiteam3.interceptor.AdminInterceptor;
import com.kh.semiteam3.interceptor.BoardViewInterceptor;
import com.kh.semiteam3.interceptor.MemberInterceptor;
import com.kh.semiteam3.interceptor.NonMemberInterceptor;

@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer{
	
	@Autowired
	private MemberInterceptor memberInterceptor;
	@Autowired
	private AdminInterceptor adminInterceptor;
	@Autowired
	private BoardViewInterceptor boardViewInterceptor;
	@Autowired
	private NonMemberInterceptor NonMemberInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		registry.addInterceptor(memberInterceptor)
					.addPathPatterns(
							"/member/**",
							"/inquiry/**",
							"/board/**"
							)
					.excludePathPatterns(
							"/member/join*",
							"/member/login","/member/find*","/member/exitFinish",
							"/board/list*","/board/detail*"
							);
		
		// 관리자 인터셉터 등록

		registry.addInterceptor(adminInterceptor)
						.addPathPatterns(
								"/admin/**",
								"/reportBoard/**",
								"/board/list?category=관리자"
								)
						.excludePathPatterns(
								"/reportBoard/insert*"
								);
		
		//게시글 조회수 중복방지 인터셉터 등록
		registry.addInterceptor(boardViewInterceptor)
													.addPathPatterns("/board/detail");
		
		//비로그인시 접근 제한
		registry.addInterceptor(NonMemberInterceptor)
		.addPathPatterns("/board/write");
	
	}	

}
