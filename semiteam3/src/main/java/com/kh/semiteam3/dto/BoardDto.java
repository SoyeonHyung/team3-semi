package com.kh.semiteam3.dto;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

public class BoardDto {
	private int boardNo;// 게시글 번호
	private String boardTitle;// 게시글 제목
	private String boardContent;// 게시글 내용
	private int boardView;// 조회수
	private int boardLike;// 찜
	private int boardReply;// 댓글 수
	private int boardReport;// 게시글 신고
	private Date boardWriteTime;// 게시글 등록일
	private Date boardEditTime;// 게시글 수정일
	private String boardCategory;// 카테고리
	private String boardWriter;// 게시글 작성자
	private String boardLimitTime;// 마감시간

	
	private String boardWriterNickname; // 게시글 작성자의 닉네임
	
    public String getBoardWriterNickname() {
        return boardWriterNickname;
    }

    public void setBoardWriterNickname(String boardWriterNickname) {
        this.boardWriterNickname = boardWriterNickname;
    }
	
	

	//마감시간을 Date형태로 변환
	public Timestamp getBoardLimitTimeDate() {
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	    try {
	        String boardLimitTimeString = getBoardLimitTime();
	        if (boardLimitTimeString == null) {
	            return null; // 만약 boardLimitTimeString이 null이면 null 반환
	        }

	        java.util.Date utilDate = sdf.parse(boardLimitTimeString);

	        // java.util.Date를 java.sql.Timestamp로 변환
	        return new Timestamp(utilDate.getTime());

	    } catch (ParseException e) {
	        e.printStackTrace();
	        return null; // 예외가 발생하면 null을 반환
	    }
	}
	
	
	
	

	public String getBoardLimitTime() {
		return boardLimitTime;
	}

	public void setBoardLimitTime(String boardLimitTime) {
		this.boardLimitTime = boardLimitTime;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}

	public String getBoardContent() {
		return boardContent;
	}

	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}

	public int getBoardView() {
		return boardView;
	}

	public void setBoardView(int boardView) {
		this.boardView = boardView;
	}

	public int getBoardLike() {
		return boardLike;
	}

	public void setBoardLike(int boardLike) {
		this.boardLike = boardLike;
	}

	public int getBoardReply() {
		return boardReply;
	}

	public void setBoardReply(int boardReply) {
		this.boardReply = boardReply;
	}

	public int getBoardReport() {
		return boardReport;
	}

	public void setBoardReport(int boardReport) {
		this.boardReport = boardReport;
	}

	public Date getBoardWriteTime() {
		return boardWriteTime;
	}

	public void setBoardWriteTime(Date boardWriteTime) {
		this.boardWriteTime = boardWriteTime;
	}

	public Date getBoardEditTime() {
		return boardEditTime;
	}

	public void setBoardEditTime(Date boardEditTime) {
		this.boardEditTime = boardEditTime;
	}

	public String getBoardCategory() {
		return boardCategory;
	}

	public void setBoardCategory(String boardCategory) {
		this.boardCategory = boardCategory;
	}

	public String getBoardWriter() {
		return boardWriter;
	}

	public void setBoardWriter(String boardWriter) {
		this.boardWriter = boardWriter;
	}

	public BoardDto() {
		super();
	}

	// 작성자 없을경우 처리하는 게터 메소드
	public String getBoardWriterStr() {
		if (boardWriter == null) {
			return "탈퇴한사용자";
		} else {
			return boardWriter;
		}
	}

	// 오늘 작성한 글은 시간을, 이전에 작성한 글은 날짜를 반환하도록 jsp(여기서하기 어려워)에서 하지말고 여기서 처리해보자
	// - LocalDate형태로 시간을 변환하여 오늘 날짜와 비교
	// - 날짜가 같다면 LocalDate으로 변환해서 *시간*만 반환
	// - 날짜가 다르다면 LocalDate를 그대로(날짜로) 반환
	public String getBoardWriteTimeStr() {
		// jsp 에서는 못쓰기 때문에 java 에서 하는게 좋아 --이거 우리가 외워서 쓸 수 있을리가 없어
		LocalDate today = LocalDate.now();// 오늘날짜
		LocalDate writeTime = boardWriteTime.toLocalDate();// 작성일자
		if (writeTime.equals(today)) {// 오늘작성했다면
			// Date ---> Timestamp ---> LocalDateTime ---> LocalTime이게 중요한거임
			Timestamp stamp = new Timestamp(boardWriteTime.getTime());
			LocalDateTime time = stamp.toLocalDateTime();
			LocalTime result = time.toLocalTime();// 시간 나오게!
			return result.toString();// 시간반환
		} else {// 예전이라면-날짜 보여주기
			return writeTime.toString();// 날짜반환
		}
	}

	// 현재시각을 기준으로 하여 얼마나 지난 글인지를 계산하여 반환
	public String getBoardWriteTimeDiff() {
		long now = System.currentTimeMillis();
		long before = boardWriteTime.getTime();
		long gap = now - before;
		gap /= 1000;// 초로 변경

		if (gap < 60) {// 1분 미만은 방금 전으로 표시
			return "방금 전";
		} else if (gap < 60 * 60) {// 1시간 미만은 분으로 표시
			return gap / 60 + "분 전";
		} else if (gap < 24 * 60 * 60) {// 1일 미만은 시간으로 표시
			return gap / 60 / 60 + "시간 전";
		} else if (gap < 7 * 24 * 60 * 60) {// 7일 미만은 일로 표시
			return gap / 24 / 60 / 60 + "일 전";
		} else if (gap < 30 * 24 * 60 * 60) {// 한달 미만은 주로 표시
			return gap / 7 / 24 / 60 / 60 + "주 전";
		} else if (gap < 1 * 365 * 24 * 60 * 60) {// 1년 미만은 개월로 표시
			return gap / 30 / 24 / 60 / 60 + "개월 전";
		} else if (gap < 10 * 365 * 24 * 60 * 60) {// 10년 미만은 몇년전으로 표시
			return gap / 365 / 24 / 60 / 60 + "년 전";
		} else {// 나머지는 오래전으로 표시
			return "오래전";
		}
	}
	
	
	//모집 중 또는 모집완료 상태 구현 
	public String getBoardStatus() {
	    Timestamp currentTime = new Timestamp(System.currentTimeMillis()); // 현재 시간
	    Timestamp limitTime = getBoardLimitTimeDate(); // 글 쓸 때 설정한 마감 기간

	    // 현재 시간이 마감 기간 이후인지 확인
	    if (limitTime == null) {
	        return "-"; // 마감 기간이 설정되지 않은 경우
	    } 
	    else if (currentTime.after(limitTime)) {
	        return "모집 완료"; // 현재 시간이 마감 기간 이후인 경우
	    } 
	    else {
	        return "모집 중"; // 현재 시간이 마감 기간 이전인 경우
	    }
	}

	
	
	
	

}
