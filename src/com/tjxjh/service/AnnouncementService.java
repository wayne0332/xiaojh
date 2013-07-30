package com.tjxjh.service;

import java.util.List;

import org.springframework.stereotype.Service;

import cn.cafebabe.autodao.pojo.Page;
import cn.cafebabe.websupport.service.BaseService;

import com.tjxjh.po.Announcement;
import com.tjxjh.po.User;

@Service
public class AnnouncementService extends BaseService
{
	private static final String ANNOUNCEMENT_HQL = "from Announcement where club.id in (select club.id from ClubMember where user.id=?)",
			ALLOW_CLUB_NULL_HQL = " or club.id=null",
			ANNOUNCEMENT_ORDER_HQL = " order by datetime desc";
	
	public Page announcementsPage(User user, boolean canClubNull)
	{
		return dao.getPageByHql("select count(*) " + ANNOUNCEMENT_HQL
				+ (canClubNull ? ALLOW_CLUB_NULL_HQL : "")
				+ ANNOUNCEMENT_ORDER_HQL, user.getId());
	}
	
	@SuppressWarnings("unchecked")
	public List<Announcement> announcements(User user, Page page,
			boolean canClubNull)
	{
		return (List<Announcement>) dao.executeHql(page, ANNOUNCEMENT_HQL
				+ (canClubNull ? ALLOW_CLUB_NULL_HQL : "")
				+ ANNOUNCEMENT_ORDER_HQL, user.getId());
	}
}
