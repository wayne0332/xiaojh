package com.tjxjh.auth;

import com.opensymphony.xwork2.ActionInvocation;

public enum UserAuthEnum implements Authable {
	NO_NEED(new Auth() {

		@Override
		public boolean isPass(ActionInvocation ai) {
			return true;
		}
	}), LOGIN(AuthFactory.getUserAuth()), AUTO_CLUB_MEMBER(AuthFactory
			.getUserWithClubMemberAuth()), CLUB_MEMBER(AuthFactory
			.getClubMemberAuth()), CLUB_MANAGER(AuthFactory
			.getClubManagerAuth()), CLUB_PROPRIETER(AuthFactory
			.getClubProprieterAuth());
	private final Auth auth;

	private UserAuthEnum(Auth auth) {
		this.auth = auth;
	}

	@Override
	public Auth getAuth() {
		return auth;
	}

}
