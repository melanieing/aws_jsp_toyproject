package survey;

public class PurposeVo {
	private int ppcode;
	
	private int placecode;
	private int purpose;

	public PurposeVo() {

	}

	public PurposeVo(int placecode, int purpose) {
		
		
		this.placecode = placecode;
		this.purpose = purpose;
	}

	public void setppcode(int ppcode) {
		this.ppcode = ppcode;
	}

	

	public void setplacecode(int placecode) {
		this.placecode = placecode;
	}

	public void setpurpose(int purpose) {
		this.purpose = purpose;
	}

	public int getppcode() {
		return ppcode;
	}


	public int getplacecode() {
		return placecode;
	}

	public int getpurpose() {
		return purpose;
	}

}
