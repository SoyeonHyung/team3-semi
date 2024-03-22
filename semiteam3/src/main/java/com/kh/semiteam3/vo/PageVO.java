package com.kh.semiteam3.vo;

//페이징에 필요한 값들을 전달받아 계산을 수행하는 클래스
//필요한 값 - column, keyword, page, size, count + category

public class PageVO {
	//카테고리 별로 분류?
	private String category;//카테고리
	private String column, keyword;//검색항목, 검색어
	private int count;//전체 개수
	private int page=1;//현재 페이지
	private int size=15;//한페이지에 보여줄 게시글 개수
	private int blockSize=10;//블럭 표시개수
	
	//모집중인지 .. 구분 ..?
	private String status; 
	
	
	public String getStatus() {
		if(status == null)return "";
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public PageVO() {
		super();
	}


	public String getCategory() {
		return category;
	}


	public void setCategory(String category) {
		this.category = category;
	}


	public String getColumn() {
		if(column == null)return "";
		return column;
	}
	public void setColumn(String column) {
		this.column = column;
	}
	public String getKeyword() {
		if(keyword == null)return "";
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getSize() {
		return size;
	}
	public void setSize(int size) {
		this.size = size;
	}
	public int getBlockSize() {
		return blockSize;
	}
	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}

	//계산을 위한 가상의 Getter 메소드 추가
	public boolean isSearch() {
		return column != null && keyword != null && category != null; //카테고리 추가
	}
	
	//신고/문의게시글 관련 계산을 위한 가상의 Getter 메소드 추가
	public boolean isSearchOther() {
		return column != null && keyword != null;//카테고리 추가
	}
	
	//모집중인 게시글만 보기 추가위해 만드는 메소드!!!!?
	public boolean isOnlyRecruiting() {
		return category != null && status != null;
	}
	public boolean isOnlyRecruitingAndSearch() {
		return column != null && keyword != null && category != null && status != null;
	}
	
	public boolean isCategory() {
		return category != null;
	}
	
	
	public int getBeginRow() {
		//return getEndRow() - (size-1);
		return page * size - (size-1);
	}
	public int getEndRow() {
		return page * size;
	}
	public int getTotalPage() {
		return (count - 1) / size + 1;
	}
	public int getBeginBlock() {
		return (page-1)/ blockSize * blockSize + 1;
	}
	public int getEndBlock() {
		int number = (page-1)/ blockSize * blockSize + blockSize;
		return Math.min(getTotalPage(), number);
	}
	
	//논리 반환값을 가지는 Getter 메소드는 get이 아니라 is로 시작한다
	public boolean isFirstBlock() {
		return getBeginBlock() == 1;
	}
	
	public boolean isLastBlock() {
		return getEndBlock() == getTotalPage();
	}
	//물음표 뒤에 붙는 데이터 중 공통된 부분
	public String getQueryString() {
		return "&size=" + size + "&column=" + getColumn() + "&keyword=" + getKeyword()
							+ "&status=" + getStatus();
	}
	

	
	public int getPrevBlock() {
		return getBeginBlock()-1;
	}
	
	public int getNextBlock() {
		return getEndBlock()+1;
	}
	



}
