package com.tjxjh.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.cafebabe.autodao.dao.BaseDao;
import cn.cafebabe.autodao.pojo.Page;

import com.tjxjh.enumeration.ClubStatus;
import com.tjxjh.enumeration.MerchantStatus;
import com.tjxjh.enumeration.UserStatus;
import com.tjxjh.po.Club;
import com.tjxjh.po.Merchant;
import com.tjxjh.po.User;

@Transactional(readOnly = true)
public abstract class BaseService2
{
	@Resource(name = "dao")
	protected BaseDao dao = null;
	
	protected BaseService2()
	{}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean save(Object object)
	{
		try
		{
			dao.persist(object);
			return true;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return false;
		}
	}
	
	/** 鏍规嵁dao.findByExample鍒ゆ柇 */
	public boolean exist(Object object)
	{
		try
		{
			if(dao.findByExample(object).size() > 0)
			{
				return true;
			}
			return false;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return false;
		}
	}
	
	protected <T> T getFistObjectOfList(List<T> result)
	{
		if(result.size() > 0)
		{
			return result.get(0);
		}
		else
		{
			return null;
		}
	}
	
	public <T> List<T> searchFromName(String text,Page page,Class<T> objectClass){
		List<T> beanList = null;
		try{
			String tableName = objectClass.getSimpleName();
			String hql = null;
			Object objs[] = null;
			hql = "from "+tableName+" b where b.name like ? and b.status = ?";
			if(objectClass == User.class){
				objs = new Object[]{"%"+text+"%",UserStatus.VALIDATED};
			}else if(objectClass == Club.class){
				objs = new Object[]{"%"+text+"%",ClubStatus.PASSED};
			}else if(objectClass == Merchant.class){
				objs = new Object[]{"%"+text+"%",MerchantStatus.PASSED};
			}
			beanList = (List<T>) dao.executeHql(page,hql,objs);
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
		return beanList; 
	}
	public int countItemNum(String text,Class objectClass){
		int itemNum;
		try{
			String tableName = objectClass.getSimpleName();
			String hql = null;
			Object objs[] = null;
			hql = "select count(*) from "+tableName+" b where b.name like ? and b.status = ?";
			if(objectClass == User.class){
				objs = new Object[]{"%"+text+"%",UserStatus.VALIDATED};
			}else if(objectClass == Club.class){
				objs = new Object[]{"%"+text+"%",ClubStatus.PASSED};
			}if(objectClass == Merchant.class){
				objs = new Object[]{"%"+text+"%",MerchantStatus.PASSED};
			}
			List<Long> countL = (List<Long>)dao.executeHql(hql,objs);
			itemNum = countL.get(0).intValue();
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}
		return itemNum;
	}
	public void setDao(BaseDao dao)
	{
		this.dao = dao;
	}
}