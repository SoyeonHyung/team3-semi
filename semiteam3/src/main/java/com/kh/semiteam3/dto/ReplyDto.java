package com.kh.semiteam3.dto;


public class ReplyDto {
	private int replyNo; //댓글번호
	private String replyContent; //댓글내용
	private String replyTime; //댓글등록일
	private String replyWriter; //작성자 - member_id 참조
	private int replyOrigin; //게시글번호 - board_no 참조
	
	private String boardWriter; // 게시글 작성자
	
	
    public String getBoardWriter() {
        return boardWriter;
    }

    public void setBoardWriter(String boardWriter) {
        this.boardWriter = boardWriter;
    }
	
	public int getReplyNo() {
		return replyNo;
	}
	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public String getReplyTime() {
		return replyTime;
	}
	public void setReplyTime(String replyTime) {
		this.replyTime = replyTime;
	}
	public String getReplyWriter() {
		return replyWriter;
	}
	public void setReplyWriter(String replyWriter) {
		this.replyWriter = replyWriter;
	}
	public int getReplyOrigin() {
		return replyOrigin;
	}
	public void setReplyOrigin(int replyOrigin) {
		this.replyOrigin = replyOrigin;
	}
	public ReplyDto() {
		super();
	}

	
	//내가 쓴 댓글 하려고
	private String boardTitle;
	private String boardContent;
	private int boardView;
	private int boardReply;


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

	public int getBoardReply() {
		return boardReply;
	}

	public void setBoardReply(int boardReply) {
		this.boardReply = boardReply;
	}
	
	
	
}

