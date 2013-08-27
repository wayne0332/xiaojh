package com.tjxjh.pojo;

import java.util.List;

import com.tjxjh.po.Talking;
import com.tjxjh.po.TalkingComment;


public class IndexTalking implements java.io.Serializable
{

	private static final long serialVersionUID = 1L;
	private List<TalkingComment> tcs;
	private Talking t;
	public List<TalkingComment> getTcs() {
		return tcs;
	}
	public void setTcs(List<TalkingComment> tcs) {
		this.tcs = tcs;
	}
	public Talking getT() {
		return t;
	}
	public void setT(Talking t) {
		this.t = t;
	}
	

	
	
}
