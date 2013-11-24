package com.tjxjh.interceptor;

import com.opensymphony.xwork2.ActionInvocation;
import com.tjxjh.action.BaseAction;
import com.tjxjh.annotation.AddClubPopularity;
import com.tjxjh.po.ClubMember;
import com.tjxjh.service.ClubService;

public class ClubPopularityInterceptor extends BaseInterceptor
{
	private static final long serialVersionUID = -3838474524274680487L;
	
	@Override
	public String intercept(ActionInvocation invocation) throws Exception
	{
		AddClubPopularity clubPopularity = invocation.getAction().getClass()
				.getMethod(invocation.getProxy().getMethod())
				.getAnnotation(AddClubPopularity.class);
		if(clubPopularity != null)
		{
			ClubMember member = (ClubMember) getRequestMap().get(
					BaseAction.CLUB_MEMBER);
			if(member != null)
			{
				getService(ClubService.class).addPopularity(member.getClub(),
						clubPopularity.weight());
			}
		}
		return invocation.invoke();
	}
}
