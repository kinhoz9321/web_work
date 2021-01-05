package test.users.dto;

public class UsersDto {
	//필드
	private String id;
	private String pwd;
	private String email;
	private String profile;
	private String regdate;
	
	//디폴트 생성자
	public UsersDto() {}

	//생성자
	public UsersDto(String id, String pwd, String email, String profile, String regdate) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.email = email;
		this.profile = profile;
		this.regdate = regdate;
	}

	//setter getter
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
}
