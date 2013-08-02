package com.tjxjh.action;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import com.tjxjh.po.Club;
import com.tjxjh.po.Merchant;
import com.tjxjh.pojo.IndexClub;
import com.tjxjh.pojo.IndexMerchant;
import com.tjxjh.service.ActivityService;
import com.tjxjh.service.ClubService;
import com.tjxjh.service.MerchantService;
import com.tjxjh.service.UserService;

@ParentPackage("struts-default")
@Namespace("/")
public class IndexAction extends BaseAction{
	private static final long serialVersionUID = 1L;
	@Resource
	private UserService userService = null;
	@Resource
	private MerchantService merchantService = null;
	@Resource
	private	ActivityService activityService = null;
	@Resource
	private ClubService clubService = null;
	List<Club> clubs=null;
	List<IndexClub> ics=new ArrayList<IndexClub>();
	List<IndexMerchant> ims=new ArrayList<IndexMerchant>();
	List<Merchant> merchants=null;
	
	@Action(value = "index", results = {@Result(name = SUCCESS, location = BaseAction.FOREPART
			+ "index.jsp")})
	public String index(){
		clubs=clubService.findHeatClubByHql();
		for(Club c:clubs){
			IndexClub ic=new IndexClub();
			ic.setClub(c);
			ic.setAcs(activityService.findOneActivityByHql(c, null));
			ics.add(ic);
		}
		merchants=merchantService.findHeatMerchantByHql();
		for(Merchant m:merchants){
			IndexMerchant im=new IndexMerchant();
			im.setMerchant(m);
			im.setAcs(activityService.findOneActivityByHql(null, m));
			ims.add(im);
		}
		return SUCCESS;
	}

	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public MerchantService getMerchantService() {
		return merchantService;
	}

	public void setMerchantService(MerchantService merchantService) {
		this.merchantService = merchantService;
	}

	public ActivityService getActivityService() {
		return activityService;
	}

	public void setActivityService(ActivityService activityService) {
		this.activityService = activityService;
	}

	public ClubService getClubService() {
		return clubService;
	}

	public void setClubService(ClubService clubService) {
		this.clubService = clubService;
	}

	public List<IndexClub> getIcs() {
		return ics;
	}

	public void setIcs(List<IndexClub> ics) {
		this.ics = ics;
	}

	public List<IndexMerchant> getIms() {
		return ims;
	}

	public void setIms(List<IndexMerchant> ims) {
		this.ims = ims;
	}
	
	

}
