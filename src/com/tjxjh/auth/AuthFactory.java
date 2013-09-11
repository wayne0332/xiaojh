package com.tjxjh.auth;

public class AuthFactory {
	private final static Auth userAuth = new UserAuth(),
			userWithClubMemberAuth = new UserWithClubMemberAuth(),
			clubMemberAuth = new ClubMemberAuth(),
			clubManagerAuth = new ClubManagerAuth(),
			clubProprieterAuth = new ClubProprieterAuth(),
			adminAuth = new AdminAuth(), merchantAuth = new MerchantAuth();

	public static Auth getUserAuth() {
		return userAuth;
	}

	public static Auth getUserWithClubMemberAuth() {
		return userWithClubMemberAuth;
	}

	public static Auth getClubMemberAuth() {
		return clubMemberAuth;
	}

	public static Auth getClubManagerAuth() {
		return clubManagerAuth;
	}

	public static Auth getClubProprieterAuth() {
		return clubProprieterAuth;
	}

	public static Auth getAdminAuth() {
		return adminAuth;
	}

	public static Auth getMerchantAuth() {
		return merchantAuth;
	}

}
