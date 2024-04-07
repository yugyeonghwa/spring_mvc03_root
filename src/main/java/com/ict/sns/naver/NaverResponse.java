package com.ict.sns.naver;

public class NaverResponse {
	private String id, nickname, profile_image, email, mobile, name;

	public NaverResponse(String id, String nickname, String profile_image, String email, String mobile, String name) {
		this.id = id;
		this.nickname = nickname;
		this.profile_image = profile_image;
		this.email = email;
		this.mobile = mobile;
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getProfile_image() {
		return profile_image;
	}

	public void setProfile_image(String profile_image) {
		this.profile_image = profile_image;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
