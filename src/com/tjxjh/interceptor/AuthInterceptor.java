package com.tjxjh.interceptor;

import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.tjxjh.action.BaseAction;
import com.tjxjh.annotation.Auth;
import com.tjxjh.enumeration.ClubMemberRole;
import com.tjxjh.po.Club;
import com.tjxjh.po.ClubMember;
import com.tjxjh.po.User;
import com.tjxjh.service.ClubService;
import com.tjxjh.util.StringUtil;

public class AuthInterceptor extends AbstractInterceptor
{
	private static final long serialVersionUID = -1636166010472122647L;
	// 我擦 init方法压根就取不到ServletContext 只能在listener里面往这里塞了
	private static ClubService clubService = null;
	
	@Override
	public String intercept(ActionInvocation ai) throws Exception
	{
		Auth auth = null;
		if((auth = ai.getAction().getClass()
				.getMethod(ai.getProxy().getMethod()).getAnnotation(Auth.class)) != null)
		{
			Class<? extends UserAuth> authType = auth.type();
			System.out.println(authType);
			String result = (String) authType.getDeclaredMethod("check",
					new Class[] {ActionInvocation.class}).invoke(null,
					new Object[] {ai});
			if(result != null)
			{
				return result;
			}
		}
		return ai.invoke();
	}
	
	static Map<String, Object> getSessionMap()
	{
		return ActionContext.getContext().getSession();
	}
	
	static Map<String, Object> getApplicationMap()
	{
		return ActionContext.getContext().getApplication();
	}
	
	@SuppressWarnings("unchecked")
	static Map<String, Object> getRequestMap()
	{
		return (Map<String, Object>) ActionContext.getContext().get("request");
	}
	
	public static void setClubService(ClubService clubService)
	{
		AuthInterceptor.clubService = clubService;
	}
	
	/** 登陆了才能能访问 */
	public static class UserAuth
	{
		private UserAuth()
		{}
		
		static String check(ActionInvocation ai)
		{
			if(getSessionMap().get(BaseAction.USER) == null)
			{
				return "login";
			}
			return null;
		}
	}
	
	/**
	 * 登陆了才能能访问,如果有club.id,就查一下ClubMember,如果有身份,就放到request和session里,
	 * key是BaseAction.CLUB_MEMBER的引用
	 */
	public static class UserWithClubMemberAuth extends UserAuth
	{
		private UserWithClubMemberAuth()
		{}
		
		static String check(ActionInvocation ai)
		{
			Map<String, Object> params = ai.getInvocationContext()
					.getParameters();
			String[] clubId = (String[]) params.get("club.id");
			if(clubId != null && clubId.length > 0
					&& !StringUtil.isEmpty(clubId[0]))
			{
				Integer _clubId = null;
				try
				{
					_clubId = Integer.valueOf(clubId[0]);
				}
				catch(NumberFormatException e)
				{
					e.printStackTrace();
					return "main";
				}
				Club club = new Club();
				club.setId(_clubId);
				ClubMember member = clubService.userClub((User) getSessionMap()
						.get(BaseAction.USER), club);
				getRequestMap().put(BaseAction.CLUB_MEMBER, member);
				getSessionMap().put(BaseAction.CLUB_MEMBER, member);
			}
			return UserAuth.check(ai);
		}
	}
	
	/** 登陆了并且是社团的成员才能访问 */
	public static class ClubMemberAuth extends UserWithClubMemberAuth
	{
		private ClubMemberAuth()
		{}
		
		static String check(ActionInvocation ai)
		{
			String result = UserWithClubMemberAuth.check(ai);
			if(result != null)
			{
				return result;
			}
			if(getRequestMap().get(BaseAction.CLUB_MEMBER) == null)
			{
				return "main";
			}
			return null;
		}
	}
	
	/** 登陆了并且是社团的管理员(包括社长)才能访问 */
	public static class ClubManagerAuth extends ClubMemberAuth
	{
		private ClubManagerAuth()
		{}
		
		static String check(ActionInvocation ai)
		{
			String result = ClubMemberAuth.check(ai);
			if(result != null)
			{
				return result;
			}
			if(((ClubMember) getRequestMap().get(BaseAction.CLUB_MEMBER))
					.getRole() == ClubMemberRole.NORMAL)
			{
				return "main";
			}
			return null;
		}
	}
	
	/** 登陆了并且是社团的社长才能访问 */
	public static class ClubProprieterAuth extends UserWithClubMemberAuth
	{
		private ClubProprieterAuth()
		{}
		
		static String check(ActionInvocation ai)
		{
			String result = ClubMemberAuth.check(ai);
			if(result != null)
			{
				return result;
			}
			if(((ClubMember) getRequestMap().get(BaseAction.CLUB_MEMBER))
					.getRole() != ClubMemberRole.PROPRIETER)
			{
				return "main";
			}
			return null;
		}
	}
}
