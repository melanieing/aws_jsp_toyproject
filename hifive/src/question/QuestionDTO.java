package question;

public class QuestionDTO {

	// 멤버 변수 선언
	private String questNum; // 설문데이터 일련번호
	private String memNum; // 설문응답자 고유번호
	private String questType; // 설문유형
	private String questAns; // 설문응답
	
	public QuestionDTO() {
		
	}
	public QuestionDTO(String questNum, String memNum, String questType, String questAns) {
		super();
		this.questNum = questNum;
		this.memNum = memNum;
		this.questType = questType;
		this.questAns = questAns;
	}
	
	public String getQuestNum() {
		return questNum;
	}
	public void setQuestNum(String questNum) {
		this.questNum = questNum;
	}
	public String getMemNum() {
		return memNum;
	}
	public void setMemNum(String memNum) {
		this.memNum = memNum;
	}
	public String getQuestType() {
		return questType;
	}
	public void setQuestType(String questType) {
		this.questType = questType;
	}
	public String getQuestAns() {
		return questAns;
	}
	public void setQuestAns(String questAns) {
		this.questAns = questAns;
	}

}
