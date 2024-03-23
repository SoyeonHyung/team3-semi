package com.kh.semiteam3.dto;


public class ReplyDto {
	private int replyNo; //댓글번호
	private String replyContent; //댓글내용
	private String replyTime; //댓글등록일
	private String replyWriter; //작성자 - member_id 참조
	private int replyOrigin; //게시글번호 - board_no 참조
	
	
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
	
	
}

