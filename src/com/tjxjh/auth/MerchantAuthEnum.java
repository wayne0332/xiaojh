package com.tjxjh.auth;


public enum MerchantAuthEnum implements Authable {
	NO_NEED(UserAuthEnum.NO_NEED.getAuth()), LOGIN(AuthFactory.getMerchantAuth());
	private final Auth auth;

	private MerchantAuthEnum(Auth auth) {
		this.auth = auth;
	}

	@Override
	public Auth getAuth() {
		return auth;
	}
}
