package model1.board;

public class BoardDTO {
	// 멤버 변수 선언
	private String num; // 일련번호
	private String title; // 게시물 제목
	private String content; // 게시물 내용
	private String id; // 작성자 아이디
	private java.sql.Date postdate; // 작성일자
	private String visitcount; // 조회수
	private String name; // 작성자 이름
	
	// 게터/세터
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public java.sql.Date getPostdate() {
		return postdate;
	}
	public void setPostdate(java.sql.Date postdate) {
		this.postdate = postdate;
	}
	public String getVisitcount() {
		return visitcount;
	}
	public void setVisitcount(String visitcount) {
		this.visitcount = visitcount;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
		
}
