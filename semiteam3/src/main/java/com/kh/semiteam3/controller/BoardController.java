package com.kh.semiteam3.controller;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semiteam3.dao.BoardDao;
import com.kh.semiteam3.dao.MemberDao;
import com.kh.semiteam3.dto.BoardDto;
import com.kh.semiteam3.dto.MemberDto;
import com.kh.semiteam3.service.AttachService;
import com.kh.semiteam3.vo.PageVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/board")
public class BoardController {
		//**게시판에서는 empty string 을 null로 간주하도록 설정
		// 이를 @InitBinder 설정으로 구현
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
		private MemberDao memberDao;//필요해//아이디 존재해야 게시글 작성할 수 있으니까?
		
		@Autowired
		private AttachService attachService;//삭제도 구현되어잇음 파일도 지우고 디비도 지울수 있게끔
		
		
		//게시글작성
		@GetMapping("/write")
		public String write() {//회원 아니면 못들어가게 막아야함//화면으로 넘기는 거니깐 뭐 받을게 없지 않나?
			return "/WEB-INF/views/board/write.jsp";//일단은 작성페이지(jsp)로 가세요!
		}
		@PostMapping("/write")
		public String write(@ModelAttribute BoardDto boardDto, //DTO에는 지금 제목이랑 내용밖에 없어 작성자랑 번호를 알아와야해
							HttpSession session, Model model) {//HttpSession session 필요한 이유는 작성자(회원) 찾기 위해서
			//세션에서 로그인한 사용자의 ID를 추출
			String loginId = (String) session.getAttribute("loginId");//아이디 꺼내와
			
			//아이디를 게시글 정보에 포함시킨다
			boardDto.setBoardWriter(loginId);
			
			int sequence = boardDao.getSequence();//DB에서 시퀀스 번호를 추출(번호 미리 뽑아)
			boardDto.setBoardNo(sequence);//게시글 정보에 추출한 번호를 포함시킨다
			boardDao.insert(boardDto);//등록
			
			return "redirect:detail?boardNo=" + sequence;
		}
		//Paging 처리를 별도의 VO 클래스로 구현
		//(참고) @ModelAttribute에 옵션을 주면 자동으로 모델에 첨부된다
		
