package com.tjxjh.auth;

import java.util.Map;

import org.apache.struts2.ServletActionContext;

import cn.cafebabe.websupport.util.SpringUtil;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.tjxjh.action.BaseAction;
import com.tjxjh.enumeration.ClubMemberRole;
import com.tjxjh.po.Club;
import com.tjxjh.po.ClubMember;
import com.tjxjh.po.User;
import com.tjxjh.service.ClubService;
import com.tjxjh.util.StringUtil;

class UserAuth implements Auth
{
	UserAuth()
	{}
	
	@Override
	public boolean isPass(ActionInvocation ai)
	{
		if(currentUser() == null)
		{
			return false;
		}
		return true;
	}
	
	protected User currentUser()
	{
		return (User) getSessionMap().get(BaseAction.USER);
	}
	
	protected Map<String, Object> getSessionMap()
	{
		return ActionContext.getContext().getSession();
	}
	
	@SuppressWarnings("unchecked")
	protected Map<String, Object> getRequestMap()
	{
		return (Map<String, Object>) ActionContext.getContext().get("request");
	}
	
	protected ClubService getClubService(ActionInvocation ai)
	{
		return SpringUtil.springContext(
				ServletActionContext.getServletContext()).getBean(
				ClubService.class);
	}
}

class UserWithClubMemberAuth extends UserAuth
{
	private static final String CLUB_ID = "club.id";
	
	UserWithClubMemberAuth()
	{
		super();
	}
	
	@Override
	public boolean isPass(ActionInvocation ai)
	{
		if(super.isPass(ai))
		{
			Map<String, Object> params = ai.getInvocationContext()
					.getParameters();
			String[] clubId = (String[]) params.get(CLUB_ID);
			if(StringUtil.isNotEmpty(clubId)
					&& StringUtil.isNotEmpty(clubId[0]))
			{
				Integer _clubId = null;
				try
				{
					_clubId = Integer.valueOf(clubId[0]);
				}
				catch(NumberFormatException e)
				{
					e.printStackTrace();
					return false;
				}
				Club club = new Club();
				club.setId(_clubId);
				ClubMember member = getClubService(ai).userClub(currentUser(),
						club);
				getRequestMap().put(BaseAction.CLUB_MEMBER, member);
				getSessionMap().put(BaseAction.CLUB_MEMBER, member);
			}
			return true;
		}
		return false;
	}
	
	protected ClubMember currentClubMember()
	{
		return (ClubMember) getRequestMap().get(BaseAction.CLUB_MEMBER);
	}
}

class ClubMemberAuth extends UserWithClubMemberAuth
{
	ClubMemberAuth()
	{
		super();
	}
	
	@Override
	public boolean isPass(ActionInvocation ai)
	{
		if(super.isPass(ai))
		{
			if(currentClubMember() != null)
			{
				return true;
			}
		}
		return false;
	}
}

class ClubManagerAuth extends ClubMemberAuth
{
	ClubManagerAuth()
	{
		super();
	}
	
	@Override
	public boolean isPass(ActionInvocation ai)
	{
		if(super.isPass(ai))
		{
			if(currentClubMember().getRole() != ClubMemberRole.NORMAL)
			{
				return true;
			}
		}
		return false;
	}
}

class ClubProprieterAuth extends ClubManagerAuth
{
	ClubProprieterAuth()
	{
		super();
	}
	
	@Override
	public boolean isPass(ActionInvocation ai)
	{
		if(super.isPass(ai))
		{
			if(currentClubMember().getRole() == ClubMemberRole.PROPRIETER)
			{
				return true;
			}
		}
		return false;
	}
}
