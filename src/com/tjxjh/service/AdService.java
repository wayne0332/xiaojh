package com.tjxjh.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.cafebabe.autodao.pojo.Page;
import cn.cafebabe.websupport.service.BaseService;

import com.tjxjh.enumeration.AdvertisementType;
import com.tjxjh.po.Advertisement;
import com.tjxjh.po.AdvertisementContent;

@Service
public class AdService extends BaseService{
	
	public List<Advertisement> adList(Page page){
		return dao.findAll(Advertisement.class, page);
	}
	
	public List<Advertisement> allAdsMap(){
		return dao.findAll(Advertisement.class);
		
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean addAds(Advertisement ads){
		return save(ads);
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean removeAds(int adId){
		Advertisement ads = dao.findById(Advertisement.class, adId);
		return delete(ads);
	}
	
	public List<AdvertisementContent> contentList(int adId){
		return (List<AdvertisementContent>)dao.executeHql("from AdvertisementContent c where c.advertisement.id = ?", adId);
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean addContent(AdvertisementContent content,int adId){
		try {
			Advertisement ads = dao.findById(Advertisement.class, adId);
			if(ads.getType() == AdvertisementType.JS&&ads.getAdvertisementContents().size()>=5){
				return false;
			}
			content.setAdvertisement(ads);
			ads.getAdvertisementContents().add(content);
			dao.flush();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean removeContent(int conId){
		AdvertisementContent c = dao.findById(AdvertisementContent.class, conId);
		return delete(c);
		
	}

}