		@RequestMapping("/list")
		public String list(
				@ModelAttribute PageVO pageVO,
				Model model) {
			int count = boardDao.count(pageVO);//count는 무조건 있어야 하니깐 vo에 넣어줘야지 model은 안돼
			pageVO.setCount(count);
			model.addAttribute("pageVO",pageVO);
			
			//내가 알려줄테니깐 목록인지 검색인지 니가 판단해 (vo 니가 판단해)컨트롤러에서는 검색인지 아닌지 신경쓰지 않아
			//목록인지 검색인지는 DAO에서 처리하는거임
			List<BoardDto> list = boardDao.selectListByPaging(pageVO);
			model.addAttribute("list",list);//이걸 써도 되고
			
			return "/WEB-INF/views/board/list.jsp";
		}
		//축구 게시판 목록
		@RequestMapping("/footballList")
		public String footballList(
				@ModelAttribute PageVO pageVO,
				Model model) {
			int count = boardDao.count(pageVO);//count는 무조건 있어야 하니깐 vo에 넣어줘야지 model은 안돼
			pageVO.setCount(count);
			model.addAttribute("pageVO",pageVO);
			
			//내가 알려줄테니깐 목록인지 검색인지 니가 판단해 (vo 니가 판단해)컨트롤러에서는 검색인지 아닌지 신경쓰지 않아
			//목록인지 검색인지는 DAO에서 처리하는거임
			List<BoardDto> list = boardDao.selectListByPaging(pageVO);
			model.addAttribute("list",list);//이걸 써도 되고
			
			return "/WEB-INF/views/board/footballList.jsp";
		}
		//농구게시판 목록
		@RequestMapping("/basketballList")
		public String basketballList(
				@ModelAttribute PageVO pageVO,
				Model model) {
			int count = boardDao.count(pageVO);//count는 무조건 있어야 하니깐 vo에 넣어줘야지 model은 안돼
			pageVO.setCount(count);
			model.addAttribute("pageVO",pageVO);
			
			//내가 알려줄테니깐 목록인지 검색인지 니가 판단해 (vo 니가 판단해)컨트롤러에서는 검색인지 아닌지 신경쓰지 않아
			//목록인지 검색인지는 DAO에서 처리하는거임
			List<BoardDto> list = boardDao.selectListByPaging(pageVO);
			model.addAttribute("list",list);//이걸 써도 되고
			
			return "/WEB-INF/views/board/basketballList.jsp";
		}
		//야구 게시판 목록
		@RequestMapping("/baseballList")
		public String baseballList(
				@ModelAttribute PageVO pageVO,
				Model model) {
			int count = boardDao.count(pageVO);//count는 무조건 있어야 하니깐 vo에 넣어줘야지 model은 안돼
			pageVO.setCount(count);
			model.addAttribute("pageVO",pageVO);
			
			//내가 알려줄테니깐 목록인지 검색인지 니가 판단해 (vo 니가 판단해)컨트롤러에서는 검색인지 아닌지 신경쓰지 않아
			//목록인지 검색인지는 DAO에서 처리하는거임
			List<BoardDto> list = boardDao.selectListByPaging(pageVO);
			model.addAttribute("list",list);//이걸 써도 되고
			
			return "/WEB-INF/views/board/baseballList.jsp";
		}
		//게임 게시판 목록
		@RequestMapping("/esportsList")
		public String esportsListist(
				@ModelAttribute PageVO pageVO,
				Model model) {
			int count = boardDao.count(pageVO);//count는 무조건 있어야 하니깐 vo에 넣어줘야지 model은 안돼
			pageVO.setCount(count);
			model.addAttribute("pageVO",pageVO);
			
			//내가 알려줄테니깐 목록인지 검색인지 니가 판단해 (vo 니가 판단해)컨트롤러에서는 검색인지 아닌지 신경쓰지 않아
			//목록인지 검색인지는 DAO에서 처리하는거임
			List<BoardDto> list = boardDao.selectListByPaging(pageVO);
			model.addAttribute("list",list);//이걸 써도 되고
			
			return "/WEB-INF/views/board/esportsList.jsp";
		}
		//공지 게시판 목록
		@RequestMapping("/adminList")
		public String adminList(
				@ModelAttribute PageVO pageVO,
				Model model) {
			int count = boardDao.count(pageVO);//count는 무조건 있어야 하니깐 vo에 넣어줘야지 model은 안돼
			pageVO.setCount(count);
			model.addAttribute("pageVO",pageVO);
			
			//내가 알려줄테니깐 목록인지 검색인지 니가 판단해 (vo 니가 판단해)컨트롤러에서는 검색인지 아닌지 신경쓰지 않아
			//목록인지 검색인지는 DAO에서 처리하는거임
			List<BoardDto> list = boardDao.selectListByPaging(pageVO);
			model.addAttribute("list",list);//이걸 써도 되고
			
			return "/WEB-INF/views/board/adminList.jsp";
		}
		
