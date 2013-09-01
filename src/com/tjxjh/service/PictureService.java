package com.tjxjh.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.opensymphony.xwork2.ActionContext;
import com.tjxjh.po.Picture;
import com.tjxjh.po.Talking;
import com.tjxjh.po.User;

import cn.cafebabe.autodao.pojo.Page;
import cn.cafebabe.websupport.service.BaseService;

@Service
public class PictureService extends BaseService{
	Picture picture;
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean add(Picture pic){
		return super.save(pic);
	}
	
	@Transactional (propagation = Propagation.REQUIRED) 
	public void delete(Picture picture){
		 dao.delete(picture);
	}
	
	@Transactional(readOnly = true, propagation=Propagation.SUPPORTS)   
	public Picture findById(Integer id){
		return dao.findById(Picture.class, id);
	}
	
	@Transactional(readOnly = true, propagation=Propagation.SUPPORTS)   
	public Picture findByHql(Object... params){
		@SuppressWarnings("unchecked")
		List<Picture> list=(List<Picture>) dao.executeHql("from Picture p where p.user.id=? and p.id=?", params);
		if(list.size()!=1)
		{
			return null;
		}
		else
		{
			return list.get(0);
		}
	}
	
	@Transactional (propagation = Propagation.REQUIRED) 
	public Talking update(Talking tak){
		return dao.merge(tak);
	}
	@Transactional (propagation = Propagation.REQUIRED) 
	public Page getAllPageByHql(Integer eachPageNumber,Integer currentPage,Integer totalPageNumber)
	{
		if(currentPage<=0){
			currentPage=1;
		}
		if(totalPageNumber!=0){
			return Page.getPage(currentPage, eachPageNumber, totalPageNumber);
		}
		try{
			Page page=dao.getPageByHql(eachPageNumber,
							"select count(*) from Picture");
			page.setCurrentPage(currentPage);
			return page;
		}catch (Exception e){
			System.out.println("---------PictureService--getAllPageByHql--------"+e);
			return null;
		}
	}
	@Transactional (propagation = Propagation.REQUIRED) 
	public Page getMyPageByHql(User user,Integer eachPageNumber,Integer currentPage,Integer totalPageNumber)
	{
		if(currentPage<=0){
			currentPage=1;
		}
		if(totalPageNumber!=0){
			return Page.getPage(currentPage, eachPageNumber, totalPageNumber);
		}
		try{
			Page page= dao
					.getPageByHql(eachPageNumber,
							"select count(*) from Picture t where t.user.id=? ",user.getId());
			page.setCurrentPage(currentPage);
			return page;
		}catch(Exception e){
			System.out.println("---------PictureService--getMyPageByHql--------"+e);
			return null;
		}
	}
	@SuppressWarnings("unchecked")
	public List<Picture> findMyPictureByHql(Page page,User  user)
	{
		if(page==null){
			return null;
		}
		return (List<Picture>) dao
				.executeHql(
						page,
						"from Picture t where t.user.id=? order by datetime desc",
						user.getId());
	}
	@SuppressWarnings("unchecked")
	public List<Picture> findAllPictureByHql(Page page)
	{
		if(page==null){
			return null;
		}
		return (List<Picture>) dao
				.executeHql(
						page,
						"from Picture t order by datetime desc"
						);
	}
	/*********************************************获取相关用户照片***************************/
	@Transactional (propagation = Propagation.REQUIRED) 
	public Page getRelativeByHql(Integer eachPageNumber,Integer currentPage,Integer totalPageNumber)
	{
		if(currentPage<=0){
			currentPage=1;
		}
		if(totalPageNumber!=0){
			return Page.getPage(currentPage, eachPageNumber, totalPageNumber);
		}
		ActionContext context = ActionContext.getContext();  
	    Map<String, Object> session = context.getSession();
		ArrayList<User> users=(ArrayList<User>) session.get("relativeUsers");
		String Hql="select count(*) from Picture t where 1=1 ";
		StringBuilder str3=new StringBuilder();
		for(User u:users){
			str3.append(u.getId()+",");
		}
		if(str3.length()>0){
			Hql=Hql+"and t.user.id in ("+str3.substring(0, str3.length()-1)+")";
		}
		try{
			Page page=dao.getPageByHql(eachPageNumber,Hql);
			page.setCurrentPage(currentPage);
			return page;
		}catch (Exception e){
			System.out.println("---------PictureService--getAllPageByHql--------"+e);
			return null;
		}
	}
	@SuppressWarnings("unchecked")
	public List<Picture> findRelativePictureByHql(Page page)
	{
		if(page==null){
			return null;
		}
		ActionContext context = ActionContext.getContext();  
	    Map<String, Object> session = context.getSession();
		ArrayList<User> users=(ArrayList<User>) session.get("relativeUsers");
		String Hql="from Picture t where 1=1 ";
		StringBuilder str3=new StringBuilder();
		for(User u:users){
			str3.append(u.getId()+",");
		}
		if(str3.length()>0){
			Hql=Hql+"and t.user.id in ("+str3.substring(0, str3.length()-1)+") order by datetime desc";
		}
		return (List<Picture>) dao
				.executeHql(page,Hql);
	}
	/****************************************************************************************************/
	
	@Transactional(readOnly = true, propagation=Propagation.SUPPORTS)   
	public List<Picture> findAll(Page pageInfo){
		return dao.findAll(Picture.class,pageInfo);
	}
	
	@Transactional(readOnly = true, propagation=Propagation.SUPPORTS)   
	public Page totalCount(Picture picture,Integer eachPageNumber){
		return dao.getPageByExample(picture,eachPageNumber);
	}
	
	@Transactional (propagation = Propagation.REQUIRED) 
	public Picture update(Picture picture){
		return dao.merge(picture);
	}
}
