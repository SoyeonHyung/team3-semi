package com.kh.semiteam3.dto;

import java.sql.Date;

public class MemberDto {
	private String memberId;
	private String memberPw;
	private String memberContect;
	private String memberGrade;
	private String memberEmail;
	private Date memberJoin;
	private String memberBirth;
	private String memberPost;
	private String memberAddress1;
	private String memberAddress2;
	private Date memberLogin;
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberPw() {
		return memberPw;
	}
	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}
	public String getMemberContect() {
		return memberContect;
	}
	public void setMemberContect(String memberContect) {
		this.memberContect = memberContect;
	}
	public String getMemberGrade() {
		return memberGrade;
	}
	public void setMemberGrade(String memberGrade) {
		this.memberGrade = memberGrade;
	}
	public String getMemberEmail() {
		return memberEmail;
	}
	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}
	public Date getMemberJoin() {
		return memberJoin;
	}
	public void setMemberJoin(Date memberJoin) {
		this.memberJoin = memberJoin;
	}
	public String getMemberBirth() {
		return memberBirth;
	}
	public void setMemberBirth(String memberBirth) {
		this.memberBirth = memberBirth;
	}
	public String getMemberPost() {
		return memberPost;
	}
	public void setMemberPost(String memberPost) {
		this.memberPost = memberPost;
	}
	public String getMemberAddress1() {
		return memberAddress1;
	}
	public void setMemberAddress1(String memberAddress1) {
		this.memberAddress1 = memberAddress1;
	}
	public String getMemberAddress2() {
		return memberAddress2;
	}
	public void setMemberAddress2(String memberAddress2) {
		this.memberAddress2 = memberAddress2;
	}
	public Date getMemberLogin() {
		return memberLogin;
	}
	public void setMemberLogin(Date memberLogin) {
		this.memberLogin = memberLogin;
	}
	public MemberDto() {
		super();
	}
	
}
