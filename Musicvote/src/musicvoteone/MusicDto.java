package musicvoteone;

public class MusicDto {

	private long number; // "NUMBER"
	private String musictype; // "MUSIC_TYPE"
	private long vote; // "VOTE"

	public MusicDto(long number, String musictype, long vote) {
		super();
		this.number = number;
		this.musictype = musictype;
		this.vote = vote;
	}

	public MusicDto() {
		super();
	}

	public long getNumber() {
		return number;
	}

	public void setNumber(long number) {
		this.number = number;
	}

	public String getMusictype() {
		return musictype;
	}

	public void setMusictype(String musictype) {
		this.musictype = musictype;
	}

	public long getVote() {
		return vote;
	}

	public void setVote(long vote) {
		this.vote = vote;
	}

	@Override
	public String toString() {
		return number + "." + musictype;
	}

	public String voteView() {
		return number + "." + musictype + " ===> " + vote + " 표";
	}
}
