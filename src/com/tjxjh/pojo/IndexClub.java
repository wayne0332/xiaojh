package com.tjxjh.pojo;

import java.util.List;

import com.tjxjh.po.Activity;
import com.tjxjh.po.Club;


public class IndexClub implements java.io.Serializable
{

	private static final long serialVersionUID = 1L;
	private List<Activity> acs;
	private Club club;
	public List<Activity> getAcs() {
		return acs;
	}
	public void setAcs(List<Activity> acs) {
		this.acs = acs;
	}
	public Club getClub() {
		return club;
	}
	public void setClub(Club club) {
		this.club = club;
	}

	
	
}
