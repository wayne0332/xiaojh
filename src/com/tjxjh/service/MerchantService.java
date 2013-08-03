package com.tjxjh.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import cn.cafebabe.autodao.pojo.Page;
import cn.cafebabe.websupport.service.BaseService;

import com.tjxjh.enumeration.MerchantStatus;
import com.tjxjh.enumeration.Sex;
import com.tjxjh.enumeration.TalkingUrlType;
import com.tjxjh.enumeration.UserStatus;
import com.tjxjh.po.Activity;
import com.tjxjh.po.Club;
import com.tjxjh.po.Merchant;
import com.tjxjh.po.MerchantNews;
import com.tjxjh.po.User;
import com.tjxjh.util.CodeUtil;
import com.tjxjh.util.FileUtil;
import com.tjxjh.util.ImageCutAndZoom;

@Service
public class MerchantService extends BaseService
{
	private static final String MERCHANT_NEWS_HQL = "from MerchantNews where merchant.id=? order by datetime desc";
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean applyMerchant(Merchant merchant, File logo)
	{
		md5Password(merchant);
		User user = new User(null, merchant.getName(), merchant.getPassword(),
				null, null, merchant.getName(), Sex.MAN, null, null, null,
				Calendar.getInstance().get(Calendar.YEAR), null, null, null,
				null, null, null, null, UserStatus.SYSTEM, null);
		dao.persist(user);
		merchant.setUser(user);
		merchant.setStatus(MerchantStatus.NO_CHECK);
		UserService.savePortrait(merchant.getLogoPath(), logo, 280);
		return super.save(merchant);
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean checkMerchant(Merchant merchant, boolean isPass)
	{
		merchant = dao.findById(Merchant.class, merchant.getId());
		dao.executeUpdateHql("update Merchant set status=? where id=?",
				isPass ? MerchantStatus.PASSED : MerchantStatus.NO_PASSED,
				merchant.getId());
		return true;
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean deleteMerchantNews(MerchantNews merchantNews)
	{
		if((merchantNews = super.getFistObjectOfList(dao
				.findByExample(merchantNews))) != null)
		{
			dao.delete(merchantNews);
			return true;
		}
		else
		{
			return false;
		}
	}
	
	public Merchant merchantById(Merchant merchant)
	{
		return dao.findById(Merchant.class, merchant.getId());
	}
	
	public Merchant login(Merchant merchant)
	{
		try
		{
			Assert.notNull(merchant.getName(), "商家登陆名不能为空");
			return super.login(md5Password(merchant));
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return null;
		}
	}
	
	public Page merchantNewsPage(Merchant merchant)
	{
		return dao.getPageByHql("select count(*) " + MERCHANT_NEWS_HQL,
				merchant.getId());
	}
	
	@SuppressWarnings("unchecked")
	public List<MerchantNews> merchantNews(Merchant merchant, Page page)
	{
		return (List<MerchantNews>) dao.executeHql(page, MERCHANT_NEWS_HQL,
				merchant.getId());
	}
	
	public MerchantNews merchantNewsDetails(MerchantNews merchantNews)
	{
		return super.getFistObjectOfList(dao.findByExample(merchantNews));
	}
	
	public boolean uploadImage(Activity activity, File uploadImage,
			String uploadImageFileName, String imagePath)
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		String savepath = "";
		boolean flage = false;
		if(activity.getTitleImgPath() != null
				&& !activity.getTitleImgPath().trim().equals(""))
		{
			if(FileUtil.testFileType(activity.getTitleImgPath()) == TalkingUrlType.PICTURE)
			{
				return true;
			}
		}
		if(uploadImage != null
				&& FileUtil.allowfile(uploadImageFileName).equals(
						TalkingUrlType.PICTURE.toString()))
		{
			savepath = FileUtil.copyFile(uploadImage.getAbsolutePath(),
					imagePath);// 将图片上传至服务器
			flage = ImageCutAndZoom.zoom(ServletActionContext
					.getServletContext().getRealPath(savepath));
			if(savepath != null && !savepath.equals("") && flage == true)
			{
				activity.setTitleImgPath(request.getContextPath() + savepath);
				return true;
			}
		}
		return false;
	}
	
	public boolean uploadVideo(Activity activity, File uploadVideo,
			String uploadVideoFileName, String videoPath)
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		String savepath = "";
		if(activity.getVideoUrl() != null
				&& !activity.getVideoUrl().trim().equals(""))
		{
			if(FileUtil.testFileType(activity.getVideoUrl()) == TalkingUrlType.VIDEO)
			{
				return true;
			}
		}
		if(uploadVideo != null
				&& FileUtil.allowfile(uploadVideoFileName).equals(
						TalkingUrlType.VIDEO.toString()))
		{
			savepath = FileUtil.copyFile(uploadVideo.getAbsolutePath(),
					videoPath);// 将视频上传至服务器
			if(savepath != null)
			{
				// 系统根目录为tomcat 根目录，故需要添加网站更目录
				String str = "<embed src='"
						+ request.getContextPath()
						+ "/video/ckplayer/ckplayer.swf?p=0&c=1&i="
						+ request.getContextPath()
						+ "/video/ckplayer/xiaojh.png' "
						+ "flashvars='f="
						+ request.getContextPath()
						+ savepath
						+ "' quality='high' width='480' height='400' align='middle' "
						+ "allowScriptAccess='always' allowFullscreen='true' type='application/x-shockwave-flash'></embed>";
				activity.setVideoUrl(str);
				return true;
			}
		}
		return true;
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean focusClub(Merchant merchant,Club targetClub){
		try{
			if(!exist(targetClub)){
				throw new Exception();
			}else{
				Club c = dao.findById(Club.class, targetClub.getId());
				Merchant m = dao.findById(Merchant.class, merchant.getId());
				m.getFocusClubs().add(c);
				dao.flush();
			}
		}
		catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean cancelFocusClub(Merchant merchant, Club targetClub){
		try{
			if(!exist(targetClub)){
				throw new Exception();
			}else{
				Club c = dao.findById(Club.class, targetClub.getId());
				Merchant m = dao.findById(Merchant.class, merchant.getId());
				m.getFocusClubs().remove(c);
				dao.flush();
			}
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean focusMerchant(Merchant merchant,Merchant target){
		try{
			if(!exist(target)){
				throw new Exception();
			}else{
				Merchant m = dao.findById(Merchant.class, target.getId());
				Merchant sm = dao.findById(Merchant.class, merchant.getId());
				sm.getMerchantsForMerchantId1().add(m);
				dao.flush();
			}
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean cancelFocusMerchant(Merchant merchant,Merchant target){
		try{
			if(!exist(target)){
				throw new Exception();
			}else{
				Merchant m = dao.findById(Merchant.class, target.getId());
				Merchant sm = dao.findById(Merchant.class, merchant.getId());
				sm.getMerchantsForMerchantId1().remove(m);
				dao.flush();
			}
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	public <T> List<T> getFocusList(Class objectClass, Merchant merchant)
	{
		List<T> list = new ArrayList<T>();
		Merchant m = dao.findById(Merchant.class, merchant.getId());
		Set<T> focusSet = null;
		if(objectClass == Club.class){
			focusSet = (Set<T>) m.getFocusClubs();
		}
		else if(objectClass == Merchant.class){
			focusSet = (Set<T>) m.getMerchantsForMerchantId1();
		}
		Iterator<T> it = focusSet.iterator();
		while(it.hasNext())
		{
			list.add(it.next());
		}
		return list;
	}
	
	static Merchant md5Password(Merchant merchant)
	{
		merchant.setPassword(CodeUtil.md5(merchant.getPassword()));
		return merchant;
	}
	@SuppressWarnings("unchecked")
	public List<Merchant> findHeatMerchantByHql()
	{
		Page page=Page.getPage(1, 12, 1);
		return (List<Merchant>) dao.executeHql(page,"from Merchant cl where cl.status='PASSED' order by popularity desc");
	}
}