		//게시글상세
		@RequestMapping("/detail")
		public String detail(@RequestParam int boardNo, 
							Model model) {
			//boardDao.updateBoardReadcount(boardNo);//조회수 중복방지 이거를 인터셉터에 만들어놨잖아 여기서 또 쓰면 막 늘어나는거지....안막히고
			
			BoardDto boardDto = boardDao.selectOne(boardNo);
			model.addAttribute("boardDto", boardDto);
			
			//조회한 게시글 정보에 있는 회원 아이디로 작성자!(회원) 정보를 불러와서 첨부
			if(boardDto.getBoardWriter() != null) {//작성자가 탈퇴하지 않았다면
				MemberDto memberDto = memberDao.selectOne(boardDto.getBoardWriter());//작성자!에대한 정보를 불러와서 멤버에 넣는거
				model.addAttribute("memberDto",memberDto);//화면단에 보내줘 이러면 멤버 다 조회되니까 닉네임이던 레벨이던 다 찍을 수 잇는거임
			}
			return "/WEB-INF/views/board/detail.jsp";
		}
		//게시글수정
		@GetMapping("/edit")
		public String edit(@RequestParam int boardNo, Model model) {//글번호가 있어야 화면 띄울수 있다/ 모델로 정보들 보여주겟다
			BoardDto boardDto = boardDao.selectOne(boardNo);//게시글번호조회
			model.addAttribute("boardDto", boardDto);//화면에 넘겨
			return "/WEB-INF/views/board/edit.jsp";
			
		}
		@PostMapping("/edit")
		public String edit(@ModelAttribute BoardDto boardDto) {
			//수정 전, 후를 비교하여 사라진 이미지를 찾아 삭제
			//- 수정 전 이미지 그룹과 수정 후 이미지의 차집합(Set 사용)
			
			//기존 글 조회하여 수정 전 이미지 그룹을 조사
			Set<Integer> before = new HashSet<>();//이전 상태 담는곳
			BoardDto findDto = boardDao.selectOne(boardDto.getBoardNo());
			Document doc = Jsoup.parse(findDto.getBoardContent());//해석
			for(Element el : doc.select(".server-img")) {
				String key = el.attr("data-key");
				int attachNo = Integer.parseInt(key);//수정에서는 이 이미지가 지워져야하는건지 유지되어야하는건지 몰라
				before.add(attachNo);//그래서 before에 일단 담아둬 *저장*해
			}
			//수정한 글 조사하여 수정 후 이미지 그룹을 조사하겠다
			Set<Integer> after = new HashSet<>();//이후 수정한 상태 담는 곳 
			doc = Jsoup.parse(boardDto.getBoardContent());//해석(다시 담아)
			for(Element el : doc.select(".server-img")) {//태그 찾아서 반복
				String key = el.attr("data-key");//data-key 추출
				int attachNo = Integer.parseInt(key);//숫자로 변환
				after.add(attachNo);//저장
			}
			//before에만 있는 *번호*를 찾아서 모두 삭제
			before.removeAll(after);//before랑 after겹치는거 다 날라갈 수 있어
			
			//before에 남은 번호에 대한 *이미지*를 모두 삭제
			for(int attachNo : before) {
				attachService.remove(attachNo);
			}
			
			//BoardDto 잇다고 No가 자동으로 생기는거아니야 헷갈리지마 화면단에서 받아와야 있는거임 그래서 hidden으로 써놓는거고
			boardDao.update(boardDto);
			return "redirect:detail?boardNo="+boardDto.getBoardNo();//수정한 게시글 번호 상세로 이동
		}
		//게시글삭제(jsp x)
		//만약에 비밀번호 받으려면 겟 포스트 만들어서 회원탈퇴 햇던것처럼 만들면 되지
		@GetMapping("/delete")
		public String delete(@RequestParam int boardNo) {
			//(summernote 관련 추가할 내용)
			//- 글을 지우면 첨부파일이 좀비가 된다
			//- 글과 첨부파일이 연결되어 있지 않다
			//- 글 내용을 찾아서 사용된 이미지 번호를 뽑아 모두 삭제하도록 구현
			//- DB를 활용하는 것이 아닌 프로그래밍으로 처리하는 방식
			//- 글 안에 있는 <img>중에 .server-img를 찾아서 data-key를 읽어서 삭제
			//- (문제점)JAVA에서 HTML 구조를 탐색(해석)할 수 있나? OK!(=>Jsoup이라는 라이브러리)
			BoardDto boardDto = boardDao.selectOne(boardNo);
			
			//*Jsoup* 으로 내용을 탐색하는 과정
			Document document = Jsoup.parse(boardDto.getBoardContent());//게시글 내용을 탐색해달라!
			Elements elements = document.select(".server-img");//태그찾기 자료형은 select에 마우스 갖다 대면 나와 Elements가 뭔진 몰라도 돼...
																//Element에 태그가 몇개 있겠지
			for(Element element : elements) {//반복문으로 한개씩 처리
				String key = element.attr("data-key");//data-key 속성을 읽어라! 자료형은 String
				int attachNo = Integer.parseInt(key);//숫자로 변환
				attachService.remove(attachNo);//파일 삭제 + DB삭제
			}
			
			boardDao.delete(boardNo);//그러고 나서 게시글을 지워라
			return "redirect:list";
		}
}


























