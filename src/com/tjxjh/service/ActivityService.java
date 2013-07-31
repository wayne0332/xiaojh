package com.tjxjh.service;

import java.io.File;
import java.io.IOException;
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
import com.tjxjh.po.Activity;
import com.tjxjh.po.Club;
import com.tjxjh.po.ClubMember;
import com.tjxjh.po.ClubNews;
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
		return super.save(activity);
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
			try {
				DeleteSource.deleteImg(activity.getText());
			} catch (IOException e) {
				System.out.println("删除文本编辑器上传的图片");
				e.printStackTrace();
			}
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
	public Page getMyActivityPageByHql(User user,Integer eachPageNumber,Integer currentPage,Integer totalPageNumber)
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
		//关注的社团
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
	public List<Activity> findMyActivityByHql(Page page,User  user)
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
		
		sql=sql+") order by datetime desc";
		
		try{
			return (List<Activity>) dao.executeHql(page,sql,user.getId()); 
		}catch(Exception e){
			System.out.println(e);
			return null;
		}
	}
	/*************************************************END:根据用户所在社团查询活动*****************************************************/
	/**********************************************************查看某个社团的活动*****************************************************/
	@Transactional (propagation = Propagation.REQUIRED) 
	public Page getOneClubPageByHql(Integer eachPageNumber,Integer currentPage,Integer totalPageNumber,Club club,Merchant merchant)
	{
		if(currentPage<=0){
			currentPage=1;
		}
		if(totalPageNumber!=0){
			return Page.getPage(currentPage, eachPageNumber, totalPageNumber);
		}
		try{
			Page page=null;
			if(club.getId()!=null){
				page=dao.getPageByHql(eachPageNumber,"select count(*) from Activity cl  where cl.status in('UNDERWAY','END') and cl.club.id=?",club.getId());
			}else if(merchant.getId()!=null){
				page=dao.getPageByHql(eachPageNumber,"select count(*) from Activity cl where cl.status in('UNDERWAY','END') and cl.merchant.id=?",merchant.getId());
			}else{
				return null;
			}
			page.setCurrentPage(currentPage);
			return page;
		}catch (Exception e){
			System.out.println("---------ActivityService--getAllPageByHql--------"+e);
			return null;
		}
	}
	@SuppressWarnings("unchecked")
	public List<Activity> findOneClubActivityByHql(Page page,Club club,Merchant merchant)
	{
		if(page==null){
			return null;
		}
		try{
			if(club.getId()!=null){
				return (List<Activity>) dao.executeHql(page,"from Activity cl where cl.status in('UNDERWAY','END') and cl.club.id=? order by datetime desc",club.getId());
			}else if(merchant.getId()!=null){
				return (List<Activity>) dao.executeHql(page,"from Activity cl where cl.status in('UNDERWAY','END') and cl.merchant.id=? order by datetime desc",merchant.getId());
			}else{
				return null;
			}
		}catch(Exception e){
			System.out.println(e);
			return null;
		}
	}
	/********************************************************END：查看某个社团的活动***************************************************/
	/**********************************************************查看某个社团的活动*****************************************************/
	@Transactional (propagation = Propagation.REQUIRED) 
	public Page adminGetOneClubPageByHql(Integer eachPageNumber,Integer currentPage,Integer totalPageNumber,Club club,Merchant merchant)
	{
		if(currentPage<=0){
			currentPage=1;
		}
		if(totalPageNumber!=0){
			return Page.getPage(currentPage, eachPageNumber, totalPageNumber);
		}
		try{
			Page page=null;
			if(club.getId()!=null){
				page=dao.getPageByHql(eachPageNumber,"select count(*) from Activity cl  where  cl.club.id=?",club.getId());
			}else if(merchant.getId()!=null){
				page=dao.getPageByHql(eachPageNumber,"select count(*) from Activity cl where  cl.merchant.id=?",merchant.getId());
			}else{
				return null;
			}
			page.setCurrentPage(currentPage);
			return page;
		}catch (Exception e){
			System.out.println("---------ActivityService--getAllPageByHql--------"+e);
			return null;
		}
	}
	@SuppressWarnings("unchecked")
	public List<Activity> adminFindOneClubActivityByHql(Page page,Club club,Merchant merchant)
	{
		if(page==null){
			return null;
		}
		try{
			if(club.getId()!=null){
				return (List<Activity>) dao.executeHql(page,"from Activity cl where cl.club.id=? order by datetime desc",club.getId());
			}else if(merchant.getId()!=null){
				return (List<Activity>) dao.executeHql(page,"from Activity cl where cl.merchant.id=? order by datetime desc",merchant.getId());
			}else{
				return null;
			}
		}catch(Exception e){
			System.out.println(e);
			return null;
		}
	}
	/********************************************************END：查看某个社团的活动***************************************************/

	public TalkingService getTalkingService() {
		return talkingService;
	}


	public void setTalkingService(TalkingService talkingService) {
		this.talkingService = talkingService;
	}
	
}
