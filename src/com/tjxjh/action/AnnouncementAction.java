package com.tjxjh.action;

import javax.annotation.Resource;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Actions;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import cn.cafebabe.autodao.pojo.Page;

import com.tjxjh.annotation.Auth;
import com.tjxjh.enumeration.ClubMemberRole;
import com.tjxjh.enumeration.UserStatus;
import com.tjxjh.interceptor.AuthInterceptor.AdminAuth;
import com.tjxjh.interceptor.AuthInterceptor.ClubManagerAuth;
import com.tjxjh.interceptor.AuthInterceptor.UserWithClubMemberAuth;
import com.tjxjh.po.Announcement;
import com.tjxjh.service.AnnouncementService;

@ParentPackage("myPackage")
@Namespace("/")
public class AnnouncementAction extends BaseAction
{
	static final String ADD_CLUB_ANNOUNCEMENT_INPUT = "addClubAnnouncementInput";
	static final String PUBLIC_ACCOUNCEMENTS = "publicAnnouncements";
	static final String CLUB_ANNOUNCEMENTS = "clubAnnouncements";
	static final String MY_ANNOUNCEMENTS = "myAnnouncements";
	static final String ADD_ANNOUNCEMENT = "addAnnouncement";
	static final String ADD_ANNOUNCEMENT_INPUT = "addAnnouncementInput";
	private static final long serialVersionUID = -8109609053983009227L;
	@Resource
	private AnnouncementService announcementService = null;
	private Announcement announcement = null;
	private String path = null;
	private Page page = null;
	
	@Actions({
			@Action(value = ADD_ANNOUNCEMENT_INPUT, results = {@Result(name = SUCCESS, location = MANAGE
					+ ADD_ANNOUNCEMENT + JSP, params = {"path", "${path}"})}),
			@Action(value = ADD_CLUB_ANNOUNCEMENT_INPUT, results = {@Result(name = SUCCESS, location = FOREPART
					+ ADD_CLUB_ANNOUNCEMENT_INPUT + JSP, params = {"path",
					"${path}"})})})
	public String page()
	{
		return SUCCESS;
	}
	
	@Action(value = ADD_ANNOUNCEMENT, results = {
			@Result(name = SUCCESS, type = REDIRECT_ACTION, location = "${path}", params = {
					"club.id", "${#request.clubMember.club.id}"}),
			@Result(name = INPUT, type = REDIRECT_ACTION, location = ADD_ANNOUNCEMENT),
			@Result(name = ERROR, location = FOREPART + ERROR_PAGE)})
	@Auth(type = UserWithClubMemberAuth.class)
	public String addAnnouncement()
	{
		if(path == null)
		{
			return ERROR;
		}
		if(currentUser().getStatus() != UserStatus.ADMIN)
		{
			if((super.currentClubMember() == null || super.currentClubMember()
					.getRole() == ClubMemberRole.NORMAL))
			{
				return ERROR;
			}
			else
			{
				announcement.setClub(super.currentClubMember().getClub());
			}
		}
		return super.successOrInput(announcementService.save(announcement));
	}
	
	@Action(value = MY_ANNOUNCEMENTS, results = {@Result(name = SUCCESS, location = FOREPART
			+ MY_ANNOUNCEMENTS + JSP)})
	@Auth(type = UserWithClubMemberAuth.class)
	public String myAnnouncements()
	{
		if(page == null)
		{
			page = announcementService.clubAnnouncementsPage(
					super.currentUser(), true);
		}
		super.getRequestMap().put(
				MY_ANNOUNCEMENTS,
				announcementService.clubAnnouncements(super.currentUser(),
						page, true));
		return SUCCESS;
	}
	
	@Action(value = PUBLIC_ACCOUNCEMENTS, results = {@Result(name = SUCCESS, location = MANAGE
			+ PUBLIC_ACCOUNCEMENTS + JSP)})
	public String publicAccouncements()
	{
		if(page == null)
		{
			page = announcementService.announcementsPage();
		}
		super.getRequestMap().put(MY_ANNOUNCEMENTS,
				announcementService.announcements(page));
		return SUCCESS;
	}
	
	@Action(value = CLUB_ANNOUNCEMENTS, results = {@Result(name = SUCCESS, location = FOREPART
			+ CLUB_ANNOUNCEMENTS + JSP)})
	@Auth(type = ClubManagerAuth.class)
	public String clubAnnouncements()
	{
		if(page == null)
		{
			page = announcementService.clubAnnouncementsPage(
					super.currentUser(), false);
		}
		super.getRequestMap().put(
				MY_ANNOUNCEMENTS,
				announcementService.clubAnnouncements(super.currentUser(),
						page, false));
		return SUCCESS;
	}
	
	public void setAnnouncementService(AnnouncementService announcementService)
	{
		this.announcementService = announcementService;
	}
	
	public Announcement getAnnouncement()
	{
		return announcement;
	}
	
	public void setAnnouncement(Announcement announcement)
	{
		this.announcement = announcement;
	}
	
	public void setPath(String path)
	{
		this.path = path;
	}
	
	public String getPath()
	{
		return path;
	}
	
	public Page getPage()
	{
		return page;
	}
	
	public void setPage(Page page)
	{
		this.page = page;
	}
}
