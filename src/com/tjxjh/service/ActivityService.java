package com.tjxjh.service;

import java.io.File;
import java.util.List;
import java.util.Set;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import com.tjxjh.enumeration.ActivityStatus;
import com.tjxjh.enumeration.TalkingUrlType;
import com.tjxjh.enumeration.UserStatus;
import com.tjxjh.po.Activity;
import com.tjxjh.po.Club;
import com.tjxjh.po.ClubMember;
import com.tjxjh.po.Merchant;
import com.tjxjh.po.Talking;
import com.tjxjh.po.User;
import com.tjxjh.util.DeleteSource;
import com.tjxjh.util.FileUtil;
import com.tjxjh.util.ImageCutAndZoom;

import cn.cafebabe.autodao.pojo.Page;
import cn.cafebabe.websupport.service.BaseService;

@Service
public class ActivityService extends BaseService{
	Activity activity;
	@Resource
	private TalkingService talkingService = null;
	public Talking initTalking(Activity activity,User user){
		Talking talking=new Talking();
		talking.setUser(user);
		talking.setText(activity.getTittle());
		if(activity.getVideoUrl()==null||activity.getVideoUrl().equals("")){
			talking.setUrl(activity.getTitleImgPath());
			talking.setUrlType(TalkingUrlType.PICTURE);
		}else{
			talking.setUrl(activity.getVideoUrl());
			talking.setUrlType(TalkingUrlType.VIDEO);
		}
		return talking;
	}
	public Talking initTalking(Activity activity,Activity oldactivity){
		Talking oldtalking=new Talking();
		oldtalking=oldactivity.getTalking();
		Talking talking=new Talking();
		talking.setId(oldtalking.getId());
		talking.setDatetime(oldtalking.getDatetime());
		talking.setShareDetails(oldtalking.getShareDetails());
		talking.setStatus(oldtalking.getStatus());
		talking.setUser(oldtalking.getUser());
		if(talking.getId()!=1){//表示已经有说说了
			
		}
		else if(oldactivity.getMerchant()!=null){
			talking.setUser(oldactivity.getMerchant().getUser());
		}else if(oldactivity.getClub()!=null){
			talking.setUser(oldactivity.getClub().getUser());
		}
		talking.setText(activity.getTittle());
		if(activity.getVideoUrl()==null||activity.getVideoUrl().equals("")){
			talking.setUrl(activity.getTitleImgPath());
			talking.setUrlType(TalkingUrlType.PICTURE);
		}else{
			talking.setUrl(activity.getVideoUrl());
			talking.setUrlType(TalkingUrlType.VIDEO);
		}
		return talking;
	}
	public Talking initTalking(Activity activity){
		Talking talking=new Talking();
		User user=new User();
		user.setId(1);
		talking.setUser(user);
		talking.setText(activity.getTittle());
		if(activity.getVideoUrl()==null||activity.getVideoUrl().equals("")){
			talking.setUrl(activity.getTitleImgPath());
			talking.setUrlType(TalkingUrlType.PICTURE);
		}else{
			talking.setUrl(activity.getVideoUrl());
			talking.setUrlType(TalkingUrlType.VIDEO);
		}
		return talking;
	}
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean add(Talking talking,Activity activity){
		talkingService.add(talking);
		System.out.println("----------------------"+talking.getId());
		activity.setTalking(talking);
		activity.setStatus(ActivityStatus.UNDERWAY);
		super.save(activity);
		talking.setText("<a href='getOnlineActivityById?onlineactivity.id="+activity.getId()+"' target='_blank'>"+activity.getTittle()+"</a>");
		talkingService.update(talking);
		return true;
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean add(Activity activity){
		activity.setStatus(ActivityStatus.APPLY);
		return super.save(activity);
	}
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean addOrUpdate(Talking talking ,Activity activity){
		if(talking.getId()!=null&&talking.getId()!=1){
			talkingService.update(talking);
		}else{
			talking.setId(null);
			talkingService.add(talking);
		}
		System.out.println("----------------------"+talking.getId());
		activity.setTalking(talking);
		return super.update(activity);
	}
	
	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true, propagation=Propagation.SUPPORTS)   
	public Activity findByHql(User user,Merchant merchant,Activity activity){
			List<ClubMember> list=null;
			activity=findById(activity.getId());
			if(user.getStatus()==UserStatus.ADMIN){//管理员登录
				return activity;
			}
			Club club=activity.getClub();
			Merchant oldmerchant=activity.getMerchant();
			if(club!=null){
				list=(List<ClubMember>) dao.executeHql("from ClubMember cm where cm.user.id=? and cm.club.id=? and cm.role in ('MANAGER','PROPRIETER')"
						,user.getId(),club.getId());
				if(list.size()==1){
					return activity;
				}
			}else if(oldmerchant!=null){
				int merchantid=oldmerchant.getId();
				if(merchantid==merchant.getId())
				{
					return activity;
				}
				
			}
			return null;
		
	}
	@Transactional (propagation = Propagation.REQUIRED) 
	public void delete(Activity activity){
		if(activity!=null){
				DeleteSource.deleteVideo(activity.getVideoUrl());
				DeleteSource.delete(activity.getTitleImgPath());
				DeleteSource.deleteImg(activity.getText());
		}
		dao.delete(activity);
	}
	
