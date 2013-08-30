package com.tjxjh.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.opensymphony.xwork2.ActionContext;
import com.tjxjh.enumeration.OnlineActivityStatus;
import com.tjxjh.enumeration.TalkingUrlType;
import com.tjxjh.po.OnlineActivity;
import com.tjxjh.po.Club;
import com.tjxjh.po.Merchant;
import com.tjxjh.po.Talking;
import com.tjxjh.po.User;
import com.tjxjh.util.DeleteSource;
import com.tjxjh.util.FileUtil;
import com.tjxjh.util.ImageCutAndZoom;

import cn.cafebabe.autodao.pojo.Page;
import cn.cafebabe.websupport.service.BaseService;

@Service
public class OnlineActivityService extends BaseService{
	OnlineActivity activity;
	@Resource
	private TalkingService talkingService = null;
	public Talking initTalking(OnlineActivity activity,User user){
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
	

	@Transactional(propagation = Propagation.REQUIRED)
	public boolean add(Talking talking,OnlineActivity activity){
		talkingService.add(talking);
		System.out.println("----------------------"+talking.getId());
		activity.setTalking(talking);
		activity.setStatus(OnlineActivityStatus.UNDERWAY);
		super.save(activity);
		talking.setText("<a href='getOnlineActivityById?onlineactivity.id="+activity.getId()+"' target='_blank'>"+activity.getTittle()+"</a>");
		talkingService.update(talking);
		return true;
	}
	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true, propagation=Propagation.SUPPORTS)   
	public OnlineActivity findByHql(User user,Merchant merchant,Club club,OnlineActivity activity){
			List<OnlineActivity> list=null;
			String hql="from OnlineActivity oa where oa.id=? and ( 1=1 ";
			if(user!=null&&user.getId()!=null){
				hql=hql+"or oa.user.id="+user.getId();
			}
			if(club!=null&&club.getId()!=null){
				club=dao.findById(Club.class, club.getId());
				hql=hql+" or oa.user.id in (select cm.user.id from ClubMember cm where  cm.club.id="+club.getId()+" and cm.role in ('MANAGER','PROPRIETER'))";
				hql=hql+" or oa.user.id="+club.getUser().getId();
			}
			if(merchant!=null&&merchant.getId()!=null){
				merchant=dao.findById(Merchant.class, merchant.getId());
				hql=hql+" or oa.user.id="+merchant.getUser().getId();
			}
			list=(List<OnlineActivity>) dao.executeHql(hql+")",activity.getId());
			if(list.size()==1){
				return list.get(0);
			}
			return null;
	}
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean update(Talking talking ,OnlineActivity activity){
			talkingService.update(talking);
			return super.update(activity);
	}
	public Talking initTalking(OnlineActivity activity,Talking oldtalking){
		Talking talking=new Talking();
		talking.setText(activity.getTittle());
		if(activity.getVideoUrl()==null||activity.getVideoUrl().equals("")){
			talking.setUrl(activity.getTitleImgPath());
			talking.setUrlType(TalkingUrlType.PICTURE);
		}else{
			talking.setUrl(activity.getVideoUrl());
			talking.setUrlType(TalkingUrlType.VIDEO);
		}
		talking.setDatetime(oldtalking.getDatetime());
		talking.setStatus(oldtalking.getStatus());
		talking.setUser(oldtalking.getUser());
		int id=oldtalking.getId();
		talking.setId(id);
		return talking;
	}
//	@SuppressWarnings("unchecked")
//	@Transactional(readOnly = true, propagation=Propagation.SUPPORTS)   
//	public OnlineActivity findByHql(User user,Merchant merchant,OnlineActivity activity){
//			List<ClubMember> list=null;
//			activity=findById(activity.getId());
//			if(club!=null){
//				list=(List<ClubMember>) dao.executeHql("from ClubMember cm where cm.user.id=? and cm.club.id=? and cm.role in ('MANAGER','PROPRIETER')"
//						,user.getId(),club.getId());
//				if(list.size()==1){
//					return activity;
//				}
//			}else if(oldmerchant!=null){
//				int merchantid=oldmerchant.getId();
//				if(merchantid==merchant.getId())
//				{
//					return activity;
//				}
//				
//			}
//			return null;
//		
//	}
	@Transactional (propagation = Propagation.REQUIRED) 
	public void delete(OnlineActivity activity){
		activity=dao.findById(OnlineActivity.class, activity.getId());
		DeleteSource.deleteVideo(activity.getVideoUrl());
		DeleteSource.delete(activity.getTitleImgPath());
		DeleteSource.deleteImg(activity.getText());
		dao.delete(activity);
	}
	
