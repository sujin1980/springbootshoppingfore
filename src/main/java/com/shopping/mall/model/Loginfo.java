package com.shopping.mall.model;

public class Loginfo {
	private int id;
	private User user;
	private String logaction;
	private String logtime;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getLogaction() {
		return logaction;
	}
	public void setLogaction(String logaction) {
		this.logaction = logaction;
	}
	public String getLogtime() {
		return logtime;
	}
	public void setLogtime(String logtime) {
		this.logtime = logtime;
	}
	
}
