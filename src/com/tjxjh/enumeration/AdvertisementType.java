package com.tjxjh.enumeration;

public enum AdvertisementType {
	
	JS("首页js"),IMG("图片类型"),SWF("动态flash");
	private String name = null;
	
	private AdvertisementType(String name){
		this.name = name;
	}
	
	public String getName() {
		return name;
	}
}
