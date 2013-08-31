package com.tjxjh.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import cn.cafebabe.autodao.pojo.Page;

import com.tjxjh.po.Club;
import com.tjxjh.po.Merchant;
import com.tjxjh.po.School;
import com.tjxjh.po.User;
import com.tjxjh.pojo.IndexClub;
import com.tjxjh.pojo.IndexMerchant;
import com.tjxjh.service.ActivityService;
import com.tjxjh.service.ClubService;
import com.tjxjh.service.CommonService;
import com.tjxjh.service.MerchantService;
import com.tjxjh.service.UserService;
import com.tjxjh.util.Auth;

@ParentPackage("myPackage")
@Namespace("/")
public class IndexAction extends BaseAction
{
	static final String INDEX = "index";
	static final String SCHOOL = "school";
	private static final long serialVersionUID = 1L;
	@Resource
	private UserService userService = null;
	@Resource
	private MerchantService merchantService = null;
	@Resource
	private ActivityService activityService = null;
	@Resource
	private ClubService clubService = null;
	@Resource
	private CommonService commonService = null;
	// 分页
	Page page = null;
	private Integer eachPageNumber = 4;
	private Integer currentPage = 1;
	private Integer totalPageNumber = 0;
	List<Club> clubs = null;
	List<IndexClub> ics = new ArrayList<IndexClub>();
	List<IndexMerchant> ims = new ArrayList<IndexMerchant>();
	List<Merchant> merchants = null;
	private School school = null;
	private String clubType = null;
	
	@Action(value = INDEX, results = {@Result(name = SUCCESS, location = BaseAction.FOREPART
			+ "index.jsp")})
	public String index()
	{
		clubs = clubService.findHeatClubByHql();
		for(Club c : clubs)
		{
			IndexClub ic = new IndexClub();
			ic.setClub(c);
			ic.setAcs(activityService.findOneActivityByHql(c, null));
			ics.add(ic);
		}
		merchants = merchantService.findHeatMerchantByHql();
		for(Merchant m : merchants)
		{
			IndexMerchant im = new IndexMerchant();
			im.setMerchant(m);
			im.setAcs(activityService.findOneActivityByHql(null, m));
			ims.add(im);
		}
		return SUCCESS;
	}
	
	@Action(value = SCHOOL, results = {@Result(name = SUCCESS, location = BaseAction.FOREPART
			+ "school.jsp")})
	public String school()
	{
		if(school == null || school.getId() == null)
		{
			User user = Auth.getUserFromSession();
			school = user.getSchool();
		}
		school = commonService.school(school.getId());
		if(clubType != null && !clubType.trim().equals(""))
		{
			page = clubService.findSchoolClubPageByType(eachPageNumber,
					currentPage, totalPageNumber, school, clubType);
			clubs = clubService.findSchoolClubByType(school, clubType, page);
		}
		else
		{
			page = clubService.findSchoolClubPageByHet(eachPageNumber,
					currentPage, totalPageNumber, school);
			clubs = clubService.findSchoolHeatClubByHql(school, page);
		}
		return SUCCESS;
	}
	
	public UserService getUserService()
	{
		return userService;
	}
	
	public void setUserService(UserService userService)
	{
		this.userService = userService;
	}
	
	public MerchantService getMerchantService()
	{
		return merchantService;
	}
	
	public void setMerchantService(MerchantService merchantService)
	{
		this.merchantService = merchantService;
	}
	
	public ActivityService getActivityService()
	{
		return activityService;
	}
	
	public void setActivityService(ActivityService activityService)
	{
		this.activityService = activityService;
	}
	
	public ClubService getClubService()
	{
		return clubService;
	}
	
	public void setClubService(ClubService clubService)
	{
		this.clubService = clubService;
	}
	
	public List<IndexClub> getIcs()
	{
		return ics;
	}
	
	public void setIcs(List<IndexClub> ics)
	{
		this.ics = ics;
	}
	
	public List<IndexMerchant> getIms()
	{
		return ims;
	}
	
	public void setIms(List<IndexMerchant> ims)
	{
		this.ims = ims;
	}
	
	public CommonService getCommonService()
	{
		return commonService;
	}
	
	public void setCommonService(CommonService commonService)
	{
		this.commonService = commonService;
	}
	
	public School getSchool()
	{
		return school;
	}
	
	public void setSchool(School school)
	{
		this.school = school;
	}
	
	public List<Club> getClubs()
	{
		return clubs;
	}
	
	public void setClubs(List<Club> clubs)
	{
		this.clubs = clubs;
	}
	
	public List<Merchant> getMerchants()
	{
		return merchants;
	}
	
	public void setMerchants(List<Merchant> merchants)
	{
		this.merchants = merchants;
	}
	
	public String getClubType()
	{
		return clubType;
	}
	
	public void setClubType(String clubType)
	{
		this.clubType = clubType;
	}
	
	public Page getPage()
	{
		return page;
	}
	
	public void setPage(Page page)
	{
		this.page = page;
	}
	
	public Integer getEachPageNumber()
	{
		return eachPageNumber;
	}
	
	public void setEachPageNumber(Integer eachPageNumber)
	{
		this.eachPageNumber = eachPageNumber;
	}
	
	public Integer getCurrentPage()
	{
		return currentPage;
	}
	
	public void setCurrentPage(Integer currentPage)
	{
		this.currentPage = currentPage;
	}
	
	public Integer getTotalPageNumber()
	{
		return totalPageNumber;
	}
	
	public void setTotalPageNumber(Integer totalPageNumber)
	{
		this.totalPageNumber = totalPageNumber;
	}
}