	@Transactional(readOnly = true, propagation=Propagation.SUPPORTS)   
	public OnlineActivity findById(Integer id){
		return dao.findById(OnlineActivity.class, id);
	}
	
	public boolean uploadImage(OnlineActivity activity, File uploadImage,String uploadImageFileName,String imagePath){
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
	public boolean uploadVideo(OnlineActivity activity,File uploadVideo,String uploadVideoFileName,String videoPath){
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
	/**************************************************根据用户所在社团、关注社团、关注商家 查询在线活动*******************************************************/
	@Transactional (propagation = Propagation.REQUIRED) 
	public Page getRelativeOnlineActivityPageByHql(User user,Integer eachPageNumber,Integer currentPage,Integer totalPageNumber)
	{
		if(currentPage<=0){
			currentPage=1;
		}
		if(totalPageNumber!=0){
			return Page.getPage(currentPage, eachPageNumber, totalPageNumber);
		}
		user=dao.findById(User.class, user.getId());
		String sql="select count(*) from OnlineActivity c where 1=1 ";
		ActionContext context = ActionContext.getContext();  
	    Map<String, Object> session = context.getSession();
		ArrayList<User> users=(ArrayList<User>) session.get("relativeUsers");
		
		StringBuilder str3=new StringBuilder();
		for(User u:users){
			str3.append(u.getId()+",");
		}
		if(str3.length()>0){
			sql=sql+"and c.user.id in ("+str3.substring(0, str3.length()-1)+")";
		}
		
		try{
			Page page= dao.getPageByHql(eachPageNumber,sql);
			page.setCurrentPage(currentPage);
			return page;
		}catch(Exception e){
			System.out.println("---------OnlineActivityService--getRelativeOnlineActivityPageByHql--------"+e);
			return null;
		}
	}
	@SuppressWarnings("unchecked")
	public List<OnlineActivity> findRelativeOnlineActivityByHql(Page page,User  user)
	{
		if(page==null){
			return null;
		}
		user=dao.findById(User.class, user.getId());
		String sql="from OnlineActivity  c where  1=1 ";
		
		ActionContext context = ActionContext.getContext();  
	    Map<String, Object> session = context.getSession();
		ArrayList<User> users=(ArrayList<User>) session.get("relativeUsers");
		
		StringBuilder str3=new StringBuilder();
		for(User u:users){
			str3.append(u.getId()+",");
		}
		if(str3.length()>0){
			sql=sql+"and c.user.id in ("+str3.substring(0, str3.length()-1)+") order by datetime desc";
		}
		try{
			return (List<OnlineActivity>) dao.executeHql(page,sql); 
		}catch(Exception e){
			System.out.println(e);
			return null;
		}
	}
	/*************************************************END:根据用户所在社团查询活动*****************************************************/
	/**********************************************************查看某个在线活动*****************************************************/
	@Transactional (propagation = Propagation.REQUIRED) 
	public Page getOneOnlineActivityPageByHql(Integer eachPageNumber,Integer currentPage,Integer totalPageNumber,Club club,Merchant merchant,User user)
	{
		if(currentPage<=0){
			currentPage=1;
		}
		if(totalPageNumber!=0){
			return Page.getPage(currentPage, eachPageNumber, totalPageNumber);
		}
		try{
   			Page page=null;
			if(club!=null&&club.getId()!=null){
				club=dao.findById(Club.class, club.getId());
				page=dao.getPageByHql(eachPageNumber,"select count(*) from OnlineActivity cl  where cl.user.id=?",club.getUser().getId());
			}else if(merchant!=null&&merchant.getId()!=null){
				merchant=dao.findById(Merchant.class, merchant.getId());
				page=dao.getPageByHql(eachPageNumber,"select count(*) from OnlineActivity cl  where cl.user.id=?",merchant.getUser().getId());
			}else if(user!=null&&user.getId()!=null){
				page=dao.getPageByHql(eachPageNumber,"select count(*) from OnlineActivity cl  where cl.user.id=?",user.getId());
			}else{
				return null;
			}
			page.setCurrentPage(currentPage);
			return page;
		}catch (Exception e){
			System.out.println("---------OnlineActivityService--getAllPageByHql--------"+e);
			return null;
		}
	}
	@SuppressWarnings("unchecked")
	public List<OnlineActivity> findOneClubOnlineActivityByHql(Page page,Club club,Merchant merchant,User user)
	{
		if(page==null){
			return null;
		}
		try{
			if(club!=null&&club.getId()!=null){
				club=dao.findById(Club.class, club.getId());
				return (List<OnlineActivity>) dao.executeHql(page,"from OnlineActivity cl where cl.user.id=? order by datetime desc",club.getUser().getId());
			}else if(merchant!=null&&merchant.getId()!=null){
				merchant=dao.findById(Merchant.class, merchant.getId());
				return (List<OnlineActivity>) dao.executeHql(page,"from OnlineActivity cl where cl.user.id=? order by datetime desc",merchant.getUser().getId());
			}else if(user!=null&&user.getId()!=null){
				return (List<OnlineActivity>) dao.executeHql(page,"from OnlineActivity cl where cl.user.id=? order by datetime desc",user.getId());
			}else{
				return null;
			}
		}catch(Exception e){
			System.out.println(e);
			return null;
		}
	}
	/********************************************************END：查看某个在线活动***************************************************/
//	/**********************************************************查看某个社团的活动*****************************************************/
//	@Transactional (propagation = Propagation.REQUIRED) 
//	public Page adminGetOneClubPageByHql(Integer eachPageNumber,Integer currentPage,Integer totalPageNumber,Club club,Merchant merchant)
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
//				page=dao.getPageByHql(eachPageNumber,"select count(*) from OnlineActivity cl  where  cl.club.id=?",club.getId());
//			}else if(merchant.getId()!=null){
//				page=dao.getPageByHql(eachPageNumber,"select count(*) from OnlineActivity cl where  cl.merchant.id=?",merchant.getId());
//			}else{
//				return null;
//			}
//			page.setCurrentPage(currentPage);
//			return page;
//		}catch (Exception e){
//			System.out.println("---------OnlineActivityService--getAllPageByHql--------"+e);
//			return null;
//		}
//	}
//	@SuppressWarnings("unchecked")
//	public List<OnlineActivity> adminFindOneClubOnlineActivityByHql(Page page,Club club,Merchant merchant)
//	{
//		if(page==null){
//			return null;
//		}
//		try{
//			if(club.getId()!=null){
//				return (List<OnlineActivity>) dao.executeHql(page,"from OnlineActivity cl where cl.club.id=? order by datetime desc",club.getId());
//			}else if(merchant.getId()!=null){
//				return (List<OnlineActivity>) dao.executeHql(page,"from OnlineActivity cl where cl.merchant.id=? order by datetime desc",merchant.getId());
//			}else{
//				return null;
//			}
//		}catch(Exception e){
//			System.out.println(e);
//			return null;
//		}
//	}
//	/********************************************************END：查看某个社团的活动***************************************************/
//
//	public TalkingService getTalkingService() {
//		return talkingService;
//	}
//
//
//	public void setTalkingService(TalkingService talkingService) {
//		this.talkingService = talkingService;
//	}


	public TalkingService getTalkingService() {
		return talkingService;
	}


	public void setTalkingService(TalkingService talkingService) {
		this.talkingService = talkingService;
	}

	
}
