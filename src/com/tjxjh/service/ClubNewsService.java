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

import cn.cafebabe.autodao.pojo.Page;
import cn.cafebabe.websupport.service.BaseService;

import com.tjxjh.enumeration.TalkingUrlType;
import com.tjxjh.po.Club;
import com.tjxjh.po.ClubNews;
import com.tjxjh.po.Talking;
import com.tjxjh.po.User;
import com.tjxjh.util.DeleteSource;
import com.tjxjh.util.FileUtil;
import com.tjxjh.util.ImageCutAndZoom;

@Service
public class ClubNewsService extends BaseService{
	ClubNews clubnews;
	@Resource
	private TalkingService talkingService = null;
	
	public List<ClubNews> allClubNews(Page page){
		String hql = "from ClubNews n order by n.datetime desc";
		List<ClubNews> list = (List<ClubNews>) dao.executeHql(page,hql);
		return list;
	}
	
	public Page clubNewsNum(Page page){
		String hql = "select count(*) from ClubNews";
		List<Long> countL = null;
		countL = (List<Long>)dao.executeHql(hql);
		int itemNum = countL.get(0).intValue();
		return new Page(page.getCurrentPage(),Page.getDefaultPageNumber(),itemNum);
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public boolean add(Talking talking ,ClubNews clubnews){
		talkingService.add(talking);
		System.out.println("----------------------"+talking.getId());
		clubnews.setTalking(talking);
		return super.save(clubnews);
	}
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean update(Talking talking ,ClubNews clubnews){
		talkingService.update(talking);
		System.out.println("----------------------"+talking.getId());
		clubnews.setTalking(talking);
		return super.update(clubnews);
	}

	public Talking initTalking(ClubNews clubnews,User user){
		Talking talking=new Talking();
		talking.setUser(user);
		talking.setText(clubnews.getTittle());
		if(clubnews.getVideoUrl()==null||clubnews.getVideoUrl().equals("")){
			talking.setUrl(clubnews.getTitleImgPath());
			talking.setUrlType(TalkingUrlType.PICTURE);
		}else{
			talking.setUrl(clubnews.getVideoUrl());
			talking.setUrlType(TalkingUrlType.VIDEO);
		}
		return talking;
	}
	@Transactional(readOnly = true, propagation=Propagation.SUPPORTS)   
	public ClubNews findByHql(User user,ClubNews clubnews){
		try{
		clubnews=findById(clubnews.getId());
		Club club=clubnews.getClub();
		@SuppressWarnings("unchecked")
		List<ClubNews> list=(List<ClubNews>) dao.executeHql("from ClubNews cn where cn.id=? and ? in " +
				"(select user.id from ClubMember cm where cm.club.id=? and cm.role in ('MANAGER','PROPRIETER'))"
				,clubnews.getId(),user.getId(),club.getId());
		if(list.size()!=1)
		{
			return null;
		}
		else
		{
			return list.get(0);
		}
		}catch(Exception e){
			System.out.println("-------------ClubNewsService------------"+e);
			return null;
		}
	}
	@Transactional (propagation = Propagation.REQUIRED) 
	public void delete(ClubNews clubnews){
		 DeleteSource.deleteVideo(clubnews.getVideoUrl());
		 DeleteSource.delete(clubnews.getTitleImgPath());
		 DeleteSource.deleteImg(clubnews.getText());
		 dao.delete(clubnews);
	}
	
	@Transactional(readOnly = true, propagation=Propagation.SUPPORTS)   
	public ClubNews findById(Integer id){
		return dao.findById(ClubNews.class, id);
	}
	public boolean uploadImage(ClubNews clubnews, File uploadImage,String uploadImageFileName,String imagePath){
			HttpServletRequest request=ServletActionContext.getRequest();
			String savepath="";
			boolean flage=false;
			if(clubnews.getTitleImgPath()!=null&&!clubnews.getTitleImgPath().trim().equals("")){
				if(FileUtil.testFileType(clubnews.getTitleImgPath())==TalkingUrlType.PICTURE){
					return true;
				}
			}
			if(uploadImage!=null&&FileUtil.allowfile(uploadImageFileName).equals(TalkingUrlType.PICTURE.toString()))
			{
				savepath = FileUtil.copyFile(uploadImage.getAbsolutePath(),imagePath);//将图片上传至服务器
				flage = ImageCutAndZoom.zoom(ServletActionContext.getServletContext().getRealPath(savepath));
				 if (savepath!=null&&!savepath.equals("")&&flage==true)
					{
					 clubnews.setTitleImgPath(request.getContextPath()+savepath);
					 return true;
					}
			}
		return false;
	}
	public boolean uploadVideo(ClubNews clubnews,File uploadVideo,String uploadVideoFileName,String videoPath){
	    HttpServletRequest request=ServletActionContext.getRequest();
		String savepath="";
		if(clubnews.getVideoUrl()!=null&&!clubnews.getVideoUrl().trim().equals("")){
			if(FileUtil.testFileType(clubnews.getVideoUrl())==TalkingUrlType.VIDEO){
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
		    	 clubnews.setVideoUrl(str);
		    	 return true;
			}
		}
		return true;
	}
	/***************************************************根据用户所在社团查询活动*******************************************************/
	@Transactional (propagation = Propagation.REQUIRED) 
	public Page getMyPageByHql(User user,Integer eachPageNumber,Integer currentPage,Integer totalPageNumber)
	{
		if(currentPage<=0){
			currentPage=1;
		}
		if(totalPageNumber!=0){
			return Page.getPage(currentPage, eachPageNumber, totalPageNumber);
		}
		user=dao.findById(User.class, user.getId());
		String sql="select count(*) from ClubNews c where c.club.id in (select club.id from ClubMember cl where cl.user.id=?) ";
		Set<Club> clubs=user.getFocusClubs();
		StringBuilder str=new StringBuilder();
		for(Club c:clubs){
			str.append(c.getId()+",");
		}
		if(str.length()>0){
			sql=sql+"or c.club.id in ("+str.substring(0, str.length()-1)+")";
		}
		try{
			Page page= dao.getPageByHql(eachPageNumber,sql,user.getId());
			page.setCurrentPage(currentPage);
			return page;
		}catch(Exception e){
			System.out.println("---------ClubNewsService--getMyPageByHql--------"+e);
			return null;
		}
	}
	@SuppressWarnings("unchecked")
	public List<ClubNews> findMyClubNewsByHql(Page page,User  user)
	{
		if(page==null){
			return null;
		}
		user=dao.findById(User.class, user.getId());
		String sql="from ClubNews  c where c.club.id in (select club.id from ClubMember cl where cl.user.id=? ) ";
		Set<Club> clubs=user.getFocusClubs();
		StringBuilder str=new StringBuilder();
		for(Club c:clubs){
			str.append(c.getId()+",");
		}
		if(str.length()>0){
			sql=sql+"or c.club.id in ("+str.substring(0, str.length()-1)+") order by datetime desc";
		}else{
			sql=sql+"order by datetime desc";
		}
		return (List<ClubNews>) dao
				.executeHql(page,sql,user.getId()); 
	}
	/*************************************************END:根据用户所在社团查询活动*****************************************************/
	/**********************************************************查看某个社团的活动*****************************************************/
	@Transactional (propagation = Propagation.REQUIRED) 
	public Page getOneClubPageByHql(Integer eachPageNumber,Integer currentPage,Club club,Integer totalPageNumber)
	{
		if(currentPage<=0){
			currentPage=1;
		}
		if(totalPageNumber!=0){
			return Page.getPage(currentPage, eachPageNumber, totalPageNumber);
		}
		try{
			Page page=dao.getPageByHql(eachPageNumber,
							"select count(*) from ClubNews cl where cl.club.id=?",club.getId());
			page.setCurrentPage(currentPage);
			return page;
		}catch (Exception e){
			System.out.println("---------ClubNewsService--getAllPageByHql--------"+e);
			return null;
		}
	}
	@SuppressWarnings("unchecked")
	public List<ClubNews> findOneClubNewsByHql(Page page,Club club)
	{
		if(page==null){
			return null;
		}
		return (List<ClubNews>) dao
				.executeHql(
						page,
						"from ClubNews cl where cl.club.id=? order by datetime desc",club.getId()
						);
	}
	/********************************************************END：查看某个社团的活动***************************************************/
//	@Transactional(readOnly = true, propagation=Propagation.SUPPORTS)   
//	public Picture findByHql(Object... params){
//		@SuppressWarnings("unchecked")
//		List<Picture> list=(List<Picture>) dao.executeHql("from Picture p where p.user.id=? and p.id=?", params);
//		if(list.size()!=1)
//		{
//			return null;
//		}
//		else
//		{
//			return list.get(0);
//		}
//	}
//	
//	@Transactional(readOnly = true, propagation=Propagation.SUPPORTS)   
//	public List<Picture> findAll(Page pageInfo){
//		return dao.findAll(Picture.class,pageInfo);
//	}
//	
//	@Transactional(readOnly = true, propagation=Propagation.SUPPORTS)   
//	public Page totalCount(Picture picture,Integer eachPageNumber){
//		return dao.getPageByExample(picture,eachPageNumber);
//	}
//	
//	@Transactional (propagation = Propagation.REQUIRED) 
//	public Picture update(Picture picture){
//		return dao.merge(picture);
//	}

	public TalkingService getTalkingService() {
		return talkingService;
	}

	public void setTalkingService(TalkingService talkingService) {
		this.talkingService = talkingService;
	}
	
}