	@Transactional(readOnly = true, propagation=Propagation.SUPPORTS)   
	public Activity findById(Integer id){
		return dao.findById(Activity.class, id);
	}
	
	public boolean uploadImage(Activity activity, File uploadImage,String uploadImageFileName,String imagePath){
			HttpServletRequest request=ServletActionContext.getRequest();
			String savepath="";
			boolean flage=false;
			if(activity.getTitleImgPath()!=null&&!activity.getTitleImgPath().trim().equals("")){
				if(FileUtil.testFileType(activity.getTitleImgPath())==TalkingUrlType.PICTURE){
					return true;
				}
			}
			if(uploadImage!=null&&FileUtil.allowfile(uploadImageFileName).equals(TalkingUrlType.PICTURE.toString()))
			{
				savepath = FileUtil.copyFile(uploadImage.getAbsolutePath(),imagePath);//将图片上传至服务器
				flage = ImageCutAndZoom.zoom(ServletActionContext.getServletContext().getRealPath(savepath));
				 if (savepath!=null&&!savepath.equals("")&&flage==true)
					{
					 activity.setTitleImgPath(request.getContextPath()+savepath);
					 return true;
					}
			}
		return false;
	}
	public boolean uploadVideo(Activity activity,File uploadVideo,String uploadVideoFileName,String videoPath){
	    HttpServletRequest request=ServletActionContext.getRequest();
		String savepath="";
		if(activity.getVideoUrl()!=null&&!activity.getVideoUrl().trim().equals("")){
			if(FileUtil.testFileType(activity.getVideoUrl())==TalkingUrlType.VIDEO){
				return true;
			}
		}
		if(uploadVideo!=null&&FileUtil.allowfile(uploadVideoFileName).equals(TalkingUrlType.VIDEO.toString())){
			savepath = FileUtil.copyFile(uploadVideo.getAbsolutePath(),videoPath);//将视频上传至服务器
		    if (savepath!=null)
			{
		    	//系统根目录为tomcat 根目录，故需要添加网站更目录
		    	String str="<embed src='"+request.getContextPath()+"/video/ckplayer/ckplayer.swf?p=0&c=1&i="+request.getContextPath()+"/video/ckplayer/xiaojh.png' " +
		    			"flashvars='f="+request.getContextPath()+savepath+"' quality='high' width='480' height='400' align='middle' " +
		    			"allowScriptAccess='always' allowFullscreen='true' type='application/x-shockwave-flash'></embed>";	
		    	 activity.setVideoUrl(str);
		    	 return true;
			}
		}
		return true;
	}
	/**************************************************根据用户所在社团、关注社团、关注商家 查询活动*******************************************************/
	@Transactional (propagation = Propagation.REQUIRED) 
	public Page getRelativeActivityPageByHql(User user,Integer eachPageNumber,Integer currentPage,Integer totalPageNumber)
	{
		if(currentPage<=0){
			currentPage=1;
		}
		if(totalPageNumber!=0){
			return Page.getPage(currentPage, eachPageNumber, totalPageNumber);
		}
		user=dao.findById(User.class, user.getId());
		String sql="select count(*) from Activity c where c.status in('UNDERWAY','END') and (c.club.id in (select club.id from ClubMember cl where cl.user.id=?) ";
		//关注的社团
		Set<Club> clubs=user.getFocusClubs();
		StringBuilder str=new StringBuilder();
		for(Club c:clubs){
			str.append(c.getId()+",");
		}
		if(str.length()>0){
			sql=sql+"or c.club.id in ("+str.substring(0, str.length()-1)+")";
		}
		//关注的商家
		Set<Merchant> merchants=user.getMerchants();
		StringBuilder str2=new StringBuilder();
		for(Merchant m:merchants){
			str2.append(m.getId()+",");
		}
		if(str2.length()>0){
			sql=sql+" or c.merchant.id in ("+str2.substring(0, str2.length()-1)+")";
		}
		sql=sql+")";
		try{
			Page page= dao.getPageByHql(eachPageNumber,sql,user.getId());
			page.setCurrentPage(currentPage);
			return page;
		}catch(Exception e){
			System.out.println("---------ActivityService--getMyPageByHql--------"+e);
			return null;
		}
	}
	@SuppressWarnings("unchecked")
	public List<Activity> findRelativeActivityByHql(Page page,User  user,String condition)
	{
		if(page==null){
			return null;
		}
		user=dao.findById(User.class, user.getId());
		String sql="from Activity  c where  c.status in('UNDERWAY','END') and (c.club.id in (select club.id from ClubMember cl where cl.user.id=? ) ";
		//关注的社团
		Set<Club> clubs=user.getFocusClubs();
		StringBuilder str=new StringBuilder();
		for(Club c:clubs){
			str.append(c.getId()+",");
		}
		if(str.length()>0){
			sql=sql+"or c.club.id in ("+str.substring(0, str.length()-1)+") ";
		}
		//关注的商家
		Set<Merchant> merchants=user.getMerchants();
		StringBuilder str2=new StringBuilder();
		for(Merchant m:merchants){
			str2.append(m.getId()+",");
		}
		if(str2.length()>0){
			sql=sql+" or c.merchant.id in ("+str2.substring(0, str2.length()-1)+")";
		}
		
		sql=sql+") order by "+condition+" desc";
		
		try{
			return (List<Activity>) dao.executeHql(page,sql,user.getId()); 
		}catch(Exception e){
			System.out.println(e);
			return null;
		}
	}
	/*************************************************END:根据用户所在社团查询活动*****************************************************/
//	/**********************************************************查看某个社团的活动*****************************************************/
//	@Transactional (propagation = Propagation.REQUIRED) 
//	public Page getOneClubPageByHql(Integer eachPageNumber,Integer currentPage,Integer totalPageNumber,Club club,Merchant merchant)
//	{
//		if(currentPage<=0){
//			currentPage=1;
//		}
//		if(totalPageNumber!=0){
//			return Page.getPage(currentPage, eachPageNumber, totalPageNumber);
//		}
//		try{
//			Page page=null;
//			if(club.getId()!=null){
//				page=dao.getPageByHql(eachPageNumber,"select count(*) from Activity cl  where cl.status in('UNDERWAY','END') and cl.club.id=?",club.getId());
//			}else if(merchant.getId()!=null){
//				page=dao.getPageByHql(eachPageNumber,"select count(*) from Activity cl where cl.status in('UNDERWAY','END') and cl.merchant.id=?",merchant.getId());
//			}else{
//				return null;
//			}
//			page.setCurrentPage(currentPage);
//			return page;
//		}catch (Exception e){
//			System.out.println("---------ActivityService--getAllPageByHql--------"+e);
//			return null;
//		}
//	}
//	@SuppressWarnings("unchecked")
//	public List<Activity> findOneClubActivityByHql(Page page,Club club,Merchant merchant,String condition)
//	{
//		if(page==null){
//			return null;
//		}
//		try{
//			if(club.getId()!=null){
//				return (List<Activity>) dao.executeHql(page,"from Activity cl where cl.status in('UNDERWAY','END') and cl.club.id=? order by "+condition+" desc",club.getId());
//			}else if(merchant.getId()!=null){
//				return (List<Activity>) dao.executeHql(page,"from Activity cl where cl.status in('UNDERWAY','END') and cl.merchant.id=? order by "+condition+" desc",merchant.getId());
//			}else{
//				return null;
//			}
//		}catch(Exception e){
//			System.out.println(e);
//			return null;
//		}
//	}
//	/********************************************************END：查看某个社团的活动***************************************************/
	/**********************************************************管理员查看某个社团的活动*****************************************************/
	@Transactional (propagation = Propagation.REQUIRED) 
	public Page getOneClubPageByHql(Integer eachPageNumber,Integer currentPage,Integer totalPageNumber,Club club,Merchant merchant,int flage)
	{
		//flage=0表示查看所有所动，1表示查看尚未审核活动，2是查看已经审核的活动，3查看已经拒绝的活动
		if(currentPage<=0){
			currentPage=1;
		}
		if(totalPageNumber!=0){
			return Page.getPage(currentPage, eachPageNumber, totalPageNumber);
		}
		try{
			Page page=null;
			if(club.getId()!=null){
				if(flage==0){
					page=dao.getPageByHql(eachPageNumber,"select count(*) from Activity cl  where  cl.club.id=?",club.getId());
				}else if(flage==1){
					page=dao.getPageByHql(eachPageNumber,"select count(*) from Activity cl  where  cl.club.id=? and cl.status in ('APPLY')",club.getId());
				}else if(flage==2){
					page=dao.getPageByHql(eachPageNumber,"select count(*) from Activity cl  where  cl.club.id=? and cl.status in ('UNDERWAY','END')",club.getId());
				}else if(flage==3){
					page=dao.getPageByHql(eachPageNumber,"select count(*) from Activity cl  where  cl.club.id=? and cl.status in ('REFUSE')",club.getId());
				}else{
					return null;
				}
			}else if(merchant.getId()!=null){
				if(flage==0){
					page=dao.getPageByHql(eachPageNumber,"select count(*) from Activity cl  where  cl.merchant.id=?",merchant.getId());
				}else if(flage==1){
					page=dao.getPageByHql(eachPageNumber,"select count(*) from Activity cl  where  cl.merchant.id=? and cl.status in ('APPLY')",merchant.getId());
				}else if(flage==2){
					page=dao.getPageByHql(eachPageNumber,"select count(*) from Activity cl  where  cl.merchant.id=? and cl.status in ('UNDERWAY','END')",merchant.getId());
				}else if(flage==3){
					page=dao.getPageByHql(eachPageNumber,"select count(*) from Activity cl  where  cl.merchant.id=? and cl.status in ('REFUSE')",merchant.getId());
				}else{
					return null;
				}
			}else{
				if(flage==0){
					page=dao.getPageByHql(eachPageNumber,"select count(*) from Activity cl");
				}else if(flage==1){
					page=dao.getPageByHql(eachPageNumber,"select count(*) from Activity cl  where cl.status in ('APPLY')");
				}else if(flage==2){
					page=dao.getPageByHql(eachPageNumber,"select count(*) from Activity cl  where cl.status in ('UNDERWAY','END')");
				}else if(flage==3){
					page=dao.getPageByHql(eachPageNumber,"select count(*) from Activity cl  where cl.status in ('REFUSE')");
				}else{
					return null;
				}
			}
			page.setCurrentPage(currentPage);
			return page;
		}catch (Exception e){
			System.out.println("---------ActivityService--getAllPageByHql--------"+e);
			return null;
		}
	}
	@SuppressWarnings("unchecked")
	public List<Activity> getOneClubActivityByHql(Page page,Club club,Merchant merchant,String condition,int flage)
	{
		if(page==null){
			return null;
		}
		try{
			if(club!=null&&club.getId()!=null){
				if(flage==0){
					return (List<Activity>) dao.executeHql(page,"from Activity cl where cl.club.id=? order by "+condition+" desc",club.getId());
				}else if(flage==1){
					return (List<Activity>) dao.executeHql(page,"from Activity cl where cl.club.id=? and cl.status in ('APPLY') order by "+condition+" desc",club.getId());
				}else if(flage==2){
					return (List<Activity>) dao.executeHql(page,"from Activity cl where cl.club.id=? and cl.status in ('UNDERWAY','END') order by "+condition+" desc",club.getId());
				}else if(flage==3){
					return (List<Activity>) dao.executeHql(page,"from Activity cl where cl.club.id=? and cl.status in ('REFUSE') order by "+condition+" desc",club.getId());
				}else{
					return null;
				}
			}else if(merchant!=null&&merchant.getId()!=null){
				if(flage==0){
					return (List<Activity>) dao.executeHql(page,"from Activity cl where cl.merchant.id=? order by "+condition+" desc",merchant.getId());
				}else if(flage==1){
					return (List<Activity>) dao.executeHql(page,"from Activity cl where cl.merchant.id=? and cl.status in ('APPLY') order by "+condition+" desc",merchant.getId());
				}else if(flage==2){
					return (List<Activity>) dao.executeHql(page,"from Activity cl where cl.merchant.id=? and cl.status in ('UNDERWAY','END') order by "+condition+" desc",merchant.getId());
				}else if(flage==3){
					return (List<Activity>) dao.executeHql(page,"from Activity cl where cl.merchant.id=? and cl.status in ('REFUSE') order by "+condition+" desc",merchant.getId());
				}else{
					return null;
				}
			}else{
				if(flage==0){
					return (List<Activity>) dao.executeHql(page,"from Activity cl order by "+condition+" desc");
				}else if(flage==1){
					return (List<Activity>) dao.executeHql(page,"from Activity cl where cl.status in ('APPLY') order by "+condition+" desc");
				}else if(flage==2){
					return (List<Activity>) dao.executeHql(page,"from Activity cl where cl.status in ('UNDERWAY','END') order by "+condition+" desc");
				}else if(flage==3){
					return (List<Activity>) dao.executeHql(page,"from Activity cl where cl.status in ('REFUSE') order by "+condition+" desc");
				}else{
					return null;
				}
			}
		}catch(Exception e){
			System.out.println(e);
			return null;
		}
	}
	/********************************************************END：查看某个社团的活动***************************************************/
	/********************************************************首页查询社团商家的活动***************************************************/
	@SuppressWarnings("unchecked")
	public List<Activity> findOneActivityByHql(Club club,Merchant merchant)
	{
		Page page=Page.getPage(1,3, 1);
		try{
			if(club!=null&&club.getId()!=null){
				return (List<Activity>) dao.executeHql(page,"from Activity cl where cl.status in('UNDERWAY','END') and cl.club.id=? order by datetime desc",club.getId());
			}else if(merchant!=null&&merchant.getId()!=null){
				return (List<Activity>) dao.executeHql(page,"from Activity cl where cl.status in('UNDERWAY','END') and cl.merchant.id=? order by datetime desc",merchant.getId());
			}else{
				return null;
			}
		}catch(Exception e){
			System.out.println(e);
			return null;
		}
	}
	public TalkingService getTalkingService() {
		return talkingService;
	}


	public void setTalkingService(TalkingService talkingService) {
		this.talkingService = talkingService;
	}
	
}
