package survey;

public class PlaceVo {
	private int pcode;
	private String place;

	public PlaceVo() {

	}

	public PlaceVo(int pcode, String place) {
		this.pcode = pcode;
		this.place = place;
	}

	public void setpcode(int pcode) {
		this.pcode = pcode;
	}

	public void setplace(String place) {
		this.place = place;
	}

	public int getpcode() {
		return pcode;
	}

	public String getplace() {
		return place;
	}

	
}
