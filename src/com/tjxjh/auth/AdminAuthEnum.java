package com.tjxjh.auth;


public enum AdminAuthEnum implements Authable {
	NO_NEED(UserAuthEnum.NO_NEED.getAuth()), LOGIN(AuthFactory.getAdminAuth());
	private final Auth auth;

	private AdminAuthEnum(Auth auth) {
		this.auth = auth;
	}

	@Override
	public Auth getAuth() {
		return auth;
	}
}
