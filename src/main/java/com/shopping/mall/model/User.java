package com.shopping.mall.model;


public class User {
	
	private int id;
	private String name;
	private String password;
	private String email;
	private String telephone;
	private String articles;
	private int    videos;
	private int    avatar;
	private String information;
	private String picture;
	private int    roleId;
	private int    missNumber;
	private String missTime;
	private String allowTime;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getArticles() {
		return articles;
	}
	public void setArticles(String articles) {
		this.articles = articles;
	}
	public int getVideos() {
		return videos;
	}
	public void setVideos(int videos) {
		this.videos = videos;
	}
	public int getAvatar() {
		return avatar;
	}
	public void setAvatar(int avatar) {
		this.avatar = avatar;
	}
	public String getInformation() {
		return information;
	}
	public void setInformation(String information) {
		this.information = information;
	}
	public int getRoleId() {
		return roleId;
	}
	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}
	public int getMissNumber() {
		return missNumber;
	}
	public void setMissNumber(int missNumber) {
		this.missNumber = missNumber;
	}
	public String getMissTime() {
		return missTime;
	}
	public void setMissTime(String missTime) {
		this.missTime = missTime;
	}
	public String getAllowTime() {
		return allowTime;
	}
	public void setAllowTime(String allowTime) {
		this.allowTime = allowTime;
	}

	
}
