package com.tjxjh.auth;

import com.opensymphony.xwork2.ActionInvocation;

public enum AuthEnum implements Authable
{
	NO_NEED(new Auth()
	{
		@Override
		public boolean isPass(ActionInvocation ai)
		{
			return true;
		}
	}), USER(AuthFactory.getUserAuth()), AUTO_CLUB_MEMBER(AuthFactory
			.getUserWithClubMemberAuth()), CLUB_MEMBER(AuthFactory
			.getClubMemberAuth()), CLUB_MANAGER(AuthFactory
			.getClubManagerAuth()), CLUB_PROPRIETER(AuthFactory
			.getClubProprieterAuth()), ADMIN(AuthFactory.getAdminAuth()), MERCHANT(
			AuthFactory.getMerchantAuth());
	private final Auth auth;
	
	private AuthEnum(Auth auth)
	{
		this.auth = auth;
	}
	
	@Override
	public Auth getAuth()
	{
		return auth;
	}
}
