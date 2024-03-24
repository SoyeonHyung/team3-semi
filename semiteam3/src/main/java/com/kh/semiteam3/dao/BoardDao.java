package com.kh.semiteam3.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiteam3.dto.BoardDto;
import com.kh.semiteam3.mapper.BoardListMapper;
import com.kh.semiteam3.mapper.BoardMapper;
import com.kh.semiteam3.mapper.BoardWithNicknameMapper;
import com.kh.semiteam3.vo.PageVO;

@Repository
public class BoardDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private BoardMapper boardMapper;
	@Autowired
	private BoardListMapper boardListMapper;
	@Autowired
	private BoardWithNicknameMapper boardWithNicknameMapper;
	
	//커뮤니티 게시글 작성(등록)
	public void insert(BoardDto boardDto) {//**마감시간 처리방법 생각해보기
		//게시글번호-시퀀스/제목/내용/카테고리/작성자/마감시간
		String sql = "insert into board"
					+ "("
					+ "board_no, board_title, board_content, "
					+ "board_category, board_writer, board_limit_time"
					+ ") "
					+ "values"
					+ "(?, ?, ?, ?, ?, to_date(?, 'YYYY-MM-DD HH24:MI'))";
		Object[] data = {
				boardDto.getBoardNo(),
				boardDto.getBoardTitle(), boardDto.getBoardContent(),
				boardDto.getBoardCategory(), boardDto.getBoardWriter(),
				boardDto.getBoardLimitTime()
		};
		jdbcTemplate.update(sql, data);
	}
	public int getSequence() {
		String sql = "select board_seq.nextval from dual";
		//jdbcTemplate.queryForObject(구문, 결과자료형);
		return jdbcTemplate.queryForObject(sql, int.class);//내가 실행할 구문을 인트로 실행해라
	}

	
	//통합 페이징(목록 + 검색)--목록에 카테고리 띄울껀가요? 어차피 각각 나눠져서 보여질껀데
	public List<BoardDto> selectListByPaging(PageVO pageVO){
		if(pageVO.isSearch()) {//게시글 검색
			String sql = "select * from("
							+ "select rownum rn, TMP.* from("
							+ "select "
								+ "board_no, board_title, board_reply, board_writer, "
								+ "board_write_time, board_limit_time, "
								+ "board_view, board_like "
							+ "from board "
							+ "where instr("+pageVO.getColumn()+", ?) > 0 "
							+ "order by board_no desc"
							+ ")TMP"
							+ ") where rn between ? and ?";
			Object[] data = {
					pageVO.getKeyword(),
        			pageVO.getBeginRow(), 
        			pageVO.getEndRow()
			};
			return jdbcTemplate.query(sql, boardListMapper, data);
		}
		else {//게시글 목록--카테고리 별로 구현하는 법
			String sql = "select * from("
							+ "select rownum rn, TMP.* from("
							+ "select "
								+ "board_no, board_title, board_reply, board_writer,"
								+ "board_write_time, board_limit_time, "
								+ "board_view, board_like "
							+ "from board order by board_no desc"
							+ ")TMP"
							+ ") where rn between ? and ?";
			Object[] data = {
					pageVO.getBeginRow(), 
        			pageVO.getEndRow()
			};
			return jdbcTemplate.query(sql, boardListMapper, data);
		}
	}
	
	//카테고리별로 게시판 조회(목록) + 페이징
    public List<BoardDto> selectByCategoryAndPaging(PageVO pageVO, 
                                                            String boardCategory){
        
    	if(pageVO.isSearch()) { //검색
    	    String sql = "select * from (" 
    	                + "select rownum rn, TMP.* from ("
    	                + "select board_no, board_title, board_reply, board_writer, board_write_time, board_limit_time, "
    	                + "board_view, board_like, board_category  from board  "
    	                + "where board_category = ? "
    	                + "and (board_writer is null or board_writer in (select member_id from member "
    	                + "where member_grade != '관리자')) and instr(" + pageVO.getColumn() + ", ?) > 0  "
    	                + "order by board_no desc) TMP) " 
    	                + "where rn between ? and ?";
    	    Object[] data = {pageVO.getCategory(), pageVO.getKeyword(), pageVO.getBeginRow(), pageVO.getEndRow()};
    	    return jdbcTemplate.query(sql, boardListMapper, data);
    	}
        
        
        else {//목록
        	String sql = "select * from (" 
        				+ "select rownum rn, TMP.* from (" 
        				+ "select board_no, board_title, board_reply, board_writer, board_write_time, " 
        				+ "board_limit_time, board_view, board_like, board_category " 
        				+ "from board where (board_writer is null or board_writer in (select member_id from member "
        				+ "where member_grade != '관리자')) " 
        				+ "and board_category = ? "
        				+ "order by board_no desc) TMP) " 
        				+ "where rn between ? and ?";
            Object[] data= {pageVO.getCategory(), 
                                    pageVO.getBeginRow(), pageVO.getEndRow()};
            return jdbcTemplate.query(sql, boardListMapper, data);
        }
    }
    
    //디테일에서 리스트찍어내려고 만든 것
    public List<BoardDto> selectByCategoryForDetail(PageVO pageVO, 
            String boardCategory){
    	String sql = "select * from (" 
				+ "select rownum rn, TMP.* from (" 
				+ "select board_no, board_title, board_reply, board_writer, board_write_time, " 
				+ "board_limit_time, board_view, board_like, board_category " 
				+ "from board where (board_writer is null or board_writer in (select member_id from member "
				+ "where member_grade != '관리자')) " 
				+ "and board_category = ? order by board_no desc) TMP) " 
				+ "where rn between ? and ?";
        Object[] data= {boardCategory, 
                                pageVO.getBeginRow(), pageVO.getEndRow()};
        return jdbcTemplate.query(sql, boardListMapper, data);
    }
    

    //닉네임으로 검색
    public List<BoardDto> selectByNick(PageVO pageVO, String boardCategory) {
        // 검색
        	String sql = "SELECT * FROM ("
        	           + "SELECT ROWNUM rn, TMP.* FROM ("
        	           + "SELECT board_no, board_title, board_reply, board_writer,"
        	           + "board_write_time, board_limit_time,"
        	           + "board_view, board_like "
        	           + "FROM board b "
        	           + "JOIN member m ON b.board_writer = m.member_id "
        	           + "WHERE board_category = ? AND INSTR(m.member_nick, ?) > 0 "
        	           + "ORDER BY board_no DESC "
        	           + ") TMP"
        	           + ") WHERE rn BETWEEN ? AND ?";
            Object[] data = {boardCategory, pageVO.getKeyword(), pageVO.getBeginRow(), pageVO.getEndRow()};
            return jdbcTemplate.query(sql, boardListMapper, data);
    }

    //카테고리별로 모집중인 게시글만 보기 버튼추가하려고..
    public List<BoardDto> boardStatus(PageVO pageVO, String boardCategory, String boardStatus) {
        if ("recruiting".equals(boardStatus) && pageVO.isOnlyRecruitingAndSearch()) { // 모집중인 게시글 중에서 검색하는 경우
        	String sql = "select * from ("
                    + "select rownum rn, TMP.* from ("
                        + "select "
                            + "board_no, board_title, board_reply, board_writer,"
                            + "board_write_time, board_limit_time, "
                            + "board_view, board_like "
                        + "from board "
                        + "where board_category = ? "
                            + "and board_limit_time > sysdate " // 현재 시간 이후인 경우만 모집중으로 간주
                            + "and instr(" + pageVO.getColumn() + ", ?) > 0" // 검색어와 일치하는 경우만 필터링
                        + "order by board_no desc"
                    + ") TMP"
                + ") where rn between ? and ?";
            Object[] data = {boardCategory, pageVO.getKeyword(), pageVO.getBeginRow(), pageVO.getEndRow()};
            return jdbcTemplate.query(sql, boardListMapper, data);
        } 
        else { //목록
            String sql = "select * from("
                    + "select rownum rn, TMP.* from("
                    + "select "
                        + "board_no, board_title, board_reply, board_writer,"
                        + "board_write_time, board_limit_time, "
                        + "board_view, board_like "
                    + "from board where board_category = ? "
                    	+ "and board_limit_time > sysdate "
                    + "order by board_no desc"
                    + ")TMP"
                    + ") where rn between ? and ?";
            Object[] data= {boardCategory, 
                                    pageVO.getBeginRow(), pageVO.getEndRow()};
            return jdbcTemplate.query(sql, boardListMapper, data);
        }
    	
    }
    
	
 // 통합 페이지 카운트(목록 + 검색 + 모집중인 게시글)
    public int count(PageVO pageVO) {
        if (pageVO.isSearch()) {// 검색
        	String sql = "select count(*) from board "
        			+ "where (board_writer is null or board_writer in (select member_id from member "
        			+ "where member_grade != '관리자')) "
        			+ "and board_category = ? and instr(" + pageVO.getColumn() + ", ?) > 0";

            if (pageVO.isOnlyRecruiting()) { // 모집중인 게시글만 필터링
                sql += " and board_limit_time > sysdate"; // 현재 시간 이후인 경우만 모집중으로 간주
            }
            Object[] data = { pageVO.getCategory(), pageVO.getKeyword() };
            return jdbcTemplate.queryForObject(sql, int.class, data);
        } else {// 목록
        	String sql = "select count(*) from board "
        			+ "where (board_writer is null or board_writer in (select member_id from member "
        			+ "where member_grade != '관리자')) "
        			+ "and board_category = ?";

            if (pageVO.isOnlyRecruiting()) { // 모집중인 게시글만 필터링
                sql += " and board_limit_time > sysdate"; // 현재 시간 이후인 경우만 모집중으로 간주
            }
            Object[] data = { pageVO.getCategory() };
            return jdbcTemplate.queryForObject(sql, int.class, data);
        }
    }
    
    //디테일을 위한 카운트
    public int countForDetail(PageVO pageVO) {
    	String sql = "select count(*) from board "
    			+ "where (board_writer is null or board_writer in (select member_id from member "
    			+ "where member_grade != '관리자')) "
    			+ "and board_category = ?";
        Object[] data = { pageVO.getCategory() };
        return jdbcTemplate.queryForObject(sql, int.class, data);
    }
    
    //디테일 리다이렉트 될 때 최신글인지 판단하려고..
    public int maxBoardNo(String boardCategory) {
        String sql = "select max(board_no) as max_board_no from board where board_category = ?";
        Object[] data = {boardCategory};
        return jdbcTemplate.queryForObject(sql, int.class, data);
    }
    
   

	
	//닉네임으로 검색 카운트
	public int countForNick(PageVO pageVO) {
	    if (pageVO.isSearch()) { // 검색
	        String sql = "SELECT COUNT(*) FROM board b JOIN member m ON b.board_writer = m.member_id WHERE board_category = ? and m.member_nick LIKE ?";
	        Object[] data = {pageVO.getCategory(), pageVO.getKeyword()};
	        return jdbcTemplate.queryForObject(sql, int.class, data);
	    } else { // 목록
	        String sql = "SELECT COUNT(*) FROM board WHERE board_category = ?";
	        Object[] data = {pageVO.getCategory()};
	        return jdbcTemplate.queryForObject(sql, int.class, data);
	    }
	}
	
	//게시글 상세 조회
	public BoardDto selectOne(int boardNo) {
		String sql = "select * from board where board_no = ?";
		Object[] data = {boardNo};
		List<BoardDto> list = jdbcTemplate.query(sql, boardMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	public BoardDto selectOne2(int boardNo) {
	    String sql = "SELECT b.*, m.member_nick AS boardWriterNickname " +
	            "FROM board b " +
	            "LEFT JOIN member m ON b.board_writer = m.member_id " +
	            "WHERE b.board_no = ?";
	    Object[] data = {boardNo};
	    return jdbcTemplate.queryForObject(sql, boardWithNicknameMapper, data);
	}
		
    //게시글 수정
    public boolean update(BoardDto boardDto) {//제목, 내용, 수정일, 카테고리, 마감일을 게시글 번호 뽑아서 수정~!
        String sql = "update board "
                + "set board_title=?, board_content=?, board_edit_time=sysdate, "
                + "board_limit_time= to_date(?, 'YYYY-MM-DD HH24:MI') "
                + "where board_no=?";
        Object[] data = {
                boardDto.getBoardTitle(), boardDto.getBoardContent(),
                boardDto.getBoardLimitTime(), boardDto.getBoardNo()
        };
        return jdbcTemplate.update(sql, data) > 0;
    }
	
	//게시글 삭제
	public boolean delete(int boardNo) {
		String sql = "delete board where board_no=?";
		Object[] data = {boardNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//조회수 증가
	public boolean updateBoardView(int boardNo) {
		String sql = "update board set board_view = board_view + 1 "
				+ "where board_no=?";
		Object[] data = {boardNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//신고 수 증가
    public void increaseBoardReport(int boardNo) {
        String sql = "UPDATE board SET board_report = board_report + 1 WHERE board_no = ?";
        jdbcTemplate.update(sql, boardNo);
    }
    //신고 수 감소
    public void decreaseBoardReport(int boardNo) {
    	String sql = "UPDATE board SET board_report = board_report - 1 WHERE board_no = ?";
    	jdbcTemplate.update(sql, boardNo);
    }
    //댓글 수 증가
    public void increaseBoardReply(int boardNo) {
        String sql = "UPDATE board SET board_reply = board_reply + 1 WHERE board_no = ?";
        jdbcTemplate.update(sql, boardNo);
    }
    //댓글 수 감소
    public void decreaseBoardReply(int boardNo) {
    	String sql = "UPDATE board SET board_reply = board_reply - 1 WHERE board_no = ?";
    	jdbcTemplate.update(sql, boardNo);
    }

	//관리자 전체 공지 조회하기
	public List<BoardDto> listByAdmin(){
		String sql = "select * from("
				+ "select rownum rn, TMP.* from("
				+ "select board_no, board_title, board_reply, board_writer, board_write_time, "
				+ "board_limit_time, board_view, board_like, board_category "
				+ "from board where board_writer in ("
				+ "select member_id from member where member_grade = '관리자') "
				+ "and board_category = '관리자' order by board_no desc) TMP)";
		
		//Object[] data = {}; //데이터 없음!!
		
		return jdbcTemplate.query(sql, boardListMapper);
	}
	
	public List<BoardDto> listByAdminAndCategory(String boardCategory){
		String sql = "select * from("
				+ "select rownum rn, TMP.* from("
				+ "select board_no, board_title, board_reply, board_writer, board_write_time, "
				+ "board_limit_time, board_view, board_like, board_category "
				+ "from board where board_writer in ("
				+ "select member_id from member where member_grade = '관리자') "
				+ "and board_category = ? order by board_no desc) TMP)";
		
		Object[] data = {boardCategory};
		
		return jdbcTemplate.query(sql, boardListMapper, data);
	}
	
	//내가 쓴 게시글
    public List<BoardDto> findBylist(String memberId, PageVO pageVO, String boardCategory) {
    	if(boardCategory == null) { //전체글
    		String sql = "select * from (" 
    				+ "select rownum rn, TMP.* from (" 
    				+ "select board_no, board_title, board_reply, board_writer, board_write_time, " 
    				+ "board_limit_time, board_view, board_like, board_category " 
    				+ "from board where board_writer = ? "
    				+ "order by board_no desc"
    				+ ")TMP"
    				+ ") where rn between ? and ?";
    		Object[] data = {memberId, pageVO.getBeginRow(), pageVO.getEndRow()};
    		return jdbcTemplate.query(sql, boardListMapper, data);
    	}
    	else { //카테고리별
    		String sql = "select * from (" 
    				+ "select rownum rn, TMP.* from (" 
    				+ "select board_no, board_title, board_reply, board_writer, board_write_time, " 
    				+ "board_limit_time, board_view, board_like, board_category " 
    				+ "from board where board_writer = ? and board_category = ? "
    				+ "order by board_no desc"
    				+ ")TMP"
    				+ ") where rn between ? and ?";
    		Object[] data = {memberId, boardCategory, pageVO.getBeginRow(), pageVO.getEndRow()};
    		return jdbcTemplate.query(sql, boardListMapper, data);
    	}
    }
    
    //내가 쓴 글을 위한 카운트
    public int countForMywriting(PageVO pageVO, String memberId) {
    	if(pageVO.isCategory()) {//카테고리인지
        	String sql = "select count(*) from board "
        			+ "where board_writer = ? and board_category = ?";
        	Object[] data = {memberId, pageVO.getCategory()};
        	return jdbcTemplate.queryForObject(sql, int.class, data);
    	}
    	else {
        	String sql = "select count(*) from board "
        			+ "where board_writer = ?";
        	Object[] data = {memberId};
        	return jdbcTemplate.queryForObject(sql, int.class, data);
    	}
    }
    

    //찜목록
    public List<BoardDto> likeList(String memberId){
        String sql = "SELECT board.* "
                + "FROM board_like "
                + "JOIN board ON board_like.board_no = board.board_no "
                + "WHERE board_like.member_id = ?";
        Object[] data = {memberId};
        return jdbcTemplate.query(sql, boardListMapper, data);
    }

    
    @Autowired
    private MemberDao memberDao;


    public String getBoardWriterNickname(String memberId) {
        return memberDao.getMemberNickById(memberId);
    }

}