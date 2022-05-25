package survey;

public class RankVo {
	public static final String PURPOSE1 = "맛집탐방";
	public static final String PURPOSE2 = "카페투어";
	public static final String PURPOSE3 = "사진촬영";
	public static final String PURPOSE4 = "이유없음";
	private String purposeStr;
	private int purpose;
	private int count;
		
	public RankVo(int purpose, int count) {
		this.purpose = purpose;
		this.count = count;
		switch(purpose) {
		case 1:this.purposeStr = PURPOSE1; break;
		case 2:this.purposeStr = PURPOSE2; break;
		case 3:this.purposeStr = PURPOSE3; break;
		case 4:this.purposeStr = PURPOSE4; break;
		}
		
	}

	public String getPurposeStr() {
		return purposeStr;
	}

	public int getPurpose() {
		return purpose;
	}

	public int getCount() {
		return count;
	}
	
	private String place;
	private int vote;
	
	public RankVo(String place, int vote) {
		this.place = place;
		this.vote = vote;		
		}
	
	public String getplace() {
		return place;
	}

	public int getvote() {
		return vote;
	}
}
