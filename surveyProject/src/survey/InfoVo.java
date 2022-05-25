package survey;

public class InfoVo {
	private int number;
	private int agegroup;
	private int sex;

	public InfoVo() {

	}

	public InfoVo(int agegroup, int sex) {
	
		this.agegroup = agegroup;
		this.sex = sex;
	}

	public void setnumber(int number) {
		this.number = number;
	}

	public void setage(int agegroup) {
		this.agegroup = agegroup;
	}

	public void setsex(int sex) {
		this.sex = sex;
	}

	public int getnumber() {
		return number;
	}

	public int getage() {
		return agegroup;
	}

	public int getsex() {
		return sex;
	}

	
}
